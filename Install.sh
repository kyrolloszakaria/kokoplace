#!/bin/bash
# ============================================================
# 🐾 Kokoplace Skill Installer
# Usage:
#   ./install.sh                        # interactive menu
#   ./install.sh project-architect      # install specific skill
#   ./install.sh project-architect -p   # install project-locally
#   ./install.sh project-architect -g   # install globally
# ============================================================

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$REPO_DIR/skills"
GLOBAL_INSTALL_DIR="$HOME/.claude/skills"
PROJECT_INSTALL_DIR=".claude/skills"

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Helpers ────────────────────────────────────────────────

print_header() {
  echo ""
  echo -e "${CYAN}${BOLD}🐾 Kokoplace Skill Installer${RESET}"
  echo -e "${CYAN}────────────────────────────${RESET}"
  echo ""
}

# Find all available skills — supports both:
#   skills/my-skill/SKILL.md   (raw folder)
#   skills/my-skill.skill      (.skill zip file)
list_skills() {
  local skills=()

  # Raw folders with a SKILL.md inside
  for dir in "$SKILLS_DIR"/*/; do
    [ -f "$dir/SKILL.md" ] && skills+=("$(basename "$dir")")
  done

  # .skill zip files
  for file in "$SKILLS_DIR"/*.skill; do
    [ -f "$file" ] || continue
    local name
    name="$(basename "$file" .skill)"
    # Avoid duplicates if both a folder and .skill exist
    [[ " ${skills[*]} " == *" $name "* ]] || skills+=("$name")
  done

  echo "${skills[@]}"
}

# Detect source type for a given skill name
get_skill_source() {
  local name="$1"
  if [ -f "$SKILLS_DIR/$name.skill" ]; then
    echo "zip"
  elif [ -d "$SKILLS_DIR/$name" ] && [ -f "$SKILLS_DIR/$name/SKILL.md" ]; then
    echo "folder"
  else
    echo "none"
  fi
}

# Get description from a SKILL.md (works for both folder and zip)
get_description() {
  local name="$1"
  local source
  source=$(get_skill_source "$name")
  local desc=""

  if [ "$source" = "folder" ]; then
    desc=$(awk '/^description:/,/^[a-z]/' "$SKILLS_DIR/$name/SKILL.md" 2>/dev/null | \
           head -3 | grep -v "^description:" | grep -v "^[a-z]" | \
           sed 's/^[[:space:]]*//' | tr -d '>' | head -1 | cut -c1-55)
  elif [ "$source" = "zip" ]; then
    desc=$(unzip -p "$SKILLS_DIR/$name.skill" "*/SKILL.md" 2>/dev/null | \
           awk '/^description:/,/^[a-z]/' | \
           head -3 | grep -v "^description:" | grep -v "^[a-z]" | \
           sed 's/^[[:space:]]*//' | tr -d '>' | head -1 | cut -c1-55)
  fi

  echo "$desc"
}

show_menu() {
  local skills=($(list_skills))

  if [ ${#skills[@]} -eq 0 ]; then
    echo -e "${RED}No skills found in ./skills/${RESET}"
    echo -e "Add ${BOLD}.skill${RESET} files or skill folders to ${BOLD}./skills/${RESET} and try again."
    echo ""
    exit 1
  fi

  echo -e "${BOLD}Available skills:${RESET}"
  echo ""
  for i in "${!skills[@]}"; do
    local name="${skills[$i]}"
    local source
    source=$(get_skill_source "$name")
    local desc
    desc=$(get_description "$name")
    local type_label=""
    [ "$source" = "zip" ] && type_label="${CYAN}[.skill]${RESET} "

    printf "  ${CYAN}[%d]${RESET} ${BOLD}%-26s${RESET}%b%s\n" \
      "$((i+1))" "$name" "$type_label" "${desc}..."
  done

  echo ""
  echo -e "  ${CYAN}[a]${RESET} Install ${BOLD}all${RESET} skills"
  echo -e "  ${CYAN}[q]${RESET} Quit"
  echo ""
  read -r -p "Select a skill to install: " choice

  case "$choice" in
    q|Q) echo "Bye! 👋"; exit 0 ;;
    a|A) SELECTED_SKILLS=("${skills[@]}") ;;
    ''|*[!0-9]*)
      echo -e "${RED}Invalid choice.${RESET}"; exit 1 ;;
    *)
      local idx=$((choice - 1))
      if [ $idx -lt 0 ] || [ $idx -ge ${#skills[@]} ]; then
        echo -e "${RED}Invalid choice.${RESET}"; exit 1
      fi
      SELECTED_SKILLS=("${skills[$idx]}")
      ;;
  esac
}

choose_scope() {
  echo ""
  echo -e "${BOLD}Install scope:${RESET}"
  echo ""
  echo -e "  ${CYAN}[1]${RESET} ${BOLD}Global${RESET}  — available in all your projects  (~/.claude/skills/)"
  echo -e "  ${CYAN}[2]${RESET} ${BOLD}Project${RESET} — only for the current directory   (.claude/skills/)"
  echo ""
  read -r -p "Choose [1/2]: " scope_choice

  case "$scope_choice" in
    1) INSTALL_DIR="$GLOBAL_INSTALL_DIR" ;;
    2) INSTALL_DIR="$PROJECT_INSTALL_DIR" ;;
    *) echo -e "${RED}Invalid choice.${RESET}"; exit 1 ;;
  esac
}

install_skill() {
  local skill_name="$1"
  local install_dir="$2"
  local source
  source=$(get_skill_source "$skill_name")

  if [ "$source" = "none" ]; then
    echo -e "${RED}✗ Skill '${skill_name}' not found in ./skills/${RESET}"
    return 1
  fi

  local dest="$install_dir/$skill_name"
  mkdir -p "$dest"

  if [ "$source" = "zip" ]; then
    # Unzip .skill file into a temp dir, then flatten into dest
    local tmp="$install_dir/_kokoplace_tmp_$$"
    mkdir -p "$tmp"
    unzip -q -o "$SKILLS_DIR/$skill_name.skill" -d "$tmp"
    # The zip contains a top-level folder — find and flatten it
    local inner
    inner=$(ls "$tmp" | head -1)
    if [ -d "$tmp/$inner" ]; then
      cp -r "$tmp/$inner/." "$dest/"
    else
      cp -r "$tmp/." "$dest/"
    fi
    rm -rf "$tmp"
    echo -e "${GREEN}✓ Installed${RESET} ${BOLD}${skill_name}${RESET} (unzipped from .skill) → ${dest}"
  else
    cp -r "$SKILLS_DIR/$skill_name/." "$dest/"
    echo -e "${GREEN}✓ Installed${RESET} ${BOLD}${skill_name}${RESET} (from folder) → ${dest}"
  fi
}

# ── Main ───────────────────────────────────────────────────

print_header

# Parse args
SKILL_ARG=""
SCOPE_FLAG=""
for arg in "$@"; do
  case "$arg" in
    --project|-p) SCOPE_FLAG="project" ;;
    --global|-g)  SCOPE_FLAG="global" ;;
    -*) echo -e "${RED}Unknown flag: $arg${RESET}"; exit 1 ;;
    *)  SKILL_ARG="$arg" ;;
  esac
done

# Determine which skills to install
if [ -n "$SKILL_ARG" ]; then
  SELECTED_SKILLS=("$SKILL_ARG")
else
  show_menu
fi

# Determine install scope
if [ "$SCOPE_FLAG" = "project" ]; then
  INSTALL_DIR="$PROJECT_INSTALL_DIR"
elif [ "$SCOPE_FLAG" = "global" ]; then
  INSTALL_DIR="$GLOBAL_INSTALL_DIR"
else
  choose_scope
fi

# Run installs
echo ""
for skill in "${SELECTED_SKILLS[@]}"; do
  install_skill "$skill" "$INSTALL_DIR"
done

echo ""
echo -e "${GREEN}${BOLD}Done!${RESET} Claude Code picks up skill changes automatically — no restart needed."
echo ""
echo -e "${YELLOW}Tip:${RESET} To update a skill later, just run this script again."
echo ""

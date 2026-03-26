# 🐾 Kokoplace

> Koko's curated marketplace of Claude skills — built for real development workflows.

---

## What is this?

Kokoplace is a personal collection of [Claude Skills](https://support.claude.com/en/articles/12512180-use-skills-in-claude) — modular context packages that teach Claude how to do specialized tasks, automatically, without repeating yourself every session.

Each skill is a folder with a `SKILL.md` file. Claude reads it when relevant and follows the instructions inside. No prompting required.

---

## 📦 Skills

### 🏗️ `project-architect`
**Onboard Claude to any codebase in one command.**

When you open a new project, this skill spawns a master agent that surveys the entire codebase, then spins up domain expert sub-agents — one per logical area (frontend, backend, database, auth, etc.). Each sub-agent deeply reads its domain and produces a frozen context snapshot.

The result is a set of files committed to your repo:

```
your-project/
├── PROJECT_ARCHITECTURE.md        ← full map, for cross-domain work
├── CLAUDE.md                      ← lean session index (~200 tokens)
└── .claude/
    └── agents/
        ├── frontend-agent.md      ← load when touching UI
        ├── backend-agent.md       ← load when touching API
        └── ...                    ← one per domain
```

**Token-efficient by design:** Claude only loads `CLAUDE.md` automatically (~200 tokens). Agent files are loaded on demand, one at a time, only when your task touches that domain.

**Triggers:** *"onboard me to this project"*, *"I just cloned this repo"*, *"analyze this codebase"*, *"set up project context"*

→ [View skill](skills/project-architect/)

### 📝 `researcher`
**Write publication-ready LaTeX papers for ACM ICMI 2026 (and similar conferences).**

This skill turns Claude into an academic co-author that works incrementally alongside your research project. It reads your codebase, experiment logs, and existing `Paper.tex` (from Overleaf), then writes or improves sections in proper ACM `sigconf` LaTeX — with human-quality prose that doesn't read like AI output.

Key capabilities:
- **Incremental writing** — improves existing content on each invocation, marks incomplete areas with `% TODO` comments
- **Overleaf-native** — preprocesses your Overleaf project, auto-detects the right compiler (pdfLaTeX/XeLaTeX/LuaLaTeX), and compiles to verify
- **Conference-aware** — tone calibration per section, ACM citation style (`\citet`/`\citep`), `booktabs` tables, proper `\Description{}` tags
- **Proactive revisions** — flags stale results, code-paper drift, and structural issues
- **Ethics & Broader Impact** — guidance tied to the ICMI 2026 theme ("Context and Cultural Awareness for Multimodal Interaction")

Bundled references: `icmi2026-latex.md` (template + submission details) and `paper-structure.md` (section-by-section writing guide).

**Triggers:** *"write my paper"*, *"help with the introduction"*, *"ICMI submission"*, *"turn this project into a paper"*, *"update the results section"*

→ [Download skill](skills/researcher.skill)

---

## 🚀 Installation

### Claude.ai (web/desktop)
1. Go to **Customize → Skills**
2. Make sure **Code execution** is enabled in **Settings → Capabilities**
3. Upload the `.skill` file for any skill you want

### Claude Code (terminal)
```bash
# Personal — available across all your projects
unzip project-architect.skill -d ~/.claude/skills/project-architect/

# Or project-specific — only for one repo
unzip project-architect.skill -d .claude/skills/project-architect/
```

---

## 📥 Download Skills

| Skill | Download | Description |
|-------|----------|-------------|
| project-architect | [⬇ .skill](skills/project-architect.skill) | Multi-agent project onboarding |
| researcher | [⬇ .skill](skills/researcher.skill) | ACM ICMI 2026 LaTeX paper writing |

---

## 🛠️ How Skills Work

Skills use a three-level loading system that keeps token usage minimal:

1. **Metadata** (name + description) — always in context, ~100 tokens
2. **SKILL.md body** — loaded when Claude decides the skill is relevant
3. **Bundled resources** — loaded only when needed by the skill

Claude scans skill descriptions automatically and loads the right one based on what you're asking. You don't need to invoke them manually.

---

## 🤝 Contributing

Have a skill idea? Open an issue or submit a PR. Skills are just markdown — if you can write instructions, you can write a skill.

Structure of a skill:
```
skills/
└── your-skill-name/
    ├── SKILL.md          ← required: frontmatter + instructions
    ├── references/       ← optional: docs, templates
    └── agents/           ← optional: sub-agent briefs
```

Minimum viable `SKILL.md`:
```markdown
---
name: your-skill-name
description: When and why Claude should use this skill. Be specific.
---

# Your Skill

Instructions Claude will follow when this skill is active.
```

---

## 📄 License

Skills in this repo are released under the MIT License unless otherwise noted.

---

*Built by Koko • Powered by [Claude](https://claude.ai)*

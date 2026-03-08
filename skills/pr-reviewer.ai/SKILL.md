---
name: pr-reviewer
description: >
  Use this skill whenever the user wants a code review, PR review, or diff analysis.
  Triggers include: "review this PR", "review my changes", "check my diff", "what do you
  think of these changes", "code review", "review before I push", "look at this branch",
  or any reference to pull requests, merge requests, diffs, or code changes that need
  feedback. Also trigger when the user mentions maintaining review history, tracking
  recurring issues, generating changelogs from changes, or wants to set up review
  conventions for a project. If a PROJECT_ARCHITECTURE.md exists (from the project-architect
  skill), this skill leverages it for architecture-aware reviews. Always use this skill
  for review tasks — don't do a quick one-off scan without the structured multi-pass approach.
---

# PR Reviewer Skill

An architecture-aware, multi-pass code review system that produces structured review
artifacts and learns from recurring patterns over time.

## Why this exists

Quick one-pass reviews catch surface issues but miss architectural violations, security
gaps, and recurring mistakes. This skill runs multiple focused analysis passes, connects
changes to the project's architecture (when available), and maintains a living record of
review patterns so the project builds institutional review memory.

---

## Workflow Overview

When triggered, follow these steps in order:

1. **Gather context** — load architecture context and review history
2. **Collect the diff** — get the actual changes to review
3. **Run multi-pass analysis** — security, logic, style, performance
4. **Produce the review file** — structured findings with severity levels
5. **Update living documents** — patterns file and changelog draft
6. **Present results** — summary to the user with actionable next steps

---

## Step 1: Gather Context

### Architecture context (if available)

Check for `PROJECT_ARCHITECTURE.md` in the project root. If it exists, read it to
understand the project's domain boundaries, conventions, and component responsibilities.
This transforms the review from syntax-level to architecture-level — you can catch things
like "this new route bypasses the auth middleware that all other routes use" or "this
query belongs in the data layer, not the controller."

If domain-specific context files exist (from the project-architect skill), identify which
domains the changed files belong to and load only those context files. Don't load all of
them — stay token-efficient.

### Review history

Check for `.reviews/PATTERNS.md` in the project root. If it exists, read it before
starting the review. This file contains recurring issues seen in past reviews. Use it to
specifically watch for known problem patterns in the current changes.

Check for `.reviews/config.yaml`. If it exists, load the review configuration (strictness
level, ignored paths, custom rules). If it doesn't exist, use sensible defaults.

### First run setup

If `.reviews/` doesn't exist yet, create the directory structure:

```
.reviews/
├── config.yaml
├── PATTERNS.md
└── (review files will go here)
```

Create `config.yaml` with these defaults — read `references/default-config.yaml` for the
template. Create `PATTERNS.md` with an empty initial structure — read
`references/patterns-template.md` for the template.

---

## Step 2: Collect the Diff

Determine what changes to review based on the user's request:

**If the user specifies a PR number or branch:**
```bash
# For a branch comparison
git diff main...<branch-name>

# For staged changes
git diff --cached

# For unstaged changes
git diff
```

**If the user says "review my changes" without specifics:**
Try this priority order:
1. `git diff --cached` (staged changes — most likely what they want reviewed before commit)
2. `git diff` (unstaged changes)
3. `git log -1 --format="%H" | xargs git diff HEAD~1` (last commit)

Ask the user to clarify only if all three are empty.

**Collect file-level summary too:**
```bash
git diff --stat <range>
```

This gives you an overview of which files changed and how much — useful for the review
summary and for deciding which architecture domains are affected.

---

## Step 3: Multi-Pass Analysis

Run these passes over the diff. Each pass has a specific focus — this prevents the review
from becoming a shallow scan that tries to catch everything at once.

### Pass 1: Security & Vulnerability Scan

Focus exclusively on:
- Injection risks (SQL, command, XSS, template injection)
- Authentication/authorization gaps (missing middleware, exposed endpoints)
- Secret/credential exposure (hardcoded keys, tokens, passwords)
- Unsafe deserialization or file handling
- Dependency changes that introduce known-vulnerable packages
- CORS, CSRF, or header misconfigurations

If the architecture context shows an auth layer or security middleware, verify that new
routes/endpoints properly use it.

### Pass 2: Logic & Correctness

Focus exclusively on:
- Off-by-one errors, boundary conditions, edge cases
- Null/undefined handling — does the code handle missing data?
- Race conditions or concurrency issues
- Error handling — are errors caught, logged, and handled gracefully?
- State management — does the change leave state consistent?
- API contract violations — does the change break existing interfaces?
- Test coverage — are new code paths tested? Are existing tests still valid?

### Pass 3: Style & Consistency

Focus exclusively on:
- Naming conventions — do new names follow existing patterns?
- Code organization — is new code in the right place architecturally?
- Import/dependency patterns — does the change follow existing patterns?
- Comment quality — are complex sections explained?
- Dead code — does the change leave behind unused code?
- Duplication — does the change duplicate logic that exists elsewhere?

If `config.yaml` has custom rules, apply them here.

### Pass 4: Performance & Scalability

Focus exclusively on:
- N+1 queries or unbounded database operations
- Missing pagination on list endpoints
- Memory leaks (unclosed connections, event listener buildup)
- Unnecessary re-renders (in frontend code)
- Large payload sizes or missing compression
- Missing caching where appropriate
- Algorithm complexity — is there a simpler approach?

### After all passes

Assign each finding a severity:

- **critical** — Must fix before merge. Security vulnerabilities, data loss risks,
  breaking changes to public APIs.
- **warning** — Should fix, but not a blocker. Logic errors, missing edge cases,
  performance concerns.
- **suggestion** — Nice to have. Style improvements, minor refactors, documentation.
- **nit** — Trivial. Formatting, naming preferences, minor style points.

---

## Step 4: Produce the Review File

Determine the review filename. If the user mentioned a PR number, use it:
`.reviews/PR-{number}.md`. Otherwise, use the current date and a short slug:
`.reviews/review-{YYYY-MM-DD}-{slug}.md`.

Read `references/review-template.md` for the exact output format. The template includes:
- Header with metadata (date, branch, files changed, reviewer config)
- Summary — 2-3 sentence overview of what the PR does and overall assessment
- Findings organized by severity (critical first, nits last)
- Each finding includes: file path, line reference, description, and suggested fix
- A "What's Good" section — explicitly call out things done well
- Verdict — approve, request changes, or needs discussion

Write the review file to `.reviews/`.

---

## Step 5: Update Living Documents

### Update PATTERNS.md

After completing the review, check if any findings represent recurring themes. Read the
current `PATTERNS.md` and decide:

- **New pattern**: If a finding matches something you've seen structurally (not just this
  PR but the kind of mistake that tends to recur), add it to PATTERNS.md with a
  description and example.
- **Reinforce existing pattern**: If a finding matches an existing pattern, increment its
  occurrence count and add this PR as a reference.
- **Don't over-add**: Only add patterns that represent structural/systemic issues. A
  one-off typo is not a pattern. A tendency to forget null checks on API responses IS a
  pattern.

### Generate CHANGELOG_DRAFT.md

Based on the diff, generate or append to `.reviews/CHANGELOG_DRAFT.md`:
- Categorize changes (Added, Changed, Fixed, Removed, Security, Deprecated)
- Write entries from the user's perspective, not the code's perspective
- Keep entries concise — one line per change
- If CHANGELOG_DRAFT.md already exists, append under today's date

---

## Step 6: Present Results

Give the user a concise summary in the conversation:

1. **Verdict** — approve / request changes / needs discussion
2. **Critical/warning count** — "Found 2 critical issues and 3 warnings"
3. **Top findings** — mention the 2-3 most important things briefly
4. **Positive callouts** — mention 1-2 things done well
5. **File reference** — point them to the full review file

Don't dump the entire review into the chat — that's what the file is for. The chat summary
should be scannable in 10 seconds.

---

## Configuration Reference

The `config.yaml` supports these options (see `references/default-config.yaml` for the
full annotated template):

- `strictness`: `strict` | `standard` | `relaxed` — controls how aggressively to flag
  issues. Use `strict` for production repos, `relaxed` for prototypes/experiments.
- `ignored_paths`: list of glob patterns to skip (e.g., `*.generated.ts`, `vendor/`)
- `custom_rules`: project-specific rules to check (e.g., "no direct DB queries outside
  `src/data/`", "all API routes must use `authMiddleware`")
- `focus_areas`: override which passes to run (default: all four)
- `changelog_style`: `keep-a-changelog` | `conventional` | `simple`

---

## Edge Cases

**Very large diffs (>500 lines changed):**
Focus the detailed analysis on the most impactful files. Provide file-level commentary
for the rest. Mention in the review that a focused approach was taken due to diff size.

**No git repository:**
If the user provides files or code directly (not in a git repo), skip the git-based diff
collection and review what's provided. Skip changelog generation. Still produce a review
file if there's a writable directory.

**Multiple PRs / batch review:**
If asked to review multiple PRs, produce a separate review file for each. Update
PATTERNS.md once at the end with any cross-PR observations.

---

## Integration with project-architect

This skill is designed to work alongside the `project-architect` skill. When both are
present:

- project-architect provides the architectural understanding
- pr-reviewer uses that understanding to catch architectural violations
- Patterns discovered during reviews can inform future architecture documentation

If reviewing changes that affect the project's architecture (new modules, changed
interfaces, restructured domains), note in the review that `PROJECT_ARCHITECTURE.md` may
need updating.

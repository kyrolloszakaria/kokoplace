# Code Review: [PR title or short description]

| Field           | Value                          |
|-----------------|--------------------------------|
| **Date**        | YYYY-MM-DD                     |
| **Branch**      | feature-branch → main          |
| **Files changed** | N files (+additions, -deletions) |
| **Strictness**  | standard                       |
| **Reviewer**    | Claude (pr-reviewer skill)     |

---

## Summary

<!-- 2-3 sentences: what does this PR do, and what's the overall assessment? -->

---

## Verdict: **[APPROVE / REQUEST CHANGES / NEEDS DISCUSSION]**

<!-- One-line rationale for the verdict -->

---

## Findings

### Critical

<!-- Must fix before merge. Security vulnerabilities, data loss, breaking changes. -->
<!-- If none: _No critical issues found._ -->

<!--
#### [C1] Short title
- **File**: `path/to/file.ts:42`
- **Issue**: Description of what's wrong and why it matters.
- **Suggestion**: How to fix it, with code if helpful.
-->

### Warnings

<!-- Should fix. Logic errors, missing edge cases, performance issues. -->

### Suggestions

<!-- Nice to have. Style improvements, refactors, documentation. -->

### Nits

<!-- Trivial. Formatting, naming preferences. -->

---

## What's Good

<!-- Explicitly call out 2-3 things done well. Good patterns, clean abstractions,
     thorough tests, clear naming. This matters — positive reinforcement helps
     establish good conventions. -->

---

## Architecture Notes

<!-- Only if PROJECT_ARCHITECTURE.md exists. Note any architectural observations:
     - Does this change respect domain boundaries?
     - Are interfaces between components used correctly?
     - Does PROJECT_ARCHITECTURE.md need updating after this change?
     If no architectural concerns: _Changes align with the documented architecture._ -->

---

## Changelog Entry (Draft)

<!-- Auto-generated changelog entry for this PR. Copy to your changelog if useful. -->

### [YYYY-MM-DD]

#### Added
- 

#### Changed
- 

#### Fixed
- 

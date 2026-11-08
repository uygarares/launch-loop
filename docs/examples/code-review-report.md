# Code review report: Launch Loop (reviewing itself)

- **Skill:** `launch-loop-code-review`, full review
- **Date:** 2026-11-08
- **Reviewed version:** commit `d0beba5`
- **Repository:** public (MIT)
- **Plan shown first:** 19 files, 942 lines, about 11,000 tokens per read. Six angles plus the judge came to about 80,000 tokens in total: **Small**.

## Findings

| Severity | File and line | What is wrong | Suggested fix |
|---|---|---|---|
| **Medium** | `.github/workflows/check-skills.yml` | The automatic check only runs on Linux. The Windows installer `install.ps1` has never been run by anyone, although the README tells Windows users to use it. | Add a macOS job and a Windows job that run the installer. |
| Low | `CHANGELOG.md` | Changes made after v0.1.0 (installers, automatic checks, pull request review mode, new safety rules) are not listed. | Add an "Unreleased" section. |
| Low | `docs/design/code-review.md` | The design notes still describe two modes and do not mention the pull request mode or the rules for public repositories. Searching the file for "pull request" and "public" finds nothing. | Update the notes. |
| Low | repository root | There is no `CODE_OF_CONDUCT.md`. | Add a short one and link it from `CONTRIBUTING.md`. |

## Dropped by the judge

- **"The checker may fail on Windows line endings (CRLF)."** The judge tested this with a CRLF file. The checker handled it correctly, so the finding was dropped.

## What looked good

- All five skills have a valid name that matches the folder, a short description, a rules section and a "Language" section.
- The install scripts quote their paths and only copy the skill folders.
- The README, CONTRIBUTING, SECURITY and issue templates agree with each other.

## Not checked

- The skills were not run inside Codex or Claude Code by a second person.
- Repository settings on GitHub (for example branch protection) were not checked.
- The Windows installer was not run during the review.

This is not a full security audit.

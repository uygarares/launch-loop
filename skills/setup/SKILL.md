---
name: launch-loop-setup
description: Use when someone is creating a new open source project and needs the basic files: README, LICENSE, CONTRIBUTING, and issue templates. Works for empty or nearly empty repositories.
---

# Project Setup

Create the files a new open source project needs so that other people can understand, use, and contribute to it.

## Before writing anything, ask

1. What does the project do, in one sentence?
2. Who is it for?
3. Which license? If they are unsure, suggest MIT for permissive use or AGPL-3.0 if they want improvements to a hosted version to stay open.
4. How do people run it? (install command, first command to try)

Do not invent answers. If something is missing, ask.

## Files to create

- **README.md:** Title, one-sentence description, who it is for, install steps, a minimal example, and a "Contributing" link.
- **LICENSE:** The full text of the chosen license, with the current year and the author's name.
- **CONTRIBUTING.md:** How to report a bug, how to propose a change, and what a good pull request looks like.
- **.github/ISSUE_TEMPLATE/bug_report.md** and **feature_request.md:** Short templates asking for steps to reproduce and expected behavior.

## Checks before finishing

- Every install command in the README has been run once, or is marked as untested.
- No personal data (addresses, phone numbers, private keys, IDs) appears in any file.
- A `.gitignore` exists that excludes secrets such as `.env`.

## Tell the user

List the files created and the one thing they must check themselves, usually the license choice and the author name.

---
name: launch-loop-setup
description: Use when someone is creating a new open source project and needs the basic files: README, LICENSE, CONTRIBUTING, and issue templates. Works for empty or nearly empty repositories.
---

# Project Setup

Create the files a new open source project needs so that other people can understand, use, and contribute to it.

## Step 1: Ask before writing anything

Ask these questions and wait for the answers. Do not guess.

1. What does the project do, in one sentence?
2. Who is it for?
3. Is this project only for personal use, or will other people use or copy it?
   - Personal use only: no license is needed. Say so in the README ("Private. All rights reserved.") and skip the LICENSE file.
   - Other people will use it: present these three options equally, in plain language, without recommending one. Wait for the user to choose.
     1. MIT: anyone can use, change, and sell it. The only condition is keeping the license text.
     2. Apache 2.0: similar to MIT, plus protection for patent rights. Longer text.
     3. AGPL-3.0: anyone who changes it and runs it as a website must also publish their changes. Prevents closed copies.
4. How do people install and try it? (install command, first command to run, or how to install the app on a phone)

If an answer is missing or unclear, ask again. Never write a description or feature list that the user has not confirmed.

## Step 2: Check for secrets and personal information

Before creating or publishing anything, scan the project for:
- Signing keys and keystores (`*.keystore`, `*.jks`, `*.p12`, `*.pem`)
- Environment files (`.env`, `.env.*`)
- API keys and tokens (strings that look like `AIza...`, `sk-...`, or `password = "..."`)
- Personal information (email addresses, phone numbers, home addresses)

If anything is found:
- Do not copy it into any new file.
- Tell the user the file name and line, in plain words.
- Say clearly that the user must rotate or restrict any exposed key before making the repository public. This step is the user's, not the skill's.

## Step 3: Create the files

- **README.md:** Title, one-sentence description (from Step 1), who it is for, install steps, a minimal example, and a "Contributing" link.
- **LICENSE:** Only if the project is public. The full text of the chosen license, with the current year and the author's name.
- **CONTRIBUTING.md:** How to report a bug, how to propose a change, and what a good pull request looks like.
- **.github/ISSUE_TEMPLATE/bug_report.md** and **feature_request.md:** Short templates asking for steps to reproduce and expected behavior.
- **.gitignore:** Must exclude `.env*`, `*.keystore`, `*.jks`, `*.p12`, `*.pem`, and build folders.

## Step 4: Checks before finishing

- Every install command in the README has been run once, or is marked as untested.
- No secrets or personal information appear in any file.
- The README contains only facts the user confirmed in Step 1.

## Step 5: Tell the user

- List the files created.
- List anything from Step 2 that the user must handle themselves.
- Ask the user to review the README before publishing.

## Rules

- Never push to a repository without the user's approval.
- Never make a private repository public.

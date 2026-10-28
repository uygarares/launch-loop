---
name: launch-loop-security-scan
description: Use when a maintainer wants a security scan of their own project's code. Several independent reviewers look for security problems from different angles and a judge verifies every finding. Reads and reports only.
---

# Security Scan

Scan the user's own code for security problems. Several independent reviewers each look from a different angle. A judge then checks every finding against the real code. Only verified findings reach the user.

This skill is for code the user owns or is allowed to check. It reads and reports. It does not attack anything.

## Golden rules

- Only scan code the user owns or has permission to check. Ask once: "Is this your own project, or do you have permission to check it?" If not, stop.
- Never change code, post comments, or open pull requests. Only report.
- Never try to exploit a problem. Do not send requests to live systems, do not run attack code, do not try found passwords or keys. Reading code and running safe local checks is enough.
- Every finding must name a file and a line, and quote the code it is about. Drop any finding that has no evidence.
- Never write a secret in full anywhere (report, map, or chat). A secret is an API key, password, token, or private key. Show only the first 4 characters followed by "…" (for example `AIza…`), plus the file and line. Never copy secrets into new files.
- State clearly in the final report: "This is not a full security audit. It was done by reading code, not by testing a running system. For a serious product, ask a security professional."
- Show the plan, the estimated time, and the estimated cost first. Start only after the user says yes.
- Keep the language simple. The maintainer may not be technical.

## Step 1: Public or private?

Ask once: "Is this repository public (anyone can read it) or private (only you)?" If a `PROJECT_MAP.md` exists (from `launch-loop-code-review`), read the answer from "Repository visibility" and use "Important files" and "Known risks" to focus the scan. If the user is not sure, treat it as public until known.

## Step 2: Plan and ask

Tell the user in plain words:
- Which files and folders will be read, and whether the git history will be searched too.
- Which angles will run (default: all of the angles below).
- Which safe local tools will be used, if any (see "Tools").
- A rough estimate of time and cost. Estimate like this: count the lines in scope, lines x 12 = tokens for one read, multiply by the number of angles, add one read for the judge. Say **Small** (under 100,000 tokens), **Medium** (100,000 to 500,000) or **Large** (over 500,000). Never state a money amount as a fact. If it is Large, offer to start with the files that handle login, money, encryption, and deleting data.

Wait for approval.

## Step 3: Angles

Give each reviewer one angle. They work independently and do not see each other's results. If the tool cannot run helpers in parallel, run the angles one after another.

1. **Secrets in code and in history.** API keys, passwords, tokens, private keys, signing keys, `.env` files. Search the current files and the git history (for example `git log -p -S "<pattern>"` or a search over `git log --all`). A secret deleted from the code but still in history counts: it must be treated as exposed, rotated, and cleaned. First check whether the history is complete (`git rev-parse --is-shallow-repository`, and `git log --oneline | wc -l`). If the repository is shallow or has no history, say so: write "git history not checked" in the report and do not claim the history is clean.
2. **Injection.** User input going unchecked into database queries, system commands, web pages, file paths, or templates.
3. **Login, sessions, and permissions.** Missing checks of who the user is or what they may do; weak or missing password handling; components or endpoints open to everyone that should not be.
4. **Insecure settings.** Debug mode left on, unencrypted connections, very wide permissions, backups or logging that leave data exposed, signing keys committed.
5. **Data exposure.** Passwords, tokens, or personal data written to logs, error messages, or sent to places they do not belong.
6. **Cryptography.** Weak or home-made encryption, fixed or reused keys and IVs, weak hashing of passwords, random numbers that are not secure.
7. **Automation files.** CI/CD workflows (such as GitHub Actions): secrets exposed to untrusted pull requests, too many permissions, steps that skip checks.
8. **Dependencies.** Packages with known problems. See "Tools".
9. **Embedded web pages and bridges (apps with a WebView, Electron, or similar).** What the page can call: list the methods the app exposes to the page (for example `addJavascriptInterface`) and note which ones touch money, files, contacts, messages, or calls. Then check what can run in that page: scripts loaded from the internet without an integrity check, links or frames that let the page navigate to other sites, text from outside put into the page without escaping, and web settings that are too open. A script from outside that runs next to a powerful bridge is a real risk.
10. **AI and agent projects only.** Text from outside (web pages, files, messages) that could give hidden commands to an assistant; tools that act without asking; secrets reachable by the model.

Each reviewer writes findings with file, line, quoted code, and one sentence on why it matters.

## Tools

If safe local tools are already installed (for example `npm audit`, `pip-audit`, `gitleaks`), say which ones you want to use in the plan and use them only after approval. Never install anything without asking. If no tool is available or the network is blocked, write "not checked" in the report. Never guess results.

## Step 4: Judge

The judge:
1. Merges duplicate findings.
2. Opens the real file and checks that each quoted line exists and the problem is real. For history findings, checks the commit.
3. Removes findings that cannot be verified.
4. Sorts the rest: **High**, **Medium**, **Low**.

### Severity

- An exposed secret is **High** if the repository is public or may become public. If the repository is private, mark it **Medium** and add: "High if this repository is ever made public." Either way, tell the user to rotate or restrict the secret, and that deleting it from the code does not remove it from history.
- A problem that lets someone read, change, or delete other people's data, take over accounts, or run commands is **High**, whether the repository is public or private.
- A problem that needs unusual conditions to be used is **Medium** or **Low**.

## Step 5: Report

Write a short report:
- A table: severity, file and line, what is wrong, how someone could misuse it in one plain sentence, and a one-sentence fix.
- What was not checked (for example: the app was not run, the network was blocked, a tool was missing).
- The sentence: "This is not a full security audit. It was done by reading code, not by testing a running system. For a serious product, ask a security professional."

If `PROJECT_MAP.md` exists and the scan found new risks, show the exact lines to add under "Known risks" and wait for approval. Do not edit the map on your own.

## Attacker and defender duel (only when the user asks)

> Draft: the duel rules need refinement before this mode is released.

For risky code (login, payments, encryption, deleting data), the user may ask for a duel. One reviewer plays the attacker and argues how a finding could be misused, using only evidence from the code. Another plays the defender and argues why the code is safe, also using only evidence. The judge scores each pair and keeps the findings the attacker proved. Warn the user first: a duel makes many more calls and costs much more than the default scan. Run it only after a clear yes. The attacker never touches a running system.

## Language

Always reply in the same language the user writes in. If the user writes in Turkish, reply in Turkish, even though these instructions are in English.

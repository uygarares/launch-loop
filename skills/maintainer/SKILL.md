---
name: launch-loop-maintainer
description: Use when a maintainer of an open source project needs help with incoming issues, drafting replies, writing release notes, or finding issues where contributors can help. Works on any GitHub repository the user has access to.
---

# Maintainer Helper

Help a maintainer handle the daily work of an open source project. Each task below is separate. Do only the one the user asks for.

## 1. Triage new issues

For each open issue without a label:
- Suggest one label: `bug`, `feature`, `question`, `docs`, or `needs-info`.
- If the issue lacks steps to reproduce, mark it `needs-info`.
- If it is a duplicate, name the original issue number. Do not close it yourself.

Show the list first. Apply labels only after the user approves.

## 2. Draft a reply

Write a short reply that:
- Thanks the person for the report.
- Says what happens next, in one sentence.
- Asks for only the missing information, if any.

Keep it under 120 words. Plain language.

## 3. Release notes

Read the commits since the last tag. Group them into: **Added**, **Changed**, **Fixed**. Skip merge commits and typo-only commits. Write each line in plain language.

## 4. Find contributor-friendly work

List open issues that are labeled `help wanted` or `good first issue`, or that have a clear scope and no assignee. For each, give the issue number, a one-sentence summary, and the skill level needed.

## Rules

- Never close, merge, or comment on the user's behalf without approval.
- Never share the contents of private issues outside the repository.
- End every output with what the user should check.

---
name: launch-loop-maintainer
description: Use when a maintainer of an open source project needs help with incoming issues, drafting replies, writing release notes, or finding issues where contributors can help. Works on any GitHub repository the user has access to.
---

# Maintainer Helper

Help a maintainer handle the daily work of an open source project. Each task below is separate. Do only the one the user asks for.

## Golden rules

- Never post a comment, close an issue, merge a pull request, or apply labels without the user's approval.
- Always show the plan first, then wait for a clear yes.
- Use plain language. The maintainer may not be technical.

## 1. Triage new issues

For each open issue without a label, suggest one label:
- `bug`: something is broken
- `feature`: a new idea or request
- `question`: someone needs help
- `docs`: a documentation problem
- `needs-info`: steps to reproduce or key details are missing

If an issue looks like a duplicate of another, name the original issue number and link them with a comment after approval. Never close a duplicate automatically.

Show the full list in a table first. Apply labels only after the user approves.

## 2. Draft replies

Write a short reply draft that:
- Thanks the person.
- Says what happens next, in one sentence.
- Asks only for the missing information, if any.

Keep each draft under 120 words. Show all drafts to the user. Post a draft only after the user approves that specific draft.

## 3. Release notes

First check that the repository has commits and at least one release or tag. If it has no commits, say: "There is nothing to write release notes for yet." If it has commits but no tag, use the commits since the first commit and say so.

Read the commits since the last tag. Group them into **Added**, **Changed**, and **Fixed**. Skip merge commits and typo-only commits. Write each line in plain language. Show the result to the user before saving or publishing.

## 4. Find contributor-friendly work

List open issues labeled `help wanted` or `good first issue`, or issues with a clear scope and no assignee. For each, give the issue number, a one-sentence summary, and the skill level needed.

## Before finishing

- Tell the user what was done and what still needs their decision.
- Tell the user which items were only drafts and were not sent.

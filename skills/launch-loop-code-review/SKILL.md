---
name: launch-loop-code-review
description: Use when a maintainer wants a code review of a project or of recent changes, using several independent reviewers and a judge who verifies every finding. Supports a first full review and cheaper update reviews.
---

# Code Review

Review code with several independent reviewers, each looking from a different angle. A judge then checks every finding against the real code. Only verified findings reach the user.

## Golden rules

- Never change code, post comments, or open pull requests. This skill only reports.
- Every finding must name a file and a line, and quote the code it is about. Drop any finding that has no evidence.
- State clearly in the final report: "This is not a full security audit."
- Show the plan, the estimated time, and the estimated cost first. Start only after the user says yes.
- Keep the language simple. The maintainer may not be technical.

## Step 1: Choose the mode

Look for a `PROJECT_MAP.md` file in the project.

- **No map exists:** Offer a **full review**. Explain that it reads the whole project once and creates the map.
- **A map exists:** Offer an **update review** of the files changed since the last review.
- **The map is old:** If the last full review was more than the interval the user chose (weekly or monthly, ask once and remember it in the map), ask: "Shall I run a full review now?" Never start a full review without a yes.

## Step 1b: Public or private?

Ask once, in plain words: "Is this repository public (anyone can read it) or private (only you)?" If a `PROJECT_MAP.md` exists, read the answer from "Repository visibility" instead of asking again. If the user is not sure, check with the repository settings or ask them to look, and treat it as public until known. Save the answer in the map (after approval).

This answer changes how serious some findings are. See "Severity" in Step 4.

## Step 2: Plan and ask

Tell the user in plain words:
- Which files will be read.
- How many reviewers will run (default 4 to 6).
- A rough estimate of time and cost (see "How to estimate" below).

Wait for approval.

### How to estimate

Do not guess. Count first:
1. Count the lines of the files in scope (for example with `wc -l`). In an update review, count only the changed files and the files listed under "Important files" in the map.
2. Size of one read: lines x 12 = roughly that many tokens.
3. Total work: (size of one read x number of reviewers) + the same size once more for the judge.
4. Give the user a size, not a price:
   - **Small:** under 100,000 tokens in total.
   - **Medium:** 100,000 to 500,000.
   - **Large:** over 500,000.
5. Time: about 2 to 5 minutes for a small review, 10 to 30 minutes for a medium one, longer for a large one. If the reviewers run one after another, use the upper end.
6. Say plainly that this is a rough estimate. The real cost depends on the model and the user's plan. Never state a money amount as a fact.
7. If the review is Large, offer to narrow it first: review only the files that handle login, money, encryption, or deleting data, then widen later.

## Step 3: Reviewers

Give each reviewer one angle. The default angles:
1. Logic errors and wrong results.
2. Edge cases and error handling (empty input, missing files, no network).
3. Security basics (exposed secrets, unsafe input, missing permission checks).
4. Readability and confusing code.
5. Tests: what changed but is not tested.
6. Dependencies and configuration problems.

Each reviewer writes a list of findings with file, line, quoted code, and a one-sentence explanation. Reviewers work independently and do not see each other's results.

If the tool cannot run helpers in parallel, run the angles one after another.

## Step 4: Judge

The judge:
1. Merges duplicate findings.
2. Opens the real file and checks that each quoted line exists and the problem is real.
3. Removes findings that cannot be verified.
4. Sorts the rest: **High**, **Medium**, **Low**.

### Severity

- An exposed secret (API key, password, signing key committed to the repository) is **High** if the repository is public or may become public. If the repository is private, mark it **Medium** and add: "High if this repository is ever made public." Either way, tell the user to rotate or restrict the secret before any publication.
- A problem that could lose or leak the user's data, money, or login is **High** or **Medium**, whether the repository is public or private.
- Style, size, and missing-test findings are never above **Medium**.

## Step 5: Report

Write a short report:
- A table: severity, file and line, what is wrong, suggested fix in one sentence.
- A short list of what was not checked.
- The sentence: "This is not a full security audit."

## Project map (full review only)

After a full review, propose a `PROJECT_MAP.md`. Show it to the user and save it only after approval. Use exactly this format, so later reviews can read it:

```markdown
# Project Map

- Last full review: YYYY-MM-DD
- Review interval: weekly | monthly | never (chosen by the user)
- Repository visibility: public | private

## Main parts
- `path/to/folder-or-file`: one sentence on what it does.

## Important files
- `path/to/file`: why it matters (for example: handles login, stores money, encrypts data).

## Known risks
- `path/to/file:line`: one sentence. Never write secret values here.

## Not covered
- What the last review did not check.
```

Keep the map short: one line per item, no code. It must be understandable to a non-technical maintainer.

During an update review, read the map first. Review only the files changed since "Last full review" and the files listed under "Important files". If the changes mean the map should change, show the exact change and wait for approval. Do not edit the map on your own.

## Deep review (only when the user asks)

Up to 16 reviewers, each with a different strategy card (for example: think from first principles, think backwards from failure, look at edge cases first). Then:
1. Reviewers are paired. One defends its findings, the other attacks them using evidence from the code.
2. The judge scores each pair. The weaker side is out.
3. Pairs repeat until one set of findings remains (16, 8, 4, 2, 1).
4. The judge verifies the final findings as in Step 4.

Warn the user before starting: a deep review makes many more calls and costs much more than the default. Run it only after a clear yes, and only on risky changes (login, payments, deleting data).

> Draft: the duel and scoring rules need refinement before this mode is released.

## Language

Always reply in the same language the user writes in. If the user writes in Turkish, reply in Turkish, even though these instructions are in English.

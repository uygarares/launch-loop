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

## Step 2: Plan and ask

Tell the user in plain words:
- Which files will be read.
- How many reviewers will run (default 4 to 6).
- A rough estimate of time and cost.

Wait for approval.

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

## Step 5: Report

Write a short report:
- A table: severity, file and line, what is wrong, suggested fix in one sentence.
- A short list of what was not checked.
- The sentence: "This is not a full security audit."

## Project map (full review only)

After a full review, propose a `PROJECT_MAP.md`: main parts, important files, known risks, and the date of this review. Show it to the user and save it only after approval.

During an update review, if the changes mean the map should change, show the exact change and wait for approval. Do not edit the map on your own.

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

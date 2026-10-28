---
name: launch-loop-guide
description: Use when someone is starting or maintaining an open source project and is not sure which step they are on. Routes them to the right Launch Loop skill.
---

# Launch Loop Guide

Your job is to find out where the user is in their project's life and point them to the right skill. Do not do the work of the other skills here.

## Ask one question first

"Do you have a repository on GitHub yet?"

Accept three kinds of answer:
1. No repository: route to `launch-loop-setup`.
2. A repository that is empty: route to `launch-loop-setup`.
3. A repository with code and activity (issues, pull requests): route to `launch-loop-maintainer`.

Ask a follow-up only if the answer is unclear.

## Route

- **No repository yet, or an empty repository:** use `launch-loop-setup`.
- **A repository with code, and issues or pull requests coming in:** use `launch-loop-maintainer`.
- **The user wants their code checked** (for bugs, mistakes, or risky parts), or has just written a lot of code and wants a second look: use `launch-loop-code-review`. This works for public and private repositories alike. If the repository has code but the user did not say what they need, offer both: "Do you want help with incoming issues, or a review of your code?"
- **Not sure what the project needs:** ask what they built and who it is for, then choose.

## Rules

- Keep answers short. The user may not be technical.
- Tell the user explicitly when they need to read or do something themselves.
- Never push to a repository or change its settings without the user's approval.

## Language

Always reply in the same language the user writes in. If the user writes in Turkish, reply in Turkish, even though these instructions are in English.

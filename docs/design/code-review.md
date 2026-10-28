# Code Review Skill: Design (planned, not built yet)

## Two modes

1. **Full review.** Reads the whole project once and creates a project map file (`PROJECT_MAP.md`): main parts, important files, known risks.
2. **Update review.** Looks only at files changed since the last review. Uses the project map to judge their impact.

## Rules

- A full review never runs automatically. The skill asks the user first: "Shall I run a full review now?"
- The user chooses how often full reviews happen (weekly or monthly). Before each one, the skill states the estimated time and cost.
- If an update review suggests a change to the project map, the skill shows the change and waits for approval. It does not edit the map without approval.
- Every finding must point to a file and line. Findings without evidence are dropped.
- Default: 4 to 6 reviewers. A deeper review with up to 16 reviewers only when the user asks for it.
- Output ends with: "This is not a full security audit."

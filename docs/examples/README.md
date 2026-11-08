# Example reports

These are real reports. Launch Loop's own skills reviewed Launch Loop itself on 2026-11-08, so you can see what the output looks like before you try it on your project.

- [Code review report](code-review-report.md)
- [Security scan report](security-scan-report.md)

**How they were made.** The assistant ran the skills on this repository in one session. It ran the angles one after another, not in parallel, and then acted as the judge: it re-opened each file and dropped what it could not verify. The reviewed version was commit `d0beba5`. Every finding in these reports was fixed in commits `e0c1a7a` and `4cd61e0`, so the reports show what was found at that time, not the current state.

**What is not here.** There is no example of the pull request review mode yet, because this repository has not received a real pull request. We will add one when we have one.

These reports are examples, not guarantees. A review by an assistant is not a full security audit.

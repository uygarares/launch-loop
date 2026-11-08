# Security scan report: Launch Loop (scanning itself)

- **Skill:** `launch-loop-security-scan`
- **Date:** 2026-11-08
- **Scanned version:** commit `d0beba5`, including the full git history (31 commits, history was complete, not shallow)
- **Repository:** public (MIT), so exposed secrets would have been rated **High**
- **Plan shown first:** the relevant angles for a project made of text files, scripts and one workflow. No outside tools were used.

## Findings

| Severity | File and line | What is wrong | How someone could misuse it | Suggested fix |
|---|---|---|---|---|
| Low | `.github/workflows/check-skills.yml:16` | The workflow uses `actions/checkout@v4`, a tag. A tag can be moved later. | If that tag were ever moved to bad code, our checks would run it. | Pin the action to a commit code. |
| Low | `README.md` (Windows install command) | The command uses `-ExecutionPolicy Bypass` without saying that it only applies to that one run. | A user may think it changes a Windows setting, or may copy the habit to run unknown scripts. | Explain it in one sentence and invite people to read the script first. |

## No problems found in these areas

- **Secrets in files and history:** none found in the current files or in any of the 31 commits.
- **Personal information:** none found.
- **Injection:** the install scripts take no input from the internet and quote all paths. `rm -rf` and `Remove-Item` only touch folders inside the chosen skills folder.
- **Automation files:** the workflow has read-only permissions and uses `pull_request`, not `pull_request_target`, so a stranger's pull request cannot reach secrets.
- **Instructions that could mislead an assistant:** no hidden text, no "ignore previous instructions", no steps that send data anywhere. The only match is the example phrase in the pull request review mode, which is there on purpose.
- **Dependencies:** the project has none.

## Not checked

- GitHub repository settings (branch protection, who can push).
- Whether the skills behave safely in every assistant. This was checked by reading, not by testing.
- The Windows installer was not run during the scan.

This is not a full security audit. It was done by reading code, not by testing a running system. For a serious product, ask a security professional.

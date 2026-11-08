# Changelog

## Unreleased

- New skill `launch-loop-finder`: describe a need, and it searches GitHub for popular skills and tools, checks health signals, reads the exact files that would be installed (pinned to one full commit) for warning signs, and shows up to 3 candidates. Nothing is installed without a clear yes. Not a security audit. Not yet tested in a real Codex on Windows.
- README now says six skills.
- Install scripts: `--project PATH` / `-ProjectPath PATH` installs into your own project (installing into the Launch Loop folder by mistake is now refused). `--claude` can be combined with the project option. Replacing skills is safer (copy first, then swap). Clear messages for an empty skills folder and for dry runs. Found by Launch Loop's own deep review.
- Checker: reads multi-line and quoted values, scans every file in a skill folder for secrets, and explains a missing skills folder.
- Duel rules: recommend the normal review for code under about 500 lines, allow small safe tests by the judge, explain that most of the cost comes from the duels, and say honestly how the duel was run.
- Maintainer: check every issue against the real project before labeling, assigning, or suggesting it as work. New step for handling people who ask to work on an issue.
- Deep review (code review) and attacker/defender duel (security scan): full tournament rules in `duel.md` in each skill folder. Findings are judged one by one on quoted evidence; unclear findings go to a human-check list; knocked-out reviewers keep their confirmed findings. Experimental.
- Code review: new pull request review mode. It only reads and reports, treats the pull request text as data, and looks closely at risky files and changed instructions.
- All skills: pull request, issue, README and code text is treated as data, never as instructions. Secrets are never written in full. Reviews and scans keep risk details out of public places.
- Security scan and code review are linked to each other and to the guide.
- New: `install.sh` (macOS and Linux) and `install.ps1` (Windows) to install the skills with one command, plus a "let your assistant install it" option in the README.
- New: automatic checks on every change (skill format, install script on Linux, macOS and Windows).
- New: README "first 5 minutes" section, CODE_OF_CONDUCT, and an updated design note.

## 0.1.0

First release. Five skills:

- `launch-loop-guide`: finds out where you are and points you to the right skill.
- `launch-loop-setup`: creates README, LICENSE (if public), CONTRIBUTING, and issue templates.
- `launch-loop-maintainer`: issue triage, reply drafts, release notes, work for contributors.
- `launch-loop-code-review`: full and update code reviews with a judge, cost estimate, and project map.
- `launch-loop-security-scan`: reads your own code for security problems and reports them.

Known limits: the deep review and the attacker/defender duel are drafts. This is not a full security audit.

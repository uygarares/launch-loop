# Launch Loop

A set of Claude and Codex skills that helps open source projects go from first idea to a maintained project.

## What is included

- **launch-loop-guide:** Finds out where you are and points you to the right skill.
- **launch-loop-setup:** Creates the basic files for a new project: README, LICENSE, CONTRIBUTING, and issue templates.
- **launch-loop-maintainer:** Helps with daily maintenance: issue triage, reply drafts, release notes, and finding work for contributors.
- **launch-loop-code-review:** Reviews your code with several independent reviewers and a judge who checks every finding against the real code. Starts with a full review, then cheaper update reviews of changed files. It shows a time and cost estimate first and never changes your code.
- **launch-loop-security-scan:** Scans your own code for security problems from several angles (secrets, injection, logins, settings, dependencies, and more). A judge verifies every finding. It only reads and reports, and never attacks anything. Not a full security audit.

Coming later: idea validation.

## How to use

Copy the folders inside `skills/` into `.agents/skills/` in your project (for Codex and most tools), or into `~/.agents/skills/` for personal use. Then ask for help in plain language, for example: "I want to start an open source project, where do I begin?"

## Status

Early version. Feedback and issues are welcome.

## License

MIT. See the [LICENSE](LICENSE) file.

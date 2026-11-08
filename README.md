# Launch Loop

A set of Claude and Codex skills that helps open source projects go from first idea to a maintained project.

## What is included

- **launch-loop-guide:** Finds out where you are and points you to the right skill.
- **launch-loop-setup:** Creates the basic files for a new project: README, LICENSE, CONTRIBUTING, and issue templates.
- **launch-loop-maintainer:** Helps with daily maintenance: issue triage, reply drafts, release notes, and finding work for contributors.
- **launch-loop-code-review:** Reviews your code with several independent reviewers and a judge who checks every finding against the real code. Starts with a full review, then cheaper update reviews of changed files. It shows a time and cost estimate first and never changes your code.
- **launch-loop-security-scan:** Scans your own code for security problems from several angles (secrets, injection, logins, settings, dependencies, and more). A judge verifies every finding. It only reads and reports, and never attacks anything. Not a full security audit.

Coming later: idea validation.

## Your first 5 minutes

You do not need to be technical. You only copy folders and then talk to your assistant.

### Quickest way: one command

You need [git](https://git-scm.com/downloads) installed. Open a terminal and run:

**macOS or Linux**

```bash
git clone https://github.com/uygarares/launch-loop
cd launch-loop
./install.sh
```

**Windows (PowerShell)**

```powershell
git clone https://github.com/uygarares/launch-loop
cd launch-loop
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

By default this installs to `~/.agents/skills` (Codex and most tools). Options:

| Option (macOS/Linux, Windows) | What it does |
|---|---|
| `--claude`, `-Claude` | Install for Claude Code (`~/.claude/skills`) |
| `--project`, `-Project` | Install into the current folder only |
| `--force`, `-Force` | Replace skills that are already installed |
| `--dry-run`, `-DryRun` | Show what would happen, copy nothing |

The scripts only copy the five skill folders. They do not use the network. You can read them before you run them: [install.sh](install.sh), [install.ps1](install.ps1). The Windows script has not been tested on many machines yet, so please [open an issue](https://github.com/uygarares/launch-loop/issues) if something goes wrong.

Then restart your assistant and go to step 4 below.

### Or copy by hand

**1. Download.** On this page choose **Code → Download ZIP**, or take the zip from the [latest release](https://github.com/uygarares/launch-loop/releases/latest). Unzip it.

**2. Copy the skills.** Inside the unzipped folder, open `skills/`. Copy the folders you want (or all five) to one of these places:

| Where | Use it when |
|---|---|
| `.agents/skills/` inside your project | Codex and most tools, for one project |
| `~/.agents/skills/` in your home folder | Codex and most tools, for all your projects |
| `.claude/skills/` or `~/.claude/skills/` | Claude Code |

Keep each skill in its own folder. Do not rename the folders.

**3. Restart your assistant** (open a new chat or session) so it finds the new skills.

**4. Ask in plain words.** For example:

> I want to start an open source project. Where do I begin?

If the assistant does not seem to know Launch Loop, ask: "Which Launch Loop skills do you have?" It should list them.

### What a conversation looks like

> **You:** I want to start an open source project. Where do I begin?
>
> **Assistant:** Do you have a repository on GitHub yet?
>
> **You:** Yes, but it is empty.
>
> **Assistant:** Then I will use the setup skill. First, four short questions: what does your project do, who is it for, is it only for you or for other people, and how will people install it?

The skills reply in your language. They show you a plan first and ask before they change, post, or push anything.

### Which skill for what

| You want to... | Skill |
|---|---|
| Know where to start | `launch-loop-guide` |
| Create README, LICENSE, CONTRIBUTING, issue templates | `launch-loop-setup` |
| Answer issues, write release notes, find work for contributors | `launch-loop-maintainer` |
| Have your code reviewed | `launch-loop-code-review` |
| Check your own code for security problems | `launch-loop-security-scan` |

Reviews and scans can use many calls. The skills tell you the rough size and ask before they start.

## Status

Early version. Feedback and issues are welcome.

## License

MIT. See the [LICENSE](LICENSE) file.

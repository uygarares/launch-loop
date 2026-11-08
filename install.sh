#!/usr/bin/env bash
# Launch Loop installer for macOS and Linux.
# Copies the skill folders from ./skills into a skills folder your assistant reads.
# It does not use the network and does not change anything else.
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--user | --project | --claude | --claude-project] [--force] [--dry-run]

  --user            Install to ~/.agents/skills (Codex and most tools, all projects). Default.
  --project         Install to ./.agents/skills (Codex and most tools, this folder only).
  --claude          Install to ~/.claude/skills (Claude Code, all projects).
  --claude-project  Install to ./.claude/skills (Claude Code, this folder only).
  --force           Replace skills that are already installed.
  --dry-run         Show what would happen without copying anything.
USAGE
}

target="$HOME/.agents/skills"
force=0
dry=0
for arg in "$@"; do
  case "$arg" in
    --user) target="$HOME/.agents/skills" ;;
    --project) target="$PWD/.agents/skills" ;;
    --claude) target="$HOME/.claude/skills" ;;
    --claude-project) target="$PWD/.claude/skills" ;;
    --force) force=1 ;;
    --dry-run) dry=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; usage >&2; exit 1 ;;
  esac
done

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$here/skills"
if [ ! -d "$src" ]; then
  echo "Cannot find the skills folder next to this script: $src" >&2
  exit 1
fi

echo "Installing Launch Loop skills to: $target"
[ "$dry" -eq 1 ] && echo "(dry run: nothing will be copied)"
[ "$dry" -eq 1 ] || mkdir -p "$target"

installed=0
skipped=0
for dir in "$src"/launch-loop-*/; do
  name="$(basename "$dir")"
  dest="$target/$name"
  if [ -e "$dest" ] && [ "$force" -ne 1 ]; then
    echo "  skip    $name (already installed; use --force to replace)"
    skipped=$((skipped + 1))
    continue
  fi
  if [ "$dry" -eq 1 ]; then
    echo "  would install $name"
  else
    rm -rf "$dest"
    cp -R "$dir" "$dest"
    echo "  installed $name"
  fi
  installed=$((installed + 1))
done

echo "Done: $installed installed, $skipped skipped."
echo "Restart your assistant (open a new chat or session) so it finds the skills."

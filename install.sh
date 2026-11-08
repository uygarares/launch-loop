#!/usr/bin/env bash
# Launch Loop installer for macOS and Linux.
# Copies the skill folders from ./skills into a skills folder your assistant reads.
# It does not use the network and does not change anything else.
set -euo pipefail
shopt -s nullglob

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--project PATH] [--claude] [--force] [--dry-run]

  (no options)      Install to ~/.agents/skills (Codex and most tools, all projects).
  --project PATH    Install into the project at PATH (PATH/.agents/skills).
  --claude          Use the Claude Code folder (.claude/skills) instead of .agents/skills.
                    Works alone (~/.claude/skills) or with --project.
  --force           Replace skills that are already installed.
  --dry-run         Show what would happen without copying anything.

Example: ./install.sh --project ~/code/my-app --claude
USAGE
}

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$here/skills"

base="$HOME"
project=""
sub=".agents/skills"
force=0
dry=0

while [ $# -gt 0 ]; do
  case "$1" in
    --user) base="$HOME"; project="" ;;
    --project)
      if [ $# -lt 2 ] || [ "${2#-}" != "$2" ]; then
        echo "--project needs the path of your project, for example: ./install.sh --project ~/code/my-app" >&2
        exit 1
      fi
      project="$2"; shift ;;
    --project=*) project="${1#--project=}" ;;
    --claude) sub=".claude/skills" ;;
    --claude-project) sub=".claude/skills"; project="$PWD" ;;
    --force) force=1 ;;
    --dry-run) dry=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
  esac
  shift
done

if [ -n "$project" ]; then
  if [ ! -d "$project" ]; then
    echo "The project folder does not exist: $project" >&2
    exit 1
  fi
  base="$(cd "$project" && pwd)"
  if [ "$base" = "$here" ]; then
    echo "That is the Launch Loop folder itself, not your project. Give the path of your own project." >&2
    exit 1
  fi
fi
target="$base/$sub"

if [ ! -d "$src" ]; then
  echo "Cannot find the skills folder next to this script: $src" >&2
  exit 1
fi
dirs=("$src"/launch-loop-*/)
if [ ${#dirs[@]} -eq 0 ]; then
  echo "The skills folder is empty: $src. Download Launch Loop again." >&2
  exit 1
fi

echo "Installing Launch Loop skills to: $target"
if [ "$dry" -eq 1 ]; then
  echo "(dry run: nothing will be copied)"
else
  mkdir -p "$target"
fi

installed=0
skipped=0
for dir in "${dirs[@]}"; do
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
    # Copy to a temporary folder first, so a failed copy never leaves you with nothing.
    tmp="$target/.$name.installing"
    rm -rf "$tmp"
    cp -R "$dir" "$tmp"
    rm -rf "$dest"
    mv "$tmp" "$dest"
    echo "  installed $name"
  fi
  installed=$((installed + 1))
done

if [ "$dry" -eq 1 ]; then
  echo "Done: $installed would be installed, $skipped skipped."
else
  echo "Done: $installed installed, $skipped skipped."
  echo "Restart your assistant (open a new chat or session) so it finds the skills."
fi

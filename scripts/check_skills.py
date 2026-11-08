#!/usr/bin/env python3
"""Checks every skill in skills/ against the Agent Skills format and Launch Loop rules.

Run from the repository root:  python3 scripts/check_skills.py
Exit code 0 = all good, 1 = at least one problem.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SKILLS = ROOT / "skills"
NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
SECRET_RE = re.compile(
    r"(AIza[0-9A-Za-z_\-]{30,}|sk-[A-Za-z0-9]{30,}|ghp_[A-Za-z0-9]{30,}|AKIA[0-9A-Z]{16}|BEGIN (RSA|EC|OPENSSH|PRIVATE) )"
)
MAX_LINES = 500

problems = []


def fail(skill, message):
    problems.append(f"{skill}: {message}")


def parse_frontmatter(text):
    if not text.startswith("---\n"):
        return None, text
    end = text.find("\n---\n", 4)
    if end == -1:
        return None, text
    block = text[4:end]
    body = text[end + 5:]
    data = {}
    for line in block.splitlines():
        if ":" in line and not line.startswith(" "):
            key, value = line.split(":", 1)
            data[key.strip()] = value.strip()
    return data, body


def main():
    dirs = sorted(p for p in SKILLS.iterdir() if p.is_dir())
    if not dirs:
        print("No skills found in skills/")
        return 1

    for folder in dirs:
        label = folder.name
        skill_file = folder / "SKILL.md"
        if not skill_file.exists():
            fail(label, "SKILL.md is missing")
            continue

        text = skill_file.read_text(encoding="utf-8")
        data, body = parse_frontmatter(text)
        if data is None:
            fail(label, "SKILL.md must start with a --- frontmatter block")
            continue

        name = data.get("name", "")
        description = data.get("description", "")

        if not name:
            fail(label, "frontmatter has no 'name'")
        else:
            if name != folder.name:
                fail(label, f"name '{name}' does not match the folder name '{folder.name}'")
            if len(name) > 64 or not NAME_RE.match(name):
                fail(label, f"name '{name}' must be lowercase letters, numbers and single hyphens, up to 64 characters")
            if not name.startswith("launch-loop-"):
                fail(label, "name should start with 'launch-loop-'")

        if not description:
            fail(label, "frontmatter has no 'description'")
        elif len(description) > 1024:
            fail(label, f"description is {len(description)} characters (limit 1024)")

        if "## Language" not in body:
            fail(label, "missing the '## Language' section (replies must follow the user's language)")
        if "## Safety and care" not in body and "## Golden rules" not in body and "## Rules" not in body:
            fail(label, "missing a rules section ('## Golden rules', '## Rules' or '## Safety and care')")

        for ref in sorted(set(re.findall(r"`([A-Za-z0-9_\-]+\.md)` in this skill's folder", text))):
            if not (folder / ref).exists():
                fail(label, f"refers to {ref} in its folder, but the file is missing")

        line_count = len(text.splitlines())
        if line_count > MAX_LINES:
            fail(label, f"{line_count} lines (keep skills under {MAX_LINES})")

        if SECRET_RE.search(text):
            fail(label, "looks like it contains a secret (key, token or private key)")

        print(f"checked {label}: {line_count} lines, description {len(description)} characters")

    if problems:
        print("\nProblems found:")
        for item in problems:
            print(f"  - {item}")
        return 1
    print(f"\nAll {len(dirs)} skills look good.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

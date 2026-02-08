#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$HOME/dotfiles"
LOCK_DIR="/tmp/dotfiles-sync.lockdir"

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  exit 0
fi
trap 'rmdir "$LOCK_DIR"' EXIT

cd "$REPO_DIR"

# Keep shared skills links healthy before sync.
if [ -x "$REPO_DIR/scripts/skills-doctor.sh" ]; then
  "$REPO_DIR/scripts/skills-doctor.sh"
fi

# Keep local and remote in sync while preserving any uncommitted edits.
git pull --rebase --autostash origin master

if [ -n "$(git status --porcelain)" ]; then
  git add -A -- . \
    ':(exclude)skills/.system/**/__pycache__/**' \
    ':(exclude)skills/.system/**/*.pyc' \
    ':(exclude)**/.DS_Store'

  if git diff --cached --quiet; then
    exit 0
  fi

  git commit -m "chore(dotfiles): automated sync $(date -u +'%Y-%m-%dT%H:%M:%SZ')"
  git push origin master
fi

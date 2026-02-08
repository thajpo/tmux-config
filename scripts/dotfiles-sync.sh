#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/home/j/dotfiles"
LOCK_FILE="/tmp/dotfiles-sync.lock"

exec 9>"$LOCK_FILE"
if ! flock -n 9; then
  exit 0
fi

cd "$REPO_DIR"

# Keep local and remote in sync while preserving any uncommitted edits.
git pull --rebase --autostash origin master

if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "chore(dotfiles): automated sync $(date -u +'%Y-%m-%dT%H:%M:%SZ')"
  git push origin master
fi

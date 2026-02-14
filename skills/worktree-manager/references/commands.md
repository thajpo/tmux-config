# Worktree Commands

## Create
```bash
git fetch origin
git worktree add ../<repo>-<id> -b codex/<id>-<slug> origin/main
```

## List
```bash
git worktree list
```

## Cleanup (after merge/abandonment)
```bash
git worktree remove ../<repo>-<id>
git branch -d codex/<id>-<slug>
git fetch -p
```

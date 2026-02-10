# Local Skills Notes

## Workflow Rule
- Any time we edit dotfiles/config repos, we should commit and push in the same session.
- Preferred flow: `Use $git-cleanup draft-then-ship`.
- If push should be skipped for a specific case, explicitly state that in the request.

## Active Workflow Skills (v2)
- `project-os`: planning authority (`current.md`), Brainstormed Q&A, Specd promotion, approval TTL/invalidation, final merge/prune decisions.
- `implementer`: execution-only worker for one approved Specd item.
- `quality-gate`: independent review + regression verdict before merge.

## Approval Policy
- User message `yes` after Q&A is treated as approval signature.
- Agent records approval metadata in `Specd` (no manual user file edits needed).
- Approval expires after 5 days.
- Dependency changes always invalidate approval.

## Merge Logging Policy
- On merge, `project-os` records the completed feature in `Institutional Knowledge` with commit SHA + commit subject before pruning the `Specd` item.

## Why
- Keeps Linux and Mac in sync.
- Reduces context loss when switching machines.
- Leaves a clear rollback point via commit SHA.

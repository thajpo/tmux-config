# Local Skills Notes

## Workflow Rule
- Any time we edit dotfiles/config repos, we should commit and push in the same session.
- Preferred flow: `Use $git-cleanup draft-then-ship`.
- If push should be skipped for a specific case, explicitly state that in the request.

## Active Workflow Skills (current)
- `lean-flow`: canonical planning workflow (`Brainstormed -> Specd (draft) -> Ready`), with explicit readiness evidence in markdown.
- `spec-gate`: clarification/readiness checks and overlap analysis before `Ready`.
- `subagent-dispatch` + `pr-subagent-flow`: optional execution/review orchestration when explicitly requested.

## Approval Policy
- `Ready` requires explicit approval evidence in markdown (not chat-only approval).
- Before `Ready`, items in `Brainstormed`/`Specd` can be merged/split/reorganized.
- After `Ready`, each item maps to exactly one GitHub issue.
- Implementation should not start without a linked GitHub issue.

## Merge Logging Policy
- Keep merged-item logging lightweight in planning files; prune merged `Specd` items after PR merge.

## Why
- Keeps Linux and Mac in sync.
- Reduces context loss when switching machines.
- Leaves a clear rollback point via commit SHA.

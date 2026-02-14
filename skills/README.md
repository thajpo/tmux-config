# Local Skills Notes

## Workflow Rule
- Any time we edit dotfiles/config repos, we should commit and push in the same session.
- Preferred flow: `Use $git-cleanup draft-then-ship`.
- If push should be skipped for a specific case, explicitly state that in the request.

## Active Workflow Skills (current)
- `repo-init`: bootstrap repo planning + issue/PR templates + baseline CI checks.
- `lean-flow`: planning workflow (`Brainstormed -> Specd -> ready -> issue`).
- `spec-gate`: interrogation + readiness checks for strict spec contracts.
- `issue-handoff`: create one issue from one ready spec and compact tracker state.
- `worktree-manager`: one issue -> one branch -> one worktree -> one PR lifecycle.
- `pr-scope-guard`: enforce issue-approved file touch boundaries.
- `ci-baseline`: ensure baseline PR checks (`lint`, `test`).
- `pr-iterate`: ingest full PR feedback + iterate with required post-push updates.

## Approval Policy
- `Ready` requires explicit approval evidence in markdown (not chat-only approval).
- Before `Ready`, items in `Brainstormed`/`Specd` can be merged/split/reorganized.
- After `Ready`, each item maps to exactly one GitHub issue.
- Implementation should not start without a linked GitHub issue.
- Issue defines approved `file touch scope`; out-of-scope touches require explicit user approval.
- After PR creation, PR thread/review feedback is the iteration source of truth.

## Merge Logging Policy
- Keep merged-item logging lightweight in planning files; prune merged `Specd` items after PR merge.

## Why
- Keeps Linux and Mac in sync.
- Reduces context loss when switching machines.
- Leaves a clear rollback point via commit SHA.

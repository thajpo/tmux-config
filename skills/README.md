# Local Skills Notes

## Workflow Rule
- Any time we edit dotfiles/config repos, we should commit and push in the same session.
- Preferred flow: `Use $git-cleanup draft-then-ship`.
- If push should be skipped for a specific case, explicitly state that in the request.

## Active Workflow Skills (current)
- User-facing:
  - `repo-init`: one-time repo bootstrap (planning + templates + baseline CI).
  - `lean-flow`: planning workflow (`Brainstormed -> Specd -> ready`).
  - `pr-iterate`: execution workflow (`ready/issued -> issue/PR loop -> merge-ready`).
- Internal helpers (auto-used by `pr-iterate`/`repo-init`):
  - `spec-gate`
  - `issue-handoff`
  - `worktree-manager`
  - `pr-scope-guard`
  - `ci-baseline`

## Approval Policy
- `Ready` requires explicit approval evidence in markdown (not chat-only approval).
- Before `Ready`, items in `Brainstormed`/`Specd` can be merged/split/reorganized.
- After `Ready`, each item maps to exactly one GitHub issue.
- Implementation should not start without a linked GitHub issue.
- Issue defines approved `file touch scope`; out-of-scope touches require explicit user approval.
- After PR creation, PR thread/review feedback is the iteration source of truth.

## Merge Logging Policy
- Keep merged-item logging lightweight in planning files; prune merged `Specd` items after PR merge.

## Command Surface
Use only these in normal flow:
1. `Use $repo-init` (once per repo)
2. `Use $lean-flow ...` (planning to `ready`)
3. `Use $pr-iterate "<spec-id-or-pr#>"` (issue + PR + feedback loop)
   - `$pr-iterate` performs commit + push updates by default; you review and decide merge.

## Why
- Keeps Linux and Mac in sync.
- Reduces context loss when switching machines.
- Leaves a clear rollback point via commit SHA.

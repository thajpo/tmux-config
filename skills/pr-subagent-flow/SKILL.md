---
name: pr-subagent-flow
description: "Compatibility wrapper for strict issue->PR execution loops. Routes to worktree, scope, CI, and PR-iteration skills."
---

# PR Subagent Flow

## Goal
Provide a backward-compatible entrypoint for strict issue -> PR workflows.

## Status
- This skill is compatibility-only.
- Prefer direct use of `$worktree-manager`, `$pr-scope-guard`, `$ci-baseline`, and `$pr-iterate`.

## Chain Order
1. Validate linked issue and approved `file touch scope`.
2. Ensure isolated branch/worktree via `$worktree-manager`.
3. Enforce scope boundaries via `$pr-scope-guard`.
4. Ensure baseline checks via `$ci-baseline` (`lint`, `test`).
5. Iterate feedback via `$pr-iterate` until merge-ready.

## Preconditions
- linked issue exists
- PR exists or is being opened for that issue
- one issue -> one branch -> one worktree -> one PR mapping

## Output Contract
Return one package containing:
- branch/worktree,
- changed files,
- lint/test evidence,
- PR feedback ingestion summary,
- latest agent update comment status,
- residual risks,
- blocker packet (if blocked).

## References
- `../worktree-manager/SKILL.md`
- `../pr-scope-guard/SKILL.md`
- `../ci-baseline/SKILL.md`
- `../pr-iterate/SKILL.md`

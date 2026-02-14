---
name: worktree-manager
description: "Manage one-issue-per-worktree lifecycle for branch isolation, PR traceability, and predictable cleanup."
---

# Worktree Manager

## Goal
Enforce isolated execution: one approved issue maps to one branch, one worktree, one PR.

## Contract
- `1 issue -> 1 branch -> 1 worktree -> 1 PR`
- no shared worktree across multiple active issues
- no mixed-scope commits in a single worktree

## Naming
- worktree directory should include issue/spec id
- branch should include issue/spec id with `codex/` prefix
- naming may vary by repo as long as mapping is unambiguous

## Lifecycle
1. Create isolated worktree from default branch.
2. Implement and open PR from that branch only.
3. After merge, remove worktree and delete local branch.

Use command patterns in `references/commands.md`.

## Guardrails
- Never reuse an active worktree for a different issue.
- If urgent hotfix is needed, create a separate worktree.
- Cleanup happens only after merge/abandonment is confirmed.

## References
- `references/commands.md`

---
name: subagent-dispatch
description: "Deprecated compatibility skill. Use worktree-manager + pr-iterate stack for issue-scoped PR execution."
---

# Subagent Dispatch

## Status
- Deprecated for this workflow.
- Do not require separate subagent sessions.
- Preferred path is issue-scoped implementation in one isolated worktree.

## Use Instead
1. `$worktree-manager` to prepare isolated branch/worktree.
2. `$pr-scope-guard` to enforce issue-approved file touch scope.
3. `$ci-baseline` for `lint` + `test` gates.
4. `$pr-iterate` for review-feedback loops and required PR updates.

## References
- `../worktree-manager/SKILL.md`
- `../pr-scope-guard/SKILL.md`
- `../ci-baseline/SKILL.md`
- `../pr-iterate/SKILL.md`

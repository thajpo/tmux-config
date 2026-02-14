---
name: subagent-dispatch
description: "Launch a separate implementation subagent from a ready spec with no scope decisions and verified launch evidence."
---

# Subagent Dispatch

## Goal
Start and monitor implementation subagents safely and transparently.

## Preconditions
- Spec item is `Specd: ready`.
- Manual approval evidence exists in markdown.
- Spec contract is complete.

## Procedure
1. Build dispatch packet from spec contract.
2. Prepare isolated branch/worktree.
3. Spawn separate subagent process/session.
4. Record launch evidence:
- runner,
- pid/session id,
- branch/worktree,
- start timestamp.
5. Require phase reporting:
- `preflight`, `fail-first`, `implementation`, `retest`, `report`.

## Hard Rules
- Parent/coordinator must not implement in its own session.
- Subagent must not make product/scope decisions.
- Subagent must escalate on ambiguity, out-of-scope file touch, or command blockers.
- Use `uv` runner where repo is configured for it.

## Required Return
- changed files
- fail-first output
- pass output
- residual risks/open questions
- blocker packet (if blocked)

## References
- `references/dispatch-packet-template.md`

---
name: implementer
description: "Execution-only skill. Implement one approved Specd contract, run tests, open PR, and return evidence."
---

# Implementer

## Goal
Implement exactly one `Specd` item that is approved and currently valid.

## Preconditions
- Input item exists in `Specd`.
- `approval_status: valid`.
- current date <= `expires_on`.
- no dependency invalidation since approval.

If any precondition fails: stop and return a blocker packet.

## Authority Boundary
- Execution authority only.
- No planning authority.
- No silent scope decisions.

## Required Phases
1. preflight
2. fail-first
3. implementation
4. retest/regression
5. PR/report

## Required Output Bundle
- branch/worktree
- changed files
- fail-first command + key failure lines
- pass/retest commands + key success lines
- PR URL
- residual risks
- blocker/escalation question (if blocked)

## Escalation Triggers
Stop and ask one explicit question if:
- out-of-scope files are required
- spec text is ambiguous or contradictory
- required tests cannot run
- unexpected dependency conflict appears

## Guardrails
- No migration/compat shims unless explicitly in spec.
- No hidden behavior changes.
- No test-skipping to force pass.

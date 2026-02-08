---
name: spec-gate
description: "Run mandatory clarification/interrogation to promote Brainstormed items into complete Specd ready contracts. Use when scope ambiguity must be removed before implementation dispatch."
---

# Spec Gate

## Goal
Convert a brainstorm into an implementation-ready contract with zero unresolved blockers.

## Inputs
- Active planning file (`current.md` or `code_current.md`).
- Candidate item title in `Brainstormed`.
- Current `Specd` list for overlap checks.

## Mandatory Interrogation Coverage
1. Behavior boundary
- What changes and what must stay unchanged.

2. Non-goals
- Explicitly excluded surfaces.

3. Test strategy
- Fail-first test(s).
- Regression test scope.

4. Risk and rollback
- Main risks and rollback trigger.

5. Overlap check
- Merge/split decision vs other brainstorm/spec items.

## Promotion Rule
Mark `Specd: ready` only when:
- all required spec contract fields are populated,
- no blocking questions remain,
- overlap decisions are resolved.

If any blocker remains, keep item in `Brainstormed` or `Specd: in_progress` and list blocking questions explicitly.

## References
- `references/interrogation-questions.md`
- `references/spec-contract-template.md`

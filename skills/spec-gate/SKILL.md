---
name: spec-gate
description: "Run mandatory clarification/interrogation to promote Brainstormed items into complete Specd ready contracts. Use when scope ambiguity must be removed before implementation dispatch."
---

# Spec Gate

## Goal
Convert a brainstorm into an implementation-ready contract with zero unresolved blockers.

## Interaction Contract (Mandatory)
- Interrogation must be explicit and user-visible.
- Ask the mandatory coverage questions (or equivalent) and capture user answers in-session.
- Do not treat prewritten brainstorm bullets as answered unless the user explicitly confirms each unresolved point.
- Do not mark `Specd: ready` from inference alone.
- If user intent is "implement X" but interrogation is incomplete, block promotion and run interrogation first.

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
- every mandatory interrogation item has an explicit answer.

If any blocker remains, keep item in `Brainstormed` or `Specd: in_progress` and list blocking questions explicitly.

## Required Output of Interrogation
- A compact Q&A transcript with numbered questions and resolved answers.
- A blocker list (empty if none).
- Promotion decision: `ready` or `not ready`, with rationale.
- If `not ready`, include one explicit next action that clears the top blocker.

## References
- `references/interrogation-questions.md`
- `references/spec-contract-template.md`

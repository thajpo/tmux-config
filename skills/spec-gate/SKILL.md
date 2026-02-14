---
name: spec-gate
description: "Chat-driven clarification gate that turns Brainstormed items into concrete Specd drafts and verifies readiness only with overlap analysis plus manual markdown approval evidence."
---

# Spec Gate

## Goal
Convert a brainstorm into a concrete spec draft, then validate it is truly ready for GitHub issue handoff.

## Inputs
- Active planning file (`current.md` or `code_current.md`).
- Candidate item title in `Brainstormed` or `Specd`.
- Current `Specd` list for overlap checks.

## Operating Mode
- Conversation-first: ask only unresolved questions needed to remove ambiguity.
- Assistant-owned drafting: assistant writes contract fields based on chat outcomes.
- User is approver, not form filler.

## Required Spec Contract Fields
1. User intent
- Why this change is needed now.

2. Behavior change
- Explicit contract delta.

3. Surfaces touched
- Files/modules/functions expected to change.

4. File touch scope
- Explicit allowed files/globs for implementation.

5. Estimated diff size
- S/M/L with short rationale.

6. Acceptance tests
- Fail-first test(s).
- Regression scope.

7. Edge cases
- At least one concrete edge condition.

8. Non-goals
- Explicitly excluded surfaces.

9. Risk and rollback
- Main risks and rollback trigger.

10. Overlap analysis
- Shared surfaces with other specs.
- Merge-vs-split recommendation and decision.

## Readiness Rule
Mark `Specd: ready` only when:
- required contract fields are complete,
- no blocking questions remain,
- overlap decision is recorded,
- manual approval evidence exists in markdown file.

For issue handoff:
- GitHub issue body must include the full approved spec contract verbatim.
- Use the standardized issue template from `references/spec-contract-template.md`.
- File touch scope in issue must match approved spec scope at handoff.

Manual approval evidence must include:
- approver identity,
- approval date,
- approved scope,
- unresolved blockers: none.

If any condition fails, keep item in `Specd` draft/in_progress and list blockers.

## Guardrails
- Chat approval alone does not satisfy readiness.
- Never backfill approval evidence that does not exist in file.
- Never promote to `ready` with unresolved overlap conflicts.

## References
- `references/interrogation-questions.md`
- `references/spec-contract-template.md`

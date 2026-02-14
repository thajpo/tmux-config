---
name: lean-flow
description: "Chat-first planning orchestration for Brainstormed -> Specd -> Ready in current.md, with manual markdown approval required before implementation handoff."
---

# Lean Flow

## Goal
Keep planning minimal, explicit, and user-controlled while preserving a strict review gate before implementation.

## Canonical Planning Files
Choose one mode per repo/session.

1. Single-file mode (default)
- Use `current.md`.

2. ML split mode
- Use `code_current.md` for implementation planning.
- Use `research_current.md` for experiment planning and run history.

Do not create extra planning files unless explicitly requested.
- One temporary `temp.md` is allowed for large refactors and must be deleted after PR merge/abandonment.

## Required Sections (each active current file)
- `Institutional Knowledge`
- `Beliefs`
- `Brainstormed`
- `Specd`

## Workflow Model
1. Brainstormed
- Chat-first exploration.
- Assistant writes/maintains ideas in planning file.
- No implementation.

2. Specd (draft)
- Assistant converts selected brainstorm items into concrete specs.
- User gives feedback in chat; assistant updates spec text.
- No implementation.
- Promotion is a move, not a copy: once promoted to `Specd`, remove the item from `Brainstormed` in the same edit.
- Do not keep duplicate entries, placeholders, or "promoted" stubs in `Brainstormed`.

3. Ready (implementation-eligible)
- Requires manual user approval evidence in markdown file.
- Chat approval alone is not sufficient.
- Approval evidence must be present under the item before status becomes `ready`.

## Manual Approval Evidence (required)
Before marking `Specd: ready`, planning file must include:
- approver identity (user)
- approval date
- explicit scope approved
- unresolved blockers: none

If evidence is missing, keep status as draft/in_progress and continue chat refinement.

## Overlap-First Rule (required before Ready)
For each candidate ready item, perform surface-overlap checks against other Specd items:
- shared files/functions/modules
- behavior or contract conflicts
- merge-vs-split recommendation

Record overlap decision in the spec item.

## Ownership Boundaries
- `lean-flow` owns planning state and file hygiene.
- `$spec-gate` owns interrogation and readiness checks.
- Implementation dispatch is manual by default (user opens implementation tab/agent).
- `$pr-subagent-flow` is optional and only when explicitly requested.

## User-Facing Commands
- `Use $lean-flow migrate-repo`
- `Use $lean-flow capture idea: ...`
- `Use $lean-flow add belief: ...`
- `Use $lean-flow interrogate "<title>"`
- `Use $lean-flow promote "<title>" to Specd`
- `Use $lean-flow mark "<title>" ready` (only with manual approval evidence in file)
- `Use $lean-flow prepare handoff "<title>"` (for separate implementation agent)
- `Use $lean-flow prune merged Specd items`

## Routing Rules
1. Interrogate/Promote
- Invoke `$spec-gate`.
- Keep in `Specd` draft until blockers are resolved.

2. Mark Ready
- Invoke `$spec-gate` readiness checks.
- Require overlap record + manual approval evidence in markdown.

3. Implement
- Do not implement from `lean-flow`.
- Prepare handoff packet for separate implementation session unless user explicitly requests in-session implementation.

4. Escalations
- Relay decision questions verbatim.
- Hard-pause until explicit user decision.

## Guardrails
- Promotion hygiene: `Brainstormed` and `Specd` must be mutually exclusive for a given item title.
- Never implement from `Brainstormed`.
- Never mark `ready` from chat-only approval.
- Never prune `Specd` items before PR merge.
- Keep current file(s) compact; remove stale text after merge.

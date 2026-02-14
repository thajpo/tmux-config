---
name: lean-flow
description: "Chat-first planning orchestration for Brainstormed -> Specd -> Ready in current.md, with manual markdown approval required before GitHub issue handoff."
---

# Lean Flow

## Goal
Keep planning minimal, explicit, and user-controlled while preserving a strict review gate before GitHub issue handoff.

## Canonical Planning Files
Choose one mode per repo.

1. Single-file mode (default)
- Use `current.md`.

2. ML split mode
- Use `code_current.md` for implementation planning.
- Use `research_current.md` for experiment planning and run history.

Mode is repo-level and fixed. Do not switch modes within the same repo.

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
- Items in `Brainstormed`/`Specd` may be merged, split, or reorganized before `ready` approval.
- Promotion is a move, not a copy: once promoted to `Specd`, remove the item from `Brainstormed` in the same edit.
- Do not keep duplicate entries, placeholders, or "promoted" stubs in `Brainstormed`.

3. Ready (issue-eligible)
- Requires manual user approval evidence in markdown file.
- Chat approval alone is not sufficient.
- Approval evidence must be present under the item before status becomes `ready`.
- `ready` means "ready for GitHub issue creation."
- `ready` is not implementation permission.

4. GitHub Issue (execution handoff)
- Every code change requires exactly one linked GitHub issue.
- Create exactly one GitHub issue per ready item before implementation starts.
- Do not batch multiple ready items into one issue.
- Issue body must include the full approved spec contract schema verbatim.
- Use the standardized issue template in `references/issue-template.md`.
- Implementation may begin only after issue creation.

5. Current.md Compaction Lifecycle
- When issue is created for a ready item, remove full spec body from `Specd`.
- Replace it with a compact tracker entry:
  - `<id/title> | status: issued | issue: <url-or-#>`
- Do not track PR state in `current.md`; PR lifecycle lives in GitHub.
- When PR is merged, remove the tracker entry from `current.md`.
- Do not remove the item at issue creation without leaving a compact tracker line.

## Spec Contract Schema (required before Ready)
Each `Specd` item must include all fields below before it can become `ready`:
- `title`
- `status` (`draft|in_progress|ready|issued`)
- `behavior change` (explicit contract delta)
- `surfaces touched` (files/modules/functions)
- `estimated diff size` (S/M/L with short rationale)
- `acceptance tests` (fail-first + regression expectations)
- `edge cases` (at least one concrete edge condition)
- `non-goals`
- `risks and rollback trigger`
- `overlap analysis` (shared surfaces/conflicts + merge-vs-split decision)
- `manual approval evidence`:
  - approver identity (user)
  - approval date
  - explicit scope approved
  - unresolved blockers: none

If any schema field is missing, keep status as `draft`/`in_progress`.

## Manual Approval Evidence (required)
Before marking `Specd: ready`, planning file must include:
- approver identity (user)
- approval date
- explicit scope approved
- unresolved blockers: none

If evidence is missing, keep status as `draft`/`in_progress` and continue chat refinement.

## Overlap-First Rule (required before Ready)
For each candidate ready item, perform surface-overlap checks against other Specd items:
- shared files/functions/modules
- behavior or contract conflicts
- merge-vs-split recommendation

Record overlap decision in the spec item.

## Ownership Boundaries
- `lean-flow` owns planning state and file hygiene.
- `$spec-gate` owns interrogation and readiness checks.
- Lean-flow does not orchestrate implementation.

## User-Facing Commands
- `Use $lean-flow migrate-repo`
- `Use $lean-flow capture idea: ...`
- `Use $lean-flow add belief: ...`
- `Use $lean-flow interrogate "<title>"`
- `Use $lean-flow promote "<title>" to Specd`
- `Use $lean-flow mark "<title>" ready` (only with full schema + manual approval evidence in file)
- `Use $lean-flow issue "<title>"` (create issue and compact to tracker line)
- `Use $lean-flow prune merged Specd items`

## Routing Rules
1. Interrogate/Promote
- Invoke `$spec-gate`.
- Keep in `Specd` draft until blockers are resolved.

2. Mark Ready
- Invoke `$spec-gate` readiness checks.
- Require full spec schema + overlap record + manual approval evidence in markdown.

3. Issue handoff
- Do not implement from `lean-flow`.
- Ensure GitHub issue exists for the ready item.
- Ensure issue body contains the full approved spec contract.

4. Escalations
- Relay decision questions verbatim.
- Hard-pause until explicit user decision.

## Guardrails
- Promotion hygiene: `Brainstormed` and `Specd` must be mutually exclusive for a given item title.
- Never implement from `Brainstormed`.
- Never mark `ready` from chat-only approval.
- Never start implementation for a ready item without a linked GitHub issue.
- Never prune `Specd` items before PR merge.
- Keep current file(s) compact; remove stale text after merge.

## References
- `references/issue-template.md`
- `references/tracker-lifecycle.md`

---
name: lean-flow
description: "Chat-first planning workflow for Brainstormed -> Specd -> ready -> issue in current.md, with strict markdown approval evidence."
---

# Lean Flow

## Goal
Keep planning explicit and minimal, then hand off to GitHub issue/PR execution without ambiguity.

## Canonical Planning File
- Default: `current.md`.
- Mode is repo-level and fixed.
- Do not switch planning modes inside the same repo.

## Required Sections
- `Institutional Knowledge`
- `Beliefs`
- `Brainstormed`
- `Specd`

## Workflow
1. Brainstormed
- Capture ideas only; no implementation.

2. Specd (draft/in_progress)
- Convert selected ideas to concrete contracts.
- Promotion is move-not-copy: remove promoted item from `Brainstormed`.

3. Ready
- Requires full schema and markdown approval evidence.
- Chat-only approval is never enough.

4. Issue
- Create exactly one GitHub issue per ready item before implementation.
- Issue body must include full approved spec contract.

5. Tracker compaction
- Replace full `Specd` body with:
  - `<id/title> | status: issued | issue: <url-or-#>`
- Do not track PR state in `current.md`.
- Remove tracker line after PR merge.

## Spec Contract Schema (required before `ready`)
- `title`
- `status` (`draft|in_progress|ready|issued`)
- `user intent`
- `behavior change`
- `surfaces touched`
- `file touch scope` (allowed files/globs only)
- `estimated diff size` (S/M/L + rationale)
- `acceptance tests` (fail-first + regression)
- `edge cases`
- `non-goals`
- `risks and rollback trigger`
- `overlap analysis`
- `manual approval evidence`:
  - approver identity
  - approval date
  - explicit scope approved
  - unresolved blockers: none

## Authority Switch
- Pre-issue: planning contract in `current.md` is source of truth.
- Post-issue: issue body is implementation contract source of truth.
- Post-PR: PR thread/review feedback is iteration source of truth.
- If conflict exists, latest explicit user instruction in PR context wins.

## Routing
- Use `$spec-gate` for interrogation/readiness checks.
- Use `$issue-handoff` to create issue + compact tracker line.
- Use `$worktree-manager` for branch/worktree lifecycle.
- Use `$pr-iterate` for PR feedback loop.
- Use `$pr-scope-guard` for out-of-scope file detection.

## Guardrails
- Never implement from `Brainstormed`.
- Never mark `ready` without full schema + markdown approval evidence.
- Never implement without a linked issue.
- Never batch multiple ready items into one issue.
- Never touch files outside `file touch scope` without explicit user approval.
- Never prune tracker lines before merge.

## References
- `references/issue-template.md`
- `references/tracker-lifecycle.md`

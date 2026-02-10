---
name: project-os
description: "Primary workflow skill. Own current.md, run Q&A in Brainstormed, promote approved items to Specd, enforce approval TTL, dependency invalidation, and final merge/prune decisions."
---

# Project OS

## Goal
Run the full planning and acceptance lifecycle with `current.md` as the canonical context store.

## Core Model
- `Brainstormed` is discovery + Q&A.
- `Specd` is approved, implementation-ready contracts only.
- Never treat `Specd` as draft space.

## Required Sections in `current.md`
- `Institutional Knowledge`
- `Beliefs`
- `Brainstormed`
- `Specd`

## Brainstormed Rules
- Keep Q&A append-style under the active brainstorm item.
- Capture user intent in plain language; context is first-class.
- Use Q&A to merge related brainstorms into coherent features.
- Record dependency relations explicitly (`A depends on B`, `unblocks`, `parallelizable`).

### Mandatory Q&A Coverage (before promotion)
- behavior boundary: what changes, and what must stay unchanged
- non-goals: explicit exclusions
- tests: fail-first and regression scope
- risk/rollback: main risks and rollback trigger
- overlap/dependency: merge/split decision with other items

## Promotion Gate (Brainstormed -> Specd)
Promote only when all are explicit and user-confirmed:
- behavior change
- must stay unchanged
- files to touch
- fail-first tests
- regression tests
- non-goals
- risks
- rollback trigger
- touch points
- expected diff shape
- review checks

If incomplete, keep refining in `Brainstormed`.

### Brainstorm Cleanup on Promotion
- When an item (or sub-item slice) is promoted to `Specd`, remove that promoted content from `Brainstormed` immediately.
- Keep only unresolved brainstorm material in `Brainstormed`.
- Avoid duplicated active specs across both sections.

### Promotion Output Record
On each promotion decision, record:
- compact Q&A transcript
- blocker list (empty if none)
- decision (`ready` or `not ready`) with rationale

## Approval Signature Policy
User does not edit `current.md` manually.
- User message `yes` after Q&A is the approval signal.
- Agent writes approval metadata into the `Specd` item.

Required approval fields:
- `approved_by: user`
- `approval_signal: "yes"`
- `approved_on: YYYY-MM-DD`
- `expires_on: YYYY-MM-DD` (+5 days)
- `approval_status: valid|stale|invalidated`
- `approval_basis: <short summary>`

## Approval Expiry and Invalidation
- Approval expires after 5 days -> `approval_status: stale`.
- Dependency changes always invalidate approval -> `approval_status: invalidated`.

### Dependency Change Definition
Invalidate approval if any of these change after approval:
- upstream/downstream spec status or contract relevant to this item
- overlapping touch points/files due to other in-flight or merged work
- schema/interface assumptions this item relies on
- execution order constraints (`depends_on`/blocking relationships)
- new risk that changes acceptance or rollback expectations

Do not invalidate for doc typos/comments-only edits.
If uncertain, fail safe: treat as dependency change and re-approve.

## Implementation Routing
- Implementation is done by a separate worker agent/window using the approved `Specd` contract.
- `project-os` remains planner, reviewer, and final merge decision-maker.

## Post-Merge Hygiene
- Log merged feature in `Institutional Knowledge` with:
  - date
  - feature/spec title
  - commit SHA
  - commit subject
- After merge, remove completed `Specd` items.
- Do not keep merged spec details in `Brainstormed`; keep only remaining open work.
- Keep historical context in git, not stale planning entries.

## Guardrails
- Never implement directly from `Brainstormed`.
- Never promote without explicit Q&A evidence.
- Never proceed with stale/invalidated approval.
- Never prune `Specd` items before merge.

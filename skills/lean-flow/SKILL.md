---
name: lean-flow
description: "Orchestrate minimal planning for software and ML repos in current.md (or code_current.md + research_current.md). Use when managing Brainstormed to Specd lifecycle and invoking implementation/review through chained internal skills."
---

# Lean Flow

## Goal
Keep planning minimal, explicit, and user-controlled while delegating execution to chained subskills.

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

## Ownership Boundaries
- `lean-flow` owns planning state and file hygiene.
- `$spec-gate` owns interrogation and promotion to `Specd: ready`.
- `$pr-subagent-flow` owns implementation dispatch, test/regression validation, and PR review chain.

## User-Facing Commands
- `Use $lean-flow migrate-repo`
- `Use $lean-flow capture idea: ...`
- `Use $lean-flow add belief: ...`
- `Use $lean-flow interrogate "<title>"`
- `Use $lean-flow promote "<title>" to Specd`
- `Use $lean-flow implement spec "<title>"`
- `Use $lean-flow implement spec`
- `Use $lean-flow prune merged Specd items`

## Routing Rules
1. Interrogate/Promote
- Invoke `$spec-gate`.
- Mark `ready` only if the interrogation gate passes.

2. Implement Spec
- Require status `Specd: ready`.
- If no title is given and exactly one `ready` item exists, use it.
- If multiple `ready` items exist, request explicit user selection.
- Invoke `$pr-subagent-flow` internally.

3. Escalations
- Relay subagent decision questions verbatim.
- Hard-pause until explicit user decision.

## Guardrails
- Never implement from `Brainstormed`.
- Never implement in `lean-flow` itself.
- Never prune `Specd` items before PR merge.
- Keep current file(s) compact; remove stale text after merge.

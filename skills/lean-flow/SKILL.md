---
name: lean-flow
description: "Orchestrate minimal planning for software and ML repos in current.md (or code_current.md + research_current.md). Use when managing Brainstormed to Specd lifecycle and invoking implementation/review through chained internal skills."
---

# Lean Flow

## Goal
Keep planning minimal, explicit, and user-controlled while delegating execution to chained subskills.

## Operator Stance
- Treat plain-language user intent as valid workflow input (for example, "let's implement X").
- The user defines goals and priorities; `lean-flow` enforces process gates and prerequisites.
- Keep the user accountable to the declared workflow by blocking invalid transitions and stating exactly what gate is missing.
- Do not require command syntax when intent is clear.

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
- `Use $lean-flow status`
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
- Promotion must be explicit and user-visible: present interrogation Q&A and resolved answers before changing status.
- Never auto-promote based on inferred completeness from existing notes.

2. Implement Spec
- Require status `Specd: ready`.
- If no title is given and exactly one `ready` item exists, use it.
- If multiple `ready` items exist, request explicit user selection.
- Invoke `$pr-subagent-flow` internally.

3. Escalations
- Relay subagent decision questions verbatim.
- Hard-pause until explicit user decision.

4. Status
- Produce a concise execution snapshot for the current repo/session.
- Include both git state and planning state in one response.

## `status` Output Contract
Return sections in this order:

1. Repo Snapshot
- current repo path and branch
- `git status --short --branch` summary
- ahead/behind/diverged indicator vs upstream
- unstaged/staged/untracked file counts

2. Change Surface
- short file list grouped by area (if small)
- if large diff, top touched directories + total files changed
- latest 5 commits (`git log --oneline -n 5`)

3. Planning Snapshot
- active planning mode (`current.md` vs split mode)
- counts by section: `Brainstormed`, `Specd` (ready/in_progress/blocked)
- selected/active spec title (if any)
- stale item warning if entries look abandoned

4. Execution Pipeline Health
- whether a `Specd: ready` item exists
- whether implementation can be dispatched now
- blockers requiring user decision

5. Next Best Action
- exactly 1 recommended next action command
- include fallback command if blocked

## `status` Guardrails
- Do not modify files.
- Do not trigger implementation subagents.
- If not in a git repo, still report planning snapshot and note git state as unavailable.
- Keep output compact and decision-oriented.

## Guardrails
- Never implement from `Brainstormed`.
- Never implement in `lean-flow` itself.
- Never prune `Specd` items before PR merge.
- Keep current file(s) compact; remove stale text after merge.
- Never change `Brainstormed` -> `Specd: ready` without an explicit interrogation transcript (question + answer) in-session.
- When user asks to implement from plain language, enforce `Specd: ready` and route through required subskills before any code execution.

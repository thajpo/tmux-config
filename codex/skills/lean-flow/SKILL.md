---
name: lean-flow
description: "Minimal planning workflow for software and ML repos. Uses one active file by default, or split code/research current files for experimentation-heavy work."
---

# Lean Flow

## Goal
Keep planning minimal and current.
- Default software flow: one active planning file.
- ML/experimentation flow: split code planning from research planning while keeping run logs separate.
- Promotion from `Brainstormed` to `Specd` must pass a mandatory clarification gate to prevent ambiguous specs.

## Canonical File Mode
Choose one mode per repo/session:

1. Single-file mode (default)
- Use `current.md` at repo root.
- If missing, create it.

2. ML split mode (for experimentation-heavy repos)
- Use `code_current.md` for implementation planning.
- Use `research_current.md` for experiment planning and interpretation.
- Use `research_current.md` as the research planning + run ledger (executed runs/results), not as code implementation spec.

Do not create extra planning files unless explicitly requested.
- Minimize markdown file count; avoid `.md` clutter.
- For larger feature changes/refactors, one temporary `temp.md` is allowed until PR review/merge, then delete it.

## Required Sections (for each active current file)
- `Institutional Knowledge`
- `Beliefs`
- `Brainstormed`
- `Specd`

## Section Semantics
- `Institutional Knowledge`: stable repo truths and principles.
- `Beliefs`: working assumptions/preferences that guide decisions and can be validated or changed.
- `Brainstormed`: loose ideas and exploratory notes; not ready to implement.
- `Specd`: concrete implementation contracts in lifecycle (`ready|in_progress|review`) and ready for coding/review.

## Specd Lifecycle and PR Gate
- Use only these statuses for `Specd` items: `ready`, `in_progress`, `review`.
- `review` means there is an active PR under review with the user.
- Do not prune from `Specd` on local commit; prune only after PR merge.
- `ready` requires passing the Promotion Interrogation Gate.

## Allowed Operations
1. Migrate repo:
- Ensure canonical file(s) for the selected mode exist with required sections.
- Scan existing planning markdown files and consolidate relevant content.
- Move stable rules to `Institutional Knowledge`, assumptions to `Beliefs`, loose ideas to `Brainstormed`, and ready contracts to `Specd`.
- Preserve historical run outcomes in `research_current.md`.
- Propose stale file cleanup after migration.

2. Capture idea:
- Append to `Brainstormed` with concise title + notes.
- The user may add inline comments (often `//`). Fold those into the same item so evolution stays traceable.
- Inline `//` comments can be added anywhere in active current file(s); treat them as edit directives for the local section/item.
- After discussion converges, rewrite the affected section in place to reflect the latest agreed state.
- Do not keep append-only assistant reply threads inside planning sections once decisions are integrated.
- Preserve enough context to detect overlap and merge related brainstorms into stronger abstractions.

3. Add or update belief:
- Append to `Beliefs`.
- Include date, rationale, and optional evidence link when available.

4. Promote brainstorm to specd:
- Move an item from `Brainstormed` to `Specd`.
- When promoting, fill the required spec contract fields.
- Promotion must pass operation 5 (Promotion Interrogation Gate).

5. Promotion Interrogation Gate (mandatory):
- Run a forced question-and-answer pass before marking any item `ready`.
- Ask targeted, blocking questions even for seemingly simple changes.
- Minimum required question coverage:
  - exact behavior boundary (what changes vs what must stay unchanged)
  - non-goals and excluded surfaces
  - fail-first test strategy and regression scope
  - risk and rollback criteria
  - overlap check against other `Brainstormed`/`Specd` items
- If answers are weak, contradictory, or underspecified, push back explicitly and request revision.
- Do not mark `ready` while blocking questions remain unresolved.
- If overlap is detected, propose merge/split and update titles/scopes before promotion.

6. Prune merged specs:
- Remove merged items from `Specd` only after PR merge (not after local commit).
- Git history is the source of truth for completed implementation; commit messages should make feature history easy to follow.

7. Research/run logging discipline (ML split mode):
- Keep `research_current.md` as append-only research history (hypothesis, config delta, run id, outcome, decision).
- Do not implement directly from `research_current.md`; implementation must come from `Specd` in active current file(s).

8. PR review subagent discipline:
- In `review` status, run a focused review pass over active PRs with the user.
- Findings-first output: severity ordering, file/line references, regression/test gaps.
- Feed accepted findings back into code changes or follow-up `Brainstormed`/`Specd` items.

9. Temporary planning note lifecycle:
- For large feature/refactor efforts, create at most one `temp.md` in repo root as a short-lived working note.
- Move durable outcomes into active current file(s) before PR review.
- Delete `temp.md` after PR merge (or when abandoned).

10. Inline comment resolution protocol:
- During active planning, preserve user inline comments (`//`) as first-class change requests.
- Use append notes only while a point is unresolved.
- Once resolved in chat, consolidate by rewriting the section/body (not by appending a transcript).
- Keep one concise decision note only when rationale would otherwise be lost.

## Required Spec Contract (for each `Specd` item)
- behavior change
- files to touch
- fail-first tests
- non-goals
- risks
- touch points (path + function/class/block)
- line anchors (optional, reviewer convenience only)
- expected diff shape (add/modify/delete + rough LOC)
- review checks

## Guardrails
- Never implement directly from `Brainstormed`.
- Only implement items in `Specd`.
- Never mark an item `ready` without passing the Promotion Interrogation Gate.
- Challenge weak or contradictory user answers; do not silently paper over ambiguity.
- Require overlap check and merge/split decision before promotion.
- Use append-style while exploring; once decisions are made, prefer in-place section rewrites over append-only logs.
- Keep current file(s) compact; remove stale text after promotion or merge.
- Avoid markdown file sprawl; use only canonical current file(s) plus optional temporary `temp.md` for large feature/refactor work.
- During active sweeps, avoid unrelated refactors unless explicitly requested.
- Never prune `Specd` items before PR merge.

## Suggested Chat Commands
- `Use $lean-flow migrate-repo`
- `Use $lean-flow migrate-repo in ML split mode`
- `Use $lean-flow to capture idea: ...`
- `Use $lean-flow add belief: ...`
- `Use $lean-flow interrogate "<title>" for promotion`
- `Use $lean-flow promote "<title>" to Specd`
- `Use $lean-flow prune merged Specd items`
- `Use $lean-flow review active PRs`

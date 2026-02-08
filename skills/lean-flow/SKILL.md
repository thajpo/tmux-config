---
name: lean-flow
description: "Minimal planning workflow for software and ML repos. Uses one active file by default, or split code/research current files for experimentation-heavy work. Use when managing Brainstormed->Specd promotion and dispatching Specd implementation to a separate subagent process."
---

# Lean Flow

## Goal
Keep planning minimal and current.
- Default software flow: one active planning file.
- ML/experimentation flow: split code planning from research planning while keeping run logs separate.
- Promotion from `Brainstormed` to `Specd` must pass a mandatory clarification gate to prevent ambiguous specs.
- For implementation dispatch and PR review execution, delegate internally to `$pr-subagent-flow`.
- Subagent execution must be transparent to the user with immediate escalation visibility.
- Direct subagent communication is the default: relay subagent text verbatim unless the user explicitly asks for summarization.

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

## Subagent Execution Contract (Normative)
- Parent/coordinator MUST spawn a separate subagent process/session for implementation dispatch.
- Parent/coordinator MUST NOT execute implementation commands itself for dispatched work.
- Parent/coordinator MUST NOT run fail-first/pass test commands itself for dispatched work.
- Parent/coordinator MUST report launch evidence before execution begins: subagent runner, session/job id (or PID), branch/worktree.
- If separate subagent launch is unavailable, parent/coordinator MUST escalate immediately and hard-pause.
- Simulating dispatch by doing work in the parent session is forbidden.

## User-Facing Execution Trigger
- Users interact only with `lean-flow`.
- `implement spec "<title>"` means:
  - verify `<title>` is `Specd: ready`,
  - internally invoke `$pr-subagent-flow` dispatch using a separate subagent process,
  - return subagent branch/PR evidence,
  - run findings-first PR review with user.
- If title is omitted and exactly one `ready` item exists, use it.
- If multiple `ready` items exist, request explicit selection.

## Subagent Visibility And Escalation Policy
1. Pre-dispatch visibility
- Show the dispatch packet summary before launch:
  - spec title, scope, non-goals, branch/worktree, test command contract.

2. Live execution visibility
- Provide frequent progress checkpoints:
  - current phase (`preflight`, `fail-first`, `implementation`, `retest`, `report`),
  - command being run by the subagent,
  - concise outcome.

3. Immediate escalation visibility
- If subagent escalates, surface it to the user immediately with:
  - blocker type,
  - attempted command,
  - key failure output,
  - files changed so far,
  - exact decision required from user.
- If escalation requires a user decision, the subagent must ask one explicit question and remain alive awaiting the answer.

4. Hard pause on escalation
- On escalation, stop execution flow and wait for explicit user decision.
- Do not auto-retry with new strategy.
- Do not auto-install dependencies or widen scope without user approval.
- Do not terminate the subagent session after asking a decision question unless the user explicitly requests termination.

5. Post-run visibility
- Provide final evidence summary:
  - changed files,
  - fail-first -> pass outputs,
  - residual risks/open questions.

6. Verbatim relay policy
- Parent/coordinator MUST relay subagent questions and user-directed statements verbatim.
- Parent/coordinator MUST NOT paraphrase, summarize, tone-shift, or simplify subagent decision questions unless the user explicitly asks.
- Parent/coordinator MAY add separate coordinator context (for example phase, pid, branch) but MUST keep it clearly separated from verbatim subagent text.

## Allowed Operations
1. Migrate repo
- Ensure canonical file(s) for the selected mode exist with required sections.
- Consolidate planning content into canonical current file(s).
- Preserve historical run outcomes in `research_current.md`.

2. Capture idea
- Append concise idea notes to `Brainstormed`.
- Treat inline `//` comments as edit directives.
- After convergence, rewrite sections in place.

3. Add or update belief
- Append to `Beliefs` with date and rationale.

4. Promote brainstorm to specd
- Move item from `Brainstormed` to `Specd`.
- Fill required spec contract fields.
- Promotion must pass operation 5.

5. Promotion Interrogation Gate (mandatory)
- Run forced Q&A before marking `ready`.
- Cover boundary, non-goals, fail-first strategy, risk/rollback, overlap check.
- Push back on weak or contradictory answers.
- Resolve merge/split decisions for overlapping items.

6. Prune merged specs
- Remove from `Specd` only after PR merge.

7. Research/run logging discipline (ML split mode)
- Keep `research_current.md` append-only for experiment history.
- Do not implement directly from `research_current.md`.

8. Dispatch + PR review delegation
- Dispatch and PR review mechanics belong to `$pr-subagent-flow` (internal delegation).
- Lean Flow owns planning state transitions and user-facing command routing.

9. Temporary planning note lifecycle
- At most one temporary `temp.md` for large feature/refactor work.
- Move durable outcomes into current file(s) before PR review.
- Delete `temp.md` after PR merge (or abandonment).

10. Inline comment resolution protocol
- Preserve inline `//` while unresolved.
- Consolidate resolved points by rewriting section content.

## Required Spec Contract (for each `Specd` item)
- behavior change
- files to touch
- fail-first tests
- non-goals
- risks
- touch points (path + function/class/block)
- line anchors (optional)
- expected diff shape (add/modify/delete + rough LOC)
- review checks

## Guardrails
- Never implement directly from `Brainstormed`.
- Only implement items in `Specd`.
- Never mark an item `ready` without passing the Promotion Interrogation Gate.
- Never prune `Specd` items before PR merge.
- Never suppress or summarize away a subagent escalation.
- On escalation, pause and wait for explicit user decision.
- Never allow a dispatched run to pass when a subagent prints a decision question and then exits before receiving an answer.
- Keep current file(s) compact and avoid markdown sprawl.
- Never run implementation or required test commands in the parent/coordinator session for dispatched specs.
- Never filter or rewrite subagent decision questions by default.

## Suggested Chat Commands
- `Use $lean-flow migrate-repo`
- `Use $lean-flow migrate-repo in ML split mode`
- `Use $lean-flow capture idea: ...`
- `Use $lean-flow add belief: ...`
- `Use $lean-flow interrogate "<title>" for promotion`
- `Use $lean-flow promote "<title>" to Specd`
- `Use $lean-flow implement spec "<title>"`
- `Use $lean-flow implement spec`
- `Use $lean-flow prune merged Specd items`

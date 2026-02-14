---
name: pr-subagent-flow
description: "Execution/review chain for ready specs, used only when explicitly requested. Default lean-flow path is manual implementation handoff plus review."
---

# PR Subagent Flow

## Goal
Run a strict execution pipeline for a `Specd: ready` item when this flow is explicitly requested.

## Default Behavior
- Do not auto-run from `lean-flow`.
- Use only when user explicitly requests subagent orchestration.

## Chain Order
1. `$subagent-dispatch`
- Spawn separate implementation subagent process/session.
- Produce launch evidence + implementation report.

2. `$test-regression-guard`
- Run independent verification (prefer separate verifier subagent).
- Validate fail-first -> pass evidence.
- Check regression risk, missing tests, and suspicious test-only changes.

3. `$pr-review-gate`
- Produce findings-first review package with severity/file-line references.

4. `$escalation-gate` (called at any stage)
- Standardize blocker packet.
- Ask one explicit question.
- Keep process alive; hard-pause for user decision.

## Preconditions
- Source item is in `Specd` and status is `ready`.
- Manual approval evidence exists in markdown.
- Spec contract fields are complete.

## Parent/Coordinator Rules
- Orchestration only.
- Never execute implementation commands for dispatched specs.
- Never backfill required test evidence in parent session.
- Relay subagent decision questions verbatim.

## Mandatory Escalation Triggers
- Subagent launch cannot be verified.
- Required tests cannot run.
- Failures occur outside expected fail-first scope.
- Spec ambiguity, contradiction, or overlap is discovered.
- Out-of-scope file touch or diff expansion is required.
- Required evidence is missing.

## Output Contract
Return one package containing:
- branch/worktree,
- subagent launch evidence,
- changed files,
- fail-first output,
- pass output,
- regression/test guard verdict,
- PR review findings,
- residual risks,
- blocker packet (if blocked).

## References
- `references/chain-contract.md`
- `references/dispatch-prompt-template.md`
- `references/pr-review-checklist.md`

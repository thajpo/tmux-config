---
name: pr-subagent-flow
description: "Internal execution skill for lean-flow: dispatch ready Specd items to a separate implementation subagent process and run findings-first PR review with strict fail-first/pass evidence."
---

# PR Subagent Flow

## Goal
Provide a strict, reusable internal protocol for:
- subagent implementation dispatch from a `Specd` contract,
- required fail-first -> pass evidence (prefer `uv`),
- findings-first PR review.

Parent/coordinator agent is orchestration-only in this flow:
- prepare handoff,
- launch subagent,
- collect evidence,
- review PR with user.

## Role Definitions (Normative)
- Parent/coordinator: orchestration only; never executes implementation/test work for dispatched specs.
- Subagent: separate spawned process/session that executes the implementation contract.
- "Dispatch" always means launching a separate subagent process/session; it never means local self-execution in the parent.

## Invocation Policy
- This skill is internal to `lean-flow` execution.
- Users should not need to invoke it directly.
- If called directly, proceed, but preserve the same strict gate behavior.
- Parent/coordinator MUST spawn a separate subagent process/session before implementation starts.
- If subagent launch is unavailable, parent/coordinator MUST escalate and hard-pause.

## Decision Authority (strict)
- Subagent is not a decision-maker.
- Subagent may execute only what the `Specd` contract states.
- Any ambiguity or uncovered decision point requires escalation before continuing.
- If escalation requires user input, subagent must ask a concrete question and remain alive awaiting input.

## User/Subagent Communication Policy (Normative)
- Default mode is direct and verbatim.
- Parent/coordinator MUST forward subagent user-directed output verbatim.
- Parent/coordinator MUST NOT paraphrase, summarize, redact, normalize tone, or simplify subagent decision questions unless the user explicitly asks.
- Parent/coordinator MAY append separate orchestration metadata (phase, pid/session id, branch/worktree), but must keep it clearly distinct from verbatim subagent text.
- When the subagent asks a decision question, parent/coordinator MUST relay that exact question text and then hard-pause.

## Mandatory Escalation Conditions
Stop and escalate immediately when any of these occur:
1. dependency/environment issue blocks required commands,
2. any required test cannot run,
3. tests fail outside expected fail-first scope,
4. spec ambiguity or contradiction is detected,
5. overlap with another active spec is discovered,
6. requested change exceeds `expected diff shape`,
7. touching files/surfaces outside `files to touch` appears necessary,
8. subagent launch fails or cannot be verified.

## Required Inputs
Before dispatch, confirm:
- canonical spec location and title (for example `code_current.md` + item title),
- `Specd` status is `ready`,
- repo path + target branch/worktree strategy,
- test runner contract (prefer `uv` where configured),
- acceptance evidence requirements.

## Workflow
1. Preflight
- Verify `Specd` is complete and `ready`.
- Verify no unresolved blocking questions.
- Verify intended scope/non-goals are explicit.

2. Build Handoff Packet
- Extract full `Specd` contract fields verbatim.
- Add explicit `environment_contract`:
  - runner command(s),
  - env vars (for example `UV_CACHE_DIR`),
  - interpreter selection if needed.
- Add explicit `stop_conditions` (must include mandatory escalation list above).
- Add explicit `relay_contract`:
  - forward user-facing subagent output verbatim,
  - preserve exact decision question wording,
  - keep wait state alive until user answer.

3. Dispatch
- Use isolated branch/worktree.
- Spawn separate subagent process/session.
- Send only the scoped handoff packet.
- Require subagent report format from `references/dispatch-prompt-template.md`.
- Record launch evidence: runner command, session/job id (or PID), and start timestamp.

4. Evidence Gate
- Required evidence:
  - launch evidence for the spawned subagent,
  - changed files list,
  - fail-first command output,
  - pass command output,
  - residual risks/open questions,
  - explicit blocker report if escalation occurred.
- If evidence is missing, item cannot move to PR review.
- If blocker evidence includes a decision question, dispatch fails unless there is proof of a live wait state or resumed execution after user input.

5. Setup Blocker Protocol
- If subagent cannot run required tests because of environment/tooling:
  - stop implementation acceptance,
  - return concrete setup-fix requirements,
  - do not have parent agent backfill implementation.
- If subagent cannot be launched:
  - stop dispatch,
  - escalate with concrete launch blocker,
  - wait for user decision.

6. PR Review
- Run findings-first review (severity ordered, file/line refs, regression/test gaps).
- Feed accepted findings back as code changes or follow-up `Specd` items.

7. Status Transitions
- `ready` -> `in_progress`: dispatch accepted and subagent launch evidence captured.
- `in_progress` -> `review`: PR opened with evidence.
- prune from `Specd` only after PR merge.

## Output Contract
Every dispatch cycle returns:
- branch/worktree info,
- subagent launch evidence,
- changed files,
- fail-first -> pass evidence,
- residual risks,
- explicit statement if blocked by setup.
- For decision-gated escalations: blocker question text (verbatim) and live wait evidence (or resumed execution evidence after user answer).

## Guardrails
- Parent/coordinator must not execute implementation/test commands intended for subagent evidence.
- Parent/coordinator must not simulate subagent execution in the same session.
- A subagent that asks a decision question and exits before receiving input is a failed dispatch, not a completed run.
- Parent/coordinator must not filter or rewrite subagent user-directed text by default.

## References
- Dispatch template: `references/dispatch-prompt-template.md`
- Review checklist: `references/pr-review-checklist.md`

## Suggested Internal Commands
- `Use $pr-subagent-flow dispatch "<Specd title>"`
- `Use $pr-subagent-flow fix setup blockers for "<Specd title>"`
- `Use $pr-subagent-flow review active PRs`

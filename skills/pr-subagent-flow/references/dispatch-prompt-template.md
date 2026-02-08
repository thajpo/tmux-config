# Dispatch Prompt Template

Use this template for implementation subagents.

## Header
- Repo: <path>
- Branch/worktree: <name/path>
- Spec title: <title>
- Source of truth: <code_current.md path + section>

## Contract
- behavior change:
- files to touch:
- fail-first tests:
- non-goals:
- risks:
- touch points:
- line anchors (optional):
- expected diff shape:
- review checks:

## Environment Contract
- runner: `uv ...`
- env vars: (for example `UV_CACHE_DIR=/tmp/uv-cache`)
- interpreter: (if needed)

## Relay Contract
- Keep user-directed subagent output direct and verbatim.
- Ask decision questions in one explicit sentence.
- Keep the process/session alive and waiting for user answer.

## Decision Rule
- Do not make decisions.
- Do not expand scope.
- If anything is unclear or outside contract, stop and escalate.

## Stop Conditions (mandatory)
Pause and report instead of continuing when:
1. required tests cannot run due environment/tooling,
2. tests fail outside the expected fail-first scope,
3. scope ambiguity appears,
4. overlap with another active spec appears,
5. forbidden or out-of-scope file touch is required,
6. diff exceeds expected shape without approval.

## Required Return Format
- changed files
- fail-first output (command + key failure)
- pass output (command + key success)
- residual risks/open questions
- setup blockers (if any)
- decision question text (verbatim, if asked)

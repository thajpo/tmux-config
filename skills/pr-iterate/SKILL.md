---
name: pr-iterate
description: "Primary execution command. From a ready/issued spec or PR, create/continue issue-scoped PR work and iterate on all PR feedback until merge-ready."
---

# PR Iterate

## Goal
Single entrypoint for execution: consume a ready/issued item or existing PR and drive it to merge-ready.

## Transition Contract (fail-closed)
- `ready -> issued` must run through `$issue-handoff` first.
- `issued -> in_pr` must run through `$worktree-manager` first.
- No code edits are allowed until issue-scoped branch/worktree mapping is created and verified.

## Input
- spec id/title in `ready`/`issued` state, or
- existing PR number.

## Authority
- After PR creation, PR thread/review feedback is the iteration source of truth.
- Latest explicit user instruction in PR context wins if conflict exists.

## Internal Helpers (auto-run)
- `$issue-handoff` (if issue does not exist yet)
- `$worktree-manager` (issue-scoped branch/worktree)
- `$pr-scope-guard` (file-touch scope enforcement)
- `$ci-baseline` (ensure/verify `lint` + `test` checks)

## Required Feedback Ingestion
Read all channels before each implementation round:
- @mentions / direct agent requests in PR conversation
- PR conversation comments
- review summaries/states
- inline review threads with file/line context
- unresolved thread state

Use `references/pr-feedback-sources.md` commands/APIs.

## Ingestion Gate (fail-closed)
- If any required feedback channel cannot be fetched, stop as `blocked`.
- Do not proceed with implementation on partial feedback visibility.
- Raise one explicit blocker question asking to retry/fix access.

## Iteration Loop
1. Resolve work item to issue + PR (create issue/PR if needed).
2. Ensure one issue -> one branch -> one worktree mapping.
3. Verify current branch/worktree maps to the issue; if mismatch, stop as `blocked`.
4. Build blocker/task list from unresolved feedback.
5. Implement fixes without expanding issue scope.
6. Run `lint` and `test`.
7. Commit and push branch updates.
8. Post or update `Agent Update` PR status (required format).

## Execution Defaults
- Commit + push are expected default steps during `$pr-iterate`.
- Do not ask for commit/push permission in normal flow.
- Ask only when blocked by missing scope, missing permissions, destructive action risk, or direct instruction conflict.

## Merge Boundary
- `$pr-iterate` drives to merge-ready state.
- Never ask or decide to merge the PR; user/reviewer owns merge decision.

## Completion Gates
- Do not declare completion while unresolved blocking feedback remains.
- Do not declare completion if `lint` or `test` fails.
- Do not silently ignore requested changes.
- Do not declare completion without ingestion evidence for all required channels.

## Required PR Status Update After Every Push
- Keep one primary `Agent Update` status comment per PR when possible.
- On first push: create the `Agent Update` comment.
- On subsequent pushes: edit/update the same comment instead of posting a new long comment.
- Post a new comment only when there is a major phase change (e.g., blocked -> unblocked, ready-for-review, or scope/risk escalation).
- Keep updates concise: include counts, decisions, and next actions; never paste full test logs.
- If tests fail, include only failing test identifiers and short error summary.
- Follow template in `references/agent-update-template.md`.

## Guardrails
- No out-of-scope file touches without explicit user approval.
- No hidden behavior changes.
- No test skipping to force pass.
- Never start implementation while on an unmapped/non-issue branch.

## References
- `references/pr-feedback-sources.md`
- `references/agent-update-template.md`
- `references/completion-gates.md`

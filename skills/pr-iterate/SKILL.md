---
name: pr-iterate
description: "Primary execution command. From a ready/issued spec or PR, create/continue issue-scoped PR work and iterate on all PR feedback until merge-ready."
---

# PR Iterate

## Goal
Single entrypoint for execution: consume a ready/issued item or existing PR and drive it to merge-ready.

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
- PR conversation comments
- review summaries/states
- inline review threads with file/line context
- unresolved thread state

Use `references/pr-feedback-sources.md` commands/APIs.

## Iteration Loop
1. Resolve work item to issue + PR (create issue/PR if needed).
2. Ensure one issue -> one branch -> one worktree mapping.
3. Build blocker/task list from unresolved feedback.
4. Implement fixes without expanding issue scope.
5. Run `lint` and `test`.
6. Push commits.
7. Post `Agent Update` PR comment (required format).

## Completion Gates
- Do not declare completion while unresolved blocking feedback remains.
- Do not declare completion if `lint` or `test` fails.
- Do not silently ignore requested changes.

## Required PR Comment After Every Push
Follow template in `references/agent-update-template.md`.

## Guardrails
- No out-of-scope file touches without explicit user approval.
- No hidden behavior changes.
- No test skipping to force pass.

## References
- `references/pr-feedback-sources.md`
- `references/agent-update-template.md`
- `references/completion-gates.md`

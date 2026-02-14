---
name: pr-iterate
description: "Run PR feedback loops by ingesting all PR feedback channels, implementing fixes on the PR branch/worktree, and posting mandatory status updates after each push."
---

# PR Iterate

## Goal
Treat the PR as the active work item and iterate until merge-ready.

## Preconditions
- Linked issue exists for the PR.
- Active branch/worktree is mapped to exactly one issue/PR.
- Baseline checks (`lint`, `test`) are runnable.

## Authority
- After PR creation, PR thread/review feedback is the iteration source of truth.
- Latest explicit user instruction in PR context wins if conflict exists.

## Required Feedback Ingestion
Read all channels before each implementation round:
- PR conversation comments
- review summaries/states
- inline review threads with file/line context
- unresolved thread state

Use `references/pr-feedback-sources.md` commands/APIs.

## Iteration Loop
1. Sync latest branch and PR metadata.
2. Build blocker/task list from unresolved feedback.
3. Implement fixes without expanding issue scope.
4. Run `lint` and `test`.
5. Push commits.
6. Post `Agent Update` PR comment (required format).

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

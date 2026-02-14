---
name: repo-init
description: "Bootstrap a repo with lean planning, issue/PR workflow contracts, worktree policy, and baseline GitHub PR checks."
---

# Repo Init

## Goal
Create a zero-setup baseline so each repo is immediately compatible with lean spec -> issue -> PR workflows.

## Outputs
- planning scaffold (`current.md` sections)
- workflow policy scaffold (`AGENTS.md` alignment)
- issue + PR templates
- baseline GitHub Actions for `lint` and `test`
- worktree policy notes

## Procedure
1. Verify repo root and existing docs.
2. Add missing planning sections:
- `Institutional Knowledge`
- `Beliefs`
- `Brainstormed`
- `Specd`
3. Ensure policy enforces:
- `Specd` requires explicit `user intent`.
- ready item must be converted to one GitHub issue before implementation.
- issue defines file-touch scope.
- one issue -> one branch -> one worktree -> one PR.
4. Add/update:
- `.github/ISSUE_TEMPLATE/spec-contract.md`
- `.github/pull_request_template.md`
- `.github/workflows/pr-checks.yml`
5. Return setup report with created/updated files and remaining manual steps.

## Guardrails
- Do not overwrite existing custom templates blindly; merge intent-preserving edits.
- If required tools are missing (`gh`, language toolchain), report blockers clearly.
- Keep contracts strict and fail-fast.

## References
- `references/issue-template.md`
- `references/pr-template.md`
- `references/pr-checks-workflow.yml`

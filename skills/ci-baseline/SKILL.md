---
name: ci-baseline
description: "Set up and enforce baseline GitHub PR checks (lint + test) plus lightweight regression anti-gaming signals."
---

# CI Baseline

## Usage
- Internal helper skill.
- Normally invoked by `$repo-init` and verified by `$pr-iterate`.

## Goal
Ensure every repo has minimum PR automation quality gates with predictable check names.

## Required Baseline
- PR workflow runs on `pull_request`.
- Includes `lint` job.
- Includes `test` job.
- Branch protection requires both checks before merge.

## Optional Anti-Gaming Signals
- Flag PRs touching production code with zero test changes.
- Flag suspicious test-only changes that remove assertions.
- Require explicit reviewer acknowledgment for any flagged signal.

## Procedure
1. Detect language/toolchain and map to lint/test commands.
2. Install/update `.github/workflows/pr-checks.yml`.
3. Ensure check names are stable (`lint`, `test`).
4. Verify checks run on current PR.
5. Report missing branch protection settings if not enforceable via local auth.

## Guardrails
- Do not silently disable checks to make PR green.
- Keep workflow simple and deterministic.
- Prefer fail-fast failures over flaky heuristics.

## References
- `references/pr-checks-workflow.yml`
- `references/branch-protection-checklist.md`
- `references/regression-signals.md`

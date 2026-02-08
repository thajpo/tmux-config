---
name: test-regression-guard
description: "Run independent test and regression validation for dispatched PRs, including missing tests and suspicious test-only changes intended to force merges."
---

# Test Regression Guard

## Goal
Catch both accidental regression risk and deliberate test-quality degradation.

## Preferred Execution Model
- Run in a separate verifier subagent from the implementation subagent.

## Inputs
- Spec contract.
- Branch/worktree + diff.
- Implementation evidence (fail-first and pass outputs).

## Required Checks
1. Evidence validation
- fail-first evidence is real and relevant.
- pass evidence is real and uses expected runner (`uv` when configured).

2. Regression coverage
- run targeted tests for touched surfaces.
- run required broader regression set from spec review checks.

3. Missing-test detection
- new/changed behavior without corresponding coverage.
- touched high-risk code paths lacking assertions.

4. Test-gaming detection
- weakened assertions,
- introduced `skip`/`xfail`/broad mocks to bypass behavior,
- test edits that reduce signal without justified reason,
- production-neutral test churn designed only to green CI.

5. History-aware context
- inspect recent git history around touched code/tests to flag suspicious divergence patterns.

## Verdicts
- `pass`: evidence + coverage acceptable.
- `blocked`: unresolved test/regression risk or ambiguous results.

## References
- `references/regression-checklist.md`
- `references/test-smells.md`

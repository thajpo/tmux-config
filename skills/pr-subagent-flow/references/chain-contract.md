# Chain Contract

## Stages
1. dispatch
2. test-regression
3. pr-review

## Gate Rule
- Stage `n+1` cannot start unless stage `n` has required evidence.

## Evidence Minimum
- launch evidence,
- changed files,
- fail-first and pass outputs,
- regression/test verdict,
- findings-first review output.

## Blocking Rule
Any blocker triggers escalation-gate and hard pause.

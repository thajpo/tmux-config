---
name: quality-gate
description: "Review and regression gate. Validate PR evidence against Specd contract and return a merge recommendation."
---

# Quality Gate

## Goal
Provide an independent, findings-first acceptance review before merge.

## Inputs
- approved `Specd` contract
- PR diff / changed files
- implementer evidence bundle

## Required Checks
1. Spec compliance
- Does behavior match the approved contract?
- Any scope drift?

2. Evidence integrity
- Is fail-first evidence present and relevant?
- Is pass/retest evidence present and relevant?

3. Regression confidence
- Were required regression surfaces tested?
- Any obvious untested risk in touched paths?

4. Risk review
- residual risks are explicit and actionable

## Verdicts
- `pass`
- `pass_with_risks`
- `blocked`

## Required Output
- verdict
- findings ordered by severity
- file/line references where possible
- missing evidence list
- merge recommendation

## Guardrails
- Missing or contradictory evidence -> `blocked`.
- Do not implement fixes in this gate; report only.

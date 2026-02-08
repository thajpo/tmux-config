---
name: pr-review-gate
description: "Run findings-first PR review for dispatched specs with severity ordering, file-line references, and explicit regression/test gaps."
---

# PR Review Gate

## Goal
Produce a strict, reviewer-friendly findings package before merge.

## Inputs
- Spec contract.
- PR diff and changed files.
- Test/regression guard report.

## Required Output Order
1. Findings by severity (highest first).
2. File/line references for each finding.
3. Regression and test gaps.
4. Open questions/assumptions.
5. Short change summary.

## Required Focus Areas
- Behavior correctness vs spec.
- Contract drift and scope violations.
- Missing/weak tests.
- Risky implementation shortcuts.

## Block Condition
If required evidence is missing or contradictory, mark review `blocked` and escalate.

## References
- `references/review-template.md`

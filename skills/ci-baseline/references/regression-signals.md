# Regression Anti-Gaming Signals

Use as review signals, not standalone merge blockers:

- production code changed with no test file changes
- test snapshot churn with no behavior rationale
- large test deletions in same PR as risky contract changes
- checks re-run pattern without code/test changes

When triggered:
- request explicit reviewer acknowledgment in PR thread
- require agent update comment to explain rationale

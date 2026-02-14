# Priority Rules

Sort open PRs for daily execution:

1. `blocked` PRs (highest): unblock quickly.
2. `agent_turn` with unresolved blocking feedback.
3. `agent_turn` with owner mention/request but no blocking thread.
4. `reviewer_turn` awaiting review decision.

Within each bucket:
- oldest unresolved owner/reviewer request first,
- then lower PR number first.

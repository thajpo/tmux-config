# Turn Rules

Compute turn per PR:

1. `blocked`
- Any required feedback channel failed to fetch.
- Required check status unavailable.

2. `agent_turn`
- Unresolved blocking review thread exists, or
- New reviewer/owner request exists after latest agent update, or
- `CHANGES_REQUESTED` state is present without subsequent agent response.

3. `reviewer_turn`
- No unresolved blocking feedback, and
- Latest agent update/comment or push addresses requested changes, and
- Waiting for review/approval/merge decision.

Tie-breaker:
- If uncertain, choose `agent_turn` and include explicit uncertainty reason.

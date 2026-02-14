# Tracker Lifecycle

## When ready item gets an issue
Replace full `Specd` body with:
- `<id/title> | status: issued | issue: <url-or-#>`

## After issue creation
- `current.md` tracks only issue state (`issued`).
- PR details are tracked in GitHub, not in `current.md`.
- Issue body is canonical implementation contract until PR exists.
- After PR exists, PR thread/review feedback is canonical iteration contract.

## When PR is merged
- Remove the tracker line from `current.md`.

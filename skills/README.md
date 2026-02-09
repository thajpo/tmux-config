# Local Skills Notes

## Workflow Rule
- Any time we edit dotfiles/config repos, we should commit and push in the same session.
- Preferred flow: `Use $git-cleanup draft-then-ship`.
- If push should be skipped for a specific case, explicitly state that in the request.

## Why
- Keeps Linux and Mac in sync.
- Reduces context loss when switching machines.
- Leaves a clear rollback point via commit SHA.

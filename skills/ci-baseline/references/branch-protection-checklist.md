# Branch Protection Checklist

- target branch: `main` (or repo default)
- require pull request before merge
- require status checks to pass before merge
- required checks include:
  - `lint`
  - `test`
- dismiss stale approvals when new commits are pushed (recommended)
- require conversation resolution before merge (recommended)

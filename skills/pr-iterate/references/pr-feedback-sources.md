# PR Feedback Sources

Read all of these each round:

1. PR conversation comments (includes @mentions)
```bash
gh pr view <pr> --comments
```

2. Review summaries/states
```bash
gh api repos/<owner>/<repo>/pulls/<pr>/reviews
```

3. Inline review comments
```bash
gh api repos/<owner>/<repo>/pulls/<pr>/comments
```

4. Review threads/unresolved state (GraphQL preferred)
```bash
gh api graphql -f query='
query($owner:String!, $repo:String!, $number:Int!) {
  repository(owner:$owner, name:$repo) {
    pullRequest(number:$number) {
      reviewThreads(first:100) {
        nodes {
          isResolved
          isOutdated
          comments(first:20) { nodes { body path line author { login } } }
        }
      }
    }
  }
}' -F owner=<owner> -F repo=<repo> -F number=<pr>
```

## Required Evidence Record (per iteration)
- total PR conversation comments fetched
- total @mentions/direct agent requests found
- total review summary entries fetched
- total inline review comments fetched
- total review threads fetched
- unresolved thread count
- timestamp of fetch

## Fail-Closed Rule
- If any fetch command fails, mark iteration blocked.
- Do not implement code changes until all channels are fetched successfully.

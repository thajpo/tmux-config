# PR Feedback Sources

Read all of these each round:

1. PR conversation comments
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

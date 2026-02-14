# Feedback Commands

Use these for each open PR:

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

4. Review threads + unresolved state
```bash
gh api graphql -f query='
query($owner:String!, $repo:String!, $number:Int!) {
  repository(owner:$owner, name:$repo) {
    pullRequest(number:$number) {
      reviewThreads(first:100) {
        nodes {
          isResolved
          isOutdated
          path
          comments(first:20) {
            nodes { author { login } body path line originalLine createdAt }
          }
        }
      }
    }
  }
}' -F owner=<owner> -F repo=<repo> -F number=<pr>
```

If any command fails, mark PR as `blocked`.

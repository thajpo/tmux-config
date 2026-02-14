---
name: pr-status
description: "Status board for open PRs: returns each PR's function, current turn owner, priority order, and linkage to current.md specs."
---

# PR Status

## Goal
Provide a single daily status board for PR operations and priority planning.

## Output
Return all open PRs with:
- PR id/title/url
- linked spec/issue function
- current phase
- whose turn (`agent_turn|reviewer_turn|blocked`)
- priority rank for today
- `current.md` linkage (`spec id`, `spec status`, mismatch flags)

## Required Inputs
- Repo open PR list
- PR conversation comments (including @mentions)
- review summaries/states
- inline review comments
- review threads + unresolved state
- `current.md` `Specd` section

## Procedure
1. Fetch all open PRs.
2. For each PR, ingest all feedback channels listed in references.
3. Map PR to spec id/function (prefer explicit `S#` in title/branch; fallback to issue/description).
4. Cross-check mapping against `current.md`.
5. Determine turn owner using `references/turn-rules.md`.
6. Rank priorities using `references/priority-rules.md`.
7. Return board using `references/output-template.md`.

## Fail-Closed Rule
- If any required feedback channel fails for a PR, mark that PR as `blocked`.
- Include explicit blocker reason and retry instruction.
- Do not infer turn ownership on partial feedback visibility.

## Turn Semantics
- `agent_turn`: actionable feedback exists and agent has not yet posted/landed response for latest reviewer/user requests.
- `reviewer_turn`: latest required agent update is posted and branch is awaiting review/merge decision.
- `blocked`: feedback or checks cannot be fully evaluated due fetch/access/tooling failure.

## Guardrails
- Never hide missing ingestion channels.
- Never mark `reviewer_turn` if unresolved blocking feedback remains.
- Always surface spec/PR drift against `current.md`.

## References
- `references/feedback-commands.md`
- `references/turn-rules.md`
- `references/priority-rules.md`
- `references/output-template.md`

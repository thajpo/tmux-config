---
name: lean-flow
description: "Chat-first planning workflow for Brainstormed -> Specd -> ready in current.md, with strict markdown approval evidence before execution. Inspired by OS best practices (vLLM, transformers, ray)."
---

# Lean Flow

## Goal
Keep planning explicit and minimal, then hand off to GitHub issue/PR execution without ambiguity.

## Design Philosophy: OS Best Practices

Take inspiration from top open-source projects (vLLM, transformers, ray). Issues should be:
- **Human-first**: Clear narrative over process jargon
- **Actionable**: Checkboxes that serve as implementation todos
- **Scoped**: Explicit problem statement before any solution details
- **Minimal**: Remove ceremony that doesn't help implementation

## Canonical Planning File
- Default: `current.md`.
- Mode is repo-level and fixed.
- Do not switch planning modes inside the same repo.

## Required Sections
- `Institutional Knowledge`
- `Beliefs`
- `Brainstormed`
- `Specd`

## Workflow
1. Brainstormed
- Capture ideas only; no implementation.
- Keep items lightweight; full spec lives in GitHub issue once promoted.

2. Specd (draft/in_progress)
- Convert selected ideas to concrete contracts.
- Promotion is move-not-copy: remove promoted item from `Brainstormed`.
- Use GitHub issue as the detailed spec, not `current.md`.

3. Ready
- Requires problem statement, changes checklist, and testing plan in GitHub issue.
- Markdown approval evidence in issue body (approver + date + scope).
- Execution starts by invoking `$pr-iterate` on the ready issue.

## GitHub Issue Format (OS Best Practices)

When creating issues, follow this format inspired by top OS projects:

```markdown
[Type] Brief descriptive title

## Problem
One-paragraph narrative: what we're solving and why now.

## Changes
- [ ] Specific actionable change 1
- [ ] Specific actionable change 2

## Type
- [ ] Bug fix | Feature | Breaking change | Refactor | Documentation

## Testing
- [ ] Unit tests (where)
- [ ] Integration tests (where)  
- [ ] Manual verification

## Notes
- Scope: ~N LOC
- Risk: low/medium/high
- Breaking: yes/no + impact
- Non-goals: what's out of scope
```

### Key Principles:
1. **Narrative First**: Start with the problem, not implementation
2. **Actionable Checkboxes**: Changes section IS the todo list
3. **Minimal Ceremony**: No "touch points", "diff shape", or process jargon
4. **Context at Bottom**: LOC, risk, non-goals don't obstruct reading
5. **Type Explicit**: Know immediately if this breaks things

## Tracking in `current.md` (post-issue, minimal)

**Only AFTER a spec has been approved and turned into a GitHub issue:**

Track in current.md:
- `title`
- `status` (`draft|in_progress` → `ready` → `issued`)
- `github_issue`: #N (added once issue is created)
- `summary`: 1-2 sentence description
- `blocking_decisions`: (if any)

Before issue creation: Use natural conversation + full spec draft in GitHub issue format.
After issue creation: Minimal tracking in current.md, full spec lives in GitHub issue.

## Authority Switch
- Pre-issue: planning contract in `current.md` is source of truth.
- Post-issue: GitHub issue body is implementation contract source of truth.
- Post-PR: PR thread/review feedback is iteration source of truth.
- If conflict exists, latest explicit user instruction in PR context wins.

## Routing
- Use `$spec-gate` for interrogation/readiness checks.
- User-facing execution handoff is `$pr-iterate`.
- `$pr-iterate` handles issue creation/compaction, worktree lifecycle, scope guard, and PR feedback loop via internal helpers.

## Guardrails
- Never implement from `Brainstormed`.
- Never mark `ready` without GitHub issue in OS format + approval evidence.
- Never implement without a linked issue.
- Never batch multiple ready items into one issue.
- Never touch files outside scope without explicit user approval.
- Never prune tracker lines before merge.

## References
- `references/issue-template.md` (OS best practices format)
- `references/tracker-lifecycle.md`

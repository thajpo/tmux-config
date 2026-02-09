---
name: partner-memory
description: "Persistent collaboration memory skill for cross-repo work. Use when the user asks to remember preferences, workflow rules, communication style, or recurring pain points and wants those applied in future sessions."
---

# Partner Memory

## Goal
Maintain durable, user-approved collaboration memory across repos and sessions.

## Canonical Memory File
- Use `~/.codex/partner-memory.md` as the persistent profile.
- If missing, create it from the schema in `references/profile-schema.md`.

## Startup Behavior
At the beginning of relevant tasks:
1. Read `~/.codex/partner-memory.md` if present.
2. Apply preferences to planning, scoping, and communication.
3. If repo-specific docs conflict with memory, follow repo docs and note the conflict.

## Update Rules (Consent-Based)
Only update memory when the user explicitly asks, e.g.:
- "remember this"
- "update my preferences"
- "add this to how we work"

Do not silently write persistent memory.

## What To Capture
- Workflow preferences (process shape, preferred artifacts, review style)
- Communication preferences (format, brevity, evidence style)
- Clarification/pushback expectations (e.g., mandatory Q&A before spec promotion)
- Accountability preference (user sets workflow direction; assistant enforces gates and prerequisites)
- Overlap handling preferences (merge/split rules across brainstorm/spec items)
- Repository beliefs (what should be true about the system)
- Anti-patterns/pain points to avoid
- Documentation artifact preferences (e.g., avoid markdown file clutter, temp-file lifecycle)
- Decision rules that generalize across repos

## What Not To Capture
- Secrets, credentials, keys, tokens
- One-off emotional statements without durable process value
- Repo-specific implementation details that belong in repo docs

## Memory Quality Rules
- Prefer fewer long-lived markdown files; encode temporary-note lifecycle explicitly when needed.
- Keep entries concise and testable.
- Prefer concrete "do/don't" statements.
- Mark uncertain items as hypotheses.
- Include a date and optional evidence link when available.
- Prune stale or contradicted entries when user requests cleanup.

## Suggested Commands
- `Use $partner-memory and remember this: ...`
- `Use $partner-memory and update my workflow preferences: ...`
- `Use $partner-memory and show what you remember about how I like to work`
- `Use $partner-memory and prune stale preferences`
- `Use $partner-memory and remember: require mandatory Q&A + pushback before promoting brainstorm to spec`

## Conflict Rule
If user instruction in current chat conflicts with stored memory:
- follow current explicit user instruction,
- then offer to update memory for future sessions.

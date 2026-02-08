---
name: escalation-gate
description: "Standardize blocker escalation for subagents with one explicit decision question, verbatim relay, and hard pause until user approval."
---

# Escalation Gate

## Goal
Make blockers explicit, actionable, and impossible to ignore.

## When To Use
Use whenever execution cannot continue without a decision.

## Required Escalation Packet
- blocker type
- stage/phase
- attempted command
- key failure output
- files changed so far
- exact decision needed
- one explicit question to user
- options/tradeoffs
- live wait-state evidence (session still active)

## Parent/Coordinator Requirements
- Relay escalation question verbatim.
- Hard-pause; do not auto-retry or broaden scope.
- Resume only after explicit user decision.

## Failure Rule
If a subagent asks a decision question and exits before answer, mark run as failed dispatch.

## References
- `references/escalation-packet-template.md`

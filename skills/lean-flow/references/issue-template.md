# GitHub Issue Template (OS Best Practices)

Inspired by top open-source projects (vLLM, transformers, ray). Issues should be human-first, actionable, and serve as the implementation todo list.

## Format

```markdown
[Type] Brief, descriptive title

## Problem
One-paragraph narrative explaining what we're solving and why now. 
Focus on the user impact, not implementation details.

## Changes
- [ ] Specific, actionable change 1
- [ ] Specific, actionable change 2
- [ ] Specific, actionable change 3

## Type
- [ ] Bug fix
- [ ] Feature
- [ ] Breaking change
- [ ] Refactor
- [ ] Documentation

## Testing
- [ ] Unit tests (where)
- [ ] Integration tests (where)
- [ ] Manual verification steps

## Notes
- **Scope**: ~N LOC (rough estimate)
- **Risk**: low/medium/high
- **Breaking**: yes/no + impact if yes
- **Non-goals**: What is explicitly out of scope
```

## Principles

1. **Narrative First**: Humans read stories, not bullet contracts. Start with the problem.
2. **Actionable Checkboxes**: The Changes section IS the todo list. Check off as you implement.
3. **Minimal Ceremony**: No "touch points", "diff shape", or other process jargon.
4. **Context at Bottom**: LOC, risk, non-goals go in Notes where they don't obstruct reading.
5. **Type is Explicit**: Know immediately if this breaks things.

## Anti-Patterns to Avoid

- ❌ Long lists of files to touch (use Changes instead)
- ❌ Static "Test Plan" bullets (use Testing checklist)
- ❌ Process-heavy fields before the narrative
- ❌ "Non-Goals" as a prominent section
- ❌ Guessing at implementation before problem is clear

## Example

See skill documentation for before/after comparison.

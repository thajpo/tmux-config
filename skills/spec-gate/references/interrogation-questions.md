# Interrogation Questions

Use only unresolved questions needed to complete the contract:
- What is the explicit user intent for this change?
- What behavior changes, and what must remain unchanged?
- Which files/modules/functions are in scope?
- What exact files/globs are allowed to be touched?
- What is estimated diff size (S/M/L) and why?
- What fail-first test proves the new behavior boundary?
- What regression tests protect adjacent surfaces?
- Which edge case is most likely to regress?
- What is explicitly out of scope?
- What rollback trigger should abort/undo the change?
- Which other Specd items overlap, and should they merge/split?
- Is manual approval evidence present in markdown with unresolved blockers set to none?

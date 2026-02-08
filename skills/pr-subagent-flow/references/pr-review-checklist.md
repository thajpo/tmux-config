# PR Review Checklist (Findings-First)

Order findings by severity.

1. Correctness regressions
- behavior mismatch vs spec
- edge-case breakage

2. Contract risk
- API/schema/event/backward-compat drift (if applicable)

3. Test quality
- missing fail-first coverage
- missing regression coverage
- flaky/weak assertions

4. Scope control
- unrelated refactors
- forbidden file touch

5. Evidence quality
- fail-first and pass outputs present and credible
- runner/environment contract followed

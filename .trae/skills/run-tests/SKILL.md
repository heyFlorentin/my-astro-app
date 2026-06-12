---
name: run-tests
description: "Execute the full test suite (unit + e2e). Use when user wants to verify changes, before deployment, or during Maintenance Month."
---

# Run Tests

## When to Use
- Before any production deployment
- After any significant refactoring
- During Maintenance Month

## Instructions
1. Run unit tests: `npx vitest run`
2. If unit tests pass, run e2e: `npx playwright test`
3. Present results:
   - Total tests, passed, failed, skipped
   - Duration
   - Any flaky tests (flag if test sometimes passes/sometimes fails)
4. If failures: identify root cause and suggest fixes.
5. On success: confirm "All tests passing. Build can proceed."

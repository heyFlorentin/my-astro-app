---
description: "Testing standards: Vitest for unit tests, Playwright for e2e. Applies to all test files."
globs: "tests/**/*.{test,spec}.{ts,tsx}"
alwaysApply: false
---

# Testing Standards

## Unit Tests (Vitest)
- Location: `tests/unit/` mirroring `src/` structure
- Naming: `<source-file>.test.ts` (e.g., `src/lib/utils.ts` → `tests/unit/lib/utils.test.ts`)
- MUST use `describe`/`it` blocks with descriptive names
- MUST mock external dependencies (fetch, KV, env)
- MUST NOT test Astro components directly in unit tests (use e2e)

## E2E Tests (Playwright)
- Location: `tests/integration/`
- MUST test: homepage loads (200), SSR routes render correctly, API endpoints return expected JSON, static pages return 200
- MUST NOT test: third-party services (mock them), Cloudflare-specific runtime features in local Playwright

## Coverage
- Aim for: >80% on `src/lib/`, >60% on API endpoints
- Run: `npm run test` (unit) + `npm run test:e2e` (integration) before production deploys

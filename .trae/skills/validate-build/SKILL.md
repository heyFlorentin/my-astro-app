---
name: validate-build
description: "Validate that the project builds successfully and meets all constraints. Use before deployment or when user wants to verify build integrity."
---

# Validate Build

## When to Use
- Before any deployment
- After dependency changes
- When user wants to verify build integrity

## Instructions
1. Run: `npx wrangler types && npx astro check && npx astro build`
2. Verify: bundle size under 900 KB
3. Verify: no TypeScript errors
4. Verify: no build warnings
5. Report: build success/failure, bundle size, any warnings
6. On failure: identify the error, provide fix.

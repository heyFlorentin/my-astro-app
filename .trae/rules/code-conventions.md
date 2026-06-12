---
description: "Mandatory code conventions for TypeScript, Astro, imports, error handling, and naming. Applies to all source files."
globs: "src/**/*.{ts,tsx,astro}"
alwaysApply: true
---

# Code Conventions

## Naming
- Files: kebab-case for pages/routes (`user-profile.astro`), PascalCase for components (`UserProfile.astro`), camelCase for utilities (`formatDate.ts`)
- Variables/functions: camelCase
- Types/interfaces: PascalCase, prefixed with `I` for interfaces only when ambiguous vs. classes
- Constants: UPPER_SNAKE_CASE at module level only

## Imports
- MUST NOT use `process.env` directly. Access environment through `Astro.locals.runtime.env` in `.astro` files and through function parameters in utilities.
- MUST use `import type { ... }` for type-only imports.
- MUST order imports: (1) Node built-ins, (2) external packages, (3) internal aliases, (4) relative imports.

## Error Handling
- MUST NOT swallow errors silently. All catch blocks MUST log or rethrow.
- API routes MUST return proper HTTP status codes (200, 400, 404, 500) with JSON error bodies: `{ error: string, code: number }`
- MUST use `try/catch` at the boundary (API handler, page `getStaticPaths`, etc.), not deep in utilities.

## Typing
- MUST NOT use `any`. Use `unknown` and narrow with type guards.
- MUST define return types for all exported functions.
- MUST extend `App.Locals` in `src/env.d.ts` — never use `as` casts to access locals.

## Astro-Specific
- MUST declare `export const prerender = true` or `false` explicitly on every page.
- MUST NOT use `Astro.clientAddress` in prerendered pages.
- MUST use `Astro.locals.runtime.env` for environment variables — never `import.meta.env` for secrets.

---
description: "Cloudflare Workers runtime constraints: limits, compat flags, wrangler config rules. Applies when writing SSR logic, API endpoints, or wrangler config."
globs: "src/pages/**/*.{ts,astro},src/lib/**/*.ts,wrangler.jsonc"
alwaysApply: false
---

# Cloudflare Workers Constraints

## Runtime Limits (Free Tier)
- CPU time: 10ms per request (default). Optimize SSR pages to complete under 5ms where possible.
- Memory: 128 MB per isolate. Avoid large in-memory caches.
- Bundle size: 1 MB compressed. Check with `npm run build` postbuild script.
- Subrequests: 50 per request. Count fetch calls, KV reads, DB queries.

## Required Compatibility Flags
- `"nodejs_compat"` — REQUIRED for `Buffer`, `crypto`, `process.env` polyfills
- `"global_fetch_strictly_public"` — RECOMMENDED to prevent internal fetch leaks

## Wrangler Config Rules
- MUST use `wrangler.jsonc`, NOT `wrangler.toml`
- MUST include `$schema` reference for IDE autocompletion
- MUST include `assets.binding` set to `"ASSETS"` for SSR
- MUST NOT commit `.dev.vars` (git-ignored)
- MUST use `npx wrangler secret put` for production secrets, never hardcode

## Image Service
- MUST use `imageService: 'cloudflare'` in astro.config.mjs for SSR image transforms
- MUST NOT use `imageService: 'compile'` — it silently produces 404s for SSR images

## public/.assetsignore
- MUST exist and contain exactly: `_worker.js`, `_routes.json`

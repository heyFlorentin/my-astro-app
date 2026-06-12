# AGENTS.md — Astro SSR + Cloudflare Workers Project

## Overview
This is an Astro SSR application deployed on Cloudflare Workers. It follows a "1 active month, 11 dormant months" maintenance cadence. The system is designed for fire-and-forget reliability with automated health monitoring.

## Stack
- Astro 6 (SSR mode) with `@astrojs/cloudflare` adapter
- Cloudflare Workers (via Wrangler CLI v4)
- GitHub Actions for CI/CD
- TRAE IDE for AI-assisted development

## Key Rules
- All pages MUST declare `export const prerender` explicitly
- MUST use `Astro.locals.runtime.env` for environment variables, never `process.env`
- `imageService: 'cloudflare'` is required for SSR image transforms
- `public/.assetsignore` MUST contain `_worker.js` and `_routes.json`
- Worker bundle MUST stay under 900 KB
- See `.trae/rules/` for detailed conventions

## Development Commands
- `npm run dev` — Start local dev server
- `npm run build` — Type-check + build
- `npm run test` — Run Vitest unit tests
- `npm run test:e2e` — Run Playwright E2E tests
- `npm run deploy:staging` — Deploy to staging
- `npm run deploy:production` — Deploy to production (requires --force)

## Project Structure
```
src/        — Astro source (pages, components, layouts, lib)
workers/    — Custom Worker entry (Durable Objects, Queues, Cron)
tests/      — Vitest (unit) and Playwright (e2e) tests
scripts/    — Build, deploy, audit, health scripts
public/     — Static assets (.assetsignore REQUIRED)
.trae/      — TRAE IDE configuration (rules, agents, skills, commands)
.github/    — GitHub Actions CI/CD workflows
```

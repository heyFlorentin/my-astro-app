# 🚀 Astro SSR on Cloudflare Workers

[![CI](https://github.com/heyFlorentin/my-astro-app/actions/workflows/ci.yml/badge.svg)](https://github.com/heyFlorentin/my-astro-app/actions/workflows/ci.yml)
[![Deploy Staging](https://github.com/heyFlorentin/my-astro-app/actions/workflows/deploy-staging.yml/badge.svg)](https://github.com/heyFlorentin/my-astro-app/actions/workflows/deploy-staging.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Production-grade starter template for solo developers building [Astro 6](https://astro.build) SSR applications deployed to Cloudflare Workers. Designed for the **"1 active month, 11 dormant months"** maintenance cadence — fire-and-forget reliability with fully automated CI/CD, dependency auditing, and annual health checks.

---

## ✨ Why This Stack

| Concern | Solution |
|---|---|
| **Framework** | Astro 6 — ship zero JS by default, opt into SSR per page |
| **Runtime** | Cloudflare Workers — global edge, free tier, no cold starts |
| **CI/CD** | GitHub Actions — parallel jobs, <5 min pipeline, auto-deploy |
| **Testing** | Vitest (unit) + Playwright (e2e) — fast, modern, reliable |
| **AI-Assisted Dev** | TRAE IDE rules, agents, skills — scaffold, audit, deploy from chat |
| **Maintenance** | Annual `maintenance:month` workflow — audit, patch, report |

---

## 🏗 Project Structure

```
.
├── .github/workflows/          # CI/CD pipelines
│   ├── ci.yml                  # Lint → Type-check → Unit test → E2E → Build
│   ├── deploy-staging.yml      # Auto-deploy on push to main
│   ├── deploy-production.yml   # Deploy on release publish
│   └── maintenance-month.yml   # Annual health audit (cron: Jan 1)
│
├── .trae/                      # TRAE IDE configuration
│   ├── rules/                  # Project conventions (always-applied)
│   ├── agents/                 # Architect · Scaffolder · Maintainer
│   ├── skills/                 # audit-deps · run-tests · validate-build
│   └── commands/               # deploy:staging · deploy:production · etc.
│
├── src/
│   ├── pages/                  # Astro pages (SSR + static prerender)
│   │   ├── index.astro         # SSR: dynamic homepage
│   │   ├── about.astro         # Static: prerendered at build
│   │   ├── dashboard.astro     # SSR: always server-rendered
│   │   ├── api/health.ts       # /api/health → { status, version }
│   │   └── [slug].astro        # Dynamic route
│   ├── components/             # Header, Footer (Astro components)
│   ├── layouts/BaseLayout.astro
│   ├── lib/                    # utils.ts, constants.ts
│   ├── content/config.ts       # Content collections schema
│   └── env.d.ts                # Cloudflare Runtime type declarations
│
├── workers/entry.ts            # Custom Worker entry (Durable Objects, Queues)
├── tests/
│   ├── unit/                   # Vitest unit tests
│   └── integration/            # Playwright e2e tests
├── scripts/                    # Deploy, audit, health, maintenance scripts
├── public/                     # Static assets + .assetsignore (CRITICAL)
│
├── astro.config.mjs            # SSR + @astrojs/cloudflare adapter
├── wrangler.jsonc              # Worker config (staging + production envs)
├── vitest.config.ts            # Vitest with path aliases
├── playwright.config.ts        # Chromium, local wrangler dev server
└── AGENTS.md                   # AI coding agent instructions
```

---

## 🚦 Quick Start

### Prerequisites

- **Node.js 22+** (required by Astro 6)
- **npm 10+**
- **Cloudflare account** ([free tier](https://workers.cloudflare.com))
- **GitHub account** (for CI/CD)

### 1. Use This Template

Click **"Use this template"** on GitHub, or:

```bash
git clone https://github.com/heyFlorentin/my-astro-app.git my-astro-app
cd my-astro-app
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Configure Cloudflare

```bash
# Interactive login (local development only)
npx wrangler login

# Generate TypeScript types for your bindings
npx wrangler types
```

### 4. Start Developing

```bash
npm run dev
```

Opens `http://localhost:4321`. SSR routes render on-demand. Static pages pre-render at build. Hot module reload enabled.

### 5. Run Tests

```bash
npm run test        # Vitest unit tests
npm run test:e2e    # Playwright end-to-end tests
```

### 6. Deploy

```bash
npm run deploy:staging          # Deploy to staging
npm run deploy:production -- --force  # Deploy to production
```

---

## 📦 Available Scripts

| Script | Description |
|---|---|
| `npm run dev` | Local dev server with Wrangler runtime proxy |
| `npm run build` | Type-check + Wrangler types + Astro build + bundle size check |
| `npm run test` | Run Vitest unit tests |
| `npm run test:watch` | Vitest in watch mode |
| `npm run test:e2e` | Playwright end-to-end tests |
| `npm run lint` | Astro check + ESLint |
| `npm run format` | Prettier format all source files |
| `npm run deploy:staging` | Build and deploy to staging environment |
| `npm run deploy:production` | Build, test, and deploy to production (requires `--force`) |
| `npm run audit:deps` | Full dependency audit (CVEs, outdated, deprecation) |
| `npm run health:check` | Generate health report for the codebase |
| `npm run maintenance:month` | Full annual audit: deps → tests → build → config → report |

---

## ⚙️ CI/CD Pipeline

### CI (`ci.yml`) — Runs on every push and PR

```
┌──────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐
│  Lint &  │  │  Unit     │  │  E2E      │  │  Build &  │
│  Type-   │  │  Tests    │  │  Tests    │  │  Bundle   │
│  Check   │  │  (Vitest) │  │(Playwright│  │  Check    │
│ ≤3 min   │  │ ≤3 min    │  │ ≤5 min)   │  │ ≤4 min    │
└──────────┘  └───────────┘  └───────────┘  └───────────┘
     ↑              ↑              ↑              ↑
     └──────────────┴──── All run in parallel ────┘
```

**Pipeline target: <5 minutes for standard changes.**

### Deploy Staging (`deploy-staging.yml`)

- Triggers automatically on push to `main`
- Manual trigger via `workflow_dispatch`
- Builds and deploys to `my-astro-app-staging` Workers environment

### Deploy Production (`deploy-production.yml`)

- Triggers on GitHub Release publish (`release` type `published`)
- Manual trigger via `workflow_dispatch`
- Runs full test suite **before** deployment
- Enforces bundle size limit (900 KB) — aborts if exceeded
- Deploys to `my-astro-app` Workers environment

---

## 🔐 Required GitHub Secrets

Add these in **Settings → Secrets and variables → Actions**:

| Secret | Description |
|---|---|
| `CLOUDFLARE_API_TOKEN` | API token with **Edit Cloudflare Workers** permission |
| `CLOUDFLARE_ACCOUNT_ID` | Your Cloudflare account ID (Dashboard → Workers & Pages) |

Create the API token at: **Cloudflare Dashboard → Manage Account → API Tokens → Create Token → Edit Cloudflare Workers template**.

---

## 🤖 TRAE IDE Integration

This repository includes a complete TRAE IDE configuration (`.trae/`) for AI-assisted development. Open the project in TRAE IDE and all rules, agents, skills, and commands load automatically.

### Custom Agents

| Agent | Triggers | Behavior |
|---|---|---|
| **Architect** | `@architect` — planning, refactoring, architecture review | Produces file-level implementation plans with Cloudflare constraint analysis |
| **Scaffolder** | `@scaffolder` — creating pages, components, API endpoints | Generates code following all project conventions + companion tests |
| **Maintainer** | `@maintainer` — dependency updates, security, health checks | Audits deps, categorizes updates (safe/minor/major), generates health reports |

### Skills

| Skill | Use Case |
|---|---|
| **audit-deps** | Run comprehensive dependency audit (CVEs, outdated, deprecation) |
| **run-tests** | Execute full test suite (unit + e2e) |
| **validate-build** | Build and verify bundle size constraints |

### Commands

| Command | Action |
|---|---|
| `/deploy-staging` | Build and deploy to staging |
| `/deploy-production` | Build, test, and deploy to production |
| `/update-deps` | Audit and apply safe patch updates |
| `/health-check` | Generate comprehensive health score report |

See `AGENTS.md` for complete AI coding agent instructions.

---

## 🩺 Maintenance Philosophy

This stack is designed for solo developers who want to build fast and then **step away for 11 months** with confidence.

### The Yearly Cycle

```
        Jan 1: Automated health audit runs (GitHub Actions cron)
          ↓
        GitHub Issue auto-created with findings
          ↓
        (Optional) Developer reviews during active month
          ↓
        Apply safe updates, patch CVEs, bump compatibility_date
          ↓
        Deploy → Verify → Done for another year
```

### What runs automatically while you're away

- **Dependabot**: Weekly npm checks, auto-PRs for patch updates
- **CI/CD**: Validates every push, deploys staging on merge to `main`
- **Annual cron** (Jan 1): Full dependency audit, bundle analysis, test suite, health report, auto-creates GitHub Issue
- **Cloudflare Workers Observability**: Captures runtime errors passively

### What needs manual attention once a year

1. Review the auto-generated GitHub Issue (health report)
2. Apply safe + minor dependency updates
3. Evaluate major updates (read changelogs, check migration guides)
4. Update `compatibility_date` in `wrangler.jsonc` to current date
5. Update GitHub Actions workflow versions
6. Review TRAE IDE rules/agents for drift
7. Deploy to staging → verify → deploy to production

---

## 🛡 Critical Constraints

### MUST DO

- **Every page** MUST declare `export const prerender = true` or `false` explicitly
- **`public/.assetsignore`** MUST contain `_worker.js` and `_routes.json` (silent SSR breakage otherwise)
- **Environment variables** MUST be accessed via `Astro.locals.runtime.env`, never `process.env`
- **Worker bundle** MUST stay under 900 KB (100 KB headroom under free tier 1 MB limit)
- **Production deploys** MUST run the full test suite before deployment

### MUST NOT DO

- MUST NOT use `imageService: 'compile'` — silently produces 404s for SSR image transforms
- MUST NOT use `wrangler.toml` — use `wrangler.jsonc` (Cloudflare's recommended format)
- MUST NOT commit `.dev.vars` or `.env` files
- MUST NOT hardcode secrets in source — use `npx wrangler secret put`
- MUST NOT introduce dependencies that add >50 KB to the Worker bundle without explicit justification
- MUST NOT use `any` type — use `unknown` and narrow with type guards
- MUST NOT swallow errors silently — all catch blocks must log or rethrow

---

## 📊 Bundle Budget

| Tier | Limit | Our Guardrail |
|---|---|---|
| Worker free tier | 1 MB compressed | **900 KB** (100 KB headroom) |
| Single file | 25 MB | Checked at build |
| Total files (free) | 20,000 | Monitored |

Bundle size is enforced at build time (`scripts/check-bundle-size.sh`). CI fails if exceeded.

---

## 🔗 Useful Links

- [Astro Docs — Cloudflare Adapter](https://docs.astro.build/en/guides/integrations-guide/cloudflare/)
- [Cloudflare Workers Docs](https://developers.cloudflare.com/workers/)
- [Wrangler CLI Docs](https://developers.cloudflare.com/workers/wrangler/)
- [wrangler-action (GitHub Action)](https://github.com/cloudflare/wrangler-action)
- [Cloudflare Workers Changelog](https://developers.cloudflare.com/workers/platform/changelog/)

---

## 📝 License

MIT — see [LICENSE](LICENSE) for details.

---

<p align="center">
  <sub>Built with 💙 by <a href="https://wemake.cx">WeMake</a>. Designed for solo developers who ship and sleep well.</sub>
</p>

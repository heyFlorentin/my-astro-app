---
name: deploy-production
description: "Deploy the application to production environment on Cloudflare Workers. Requires explicit --force confirmation."
---

Execute: `bash scripts/deploy-production.sh --force`
Verify: production deployment at `https://my-astro-app.<your-subdomain>.workers.dev`
Report: deployment status, URL, version deployed, and any warnings.

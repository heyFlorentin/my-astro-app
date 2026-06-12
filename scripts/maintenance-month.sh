#!/usr/bin/env bash
set -euo pipefail

echo "============================================"
echo "  MAINTENANCE MONTH — Full System Audit"
echo "============================================"
echo ""

# Step 1: Dependency audit
echo "--- Step 1/7: Dependency Audit ---"
bash scripts/audit-deps.sh
echo ""

# Step 2: Type-check
echo "--- Step 2/7: Type-Check ---"
npx wrangler types
npx astro check
echo "Type-check passed."
echo ""

# Step 3: Unit tests
echo "--- Step 3/7: Unit Tests ---"
npx vitest run --reporter=verbose
echo ""

# Step 4: E2E tests
echo "--- Step 4/7: E2E Tests ---"
npx playwright test
echo ""

# Step 5: Build + bundle check
echo "--- Step 5/7: Build & Bundle Size ---"
npx astro build
bash scripts/check-bundle-size.sh
echo ""

# Step 6: Config freshness
echo "--- Step 6/7: Configuration Freshness ---"
echo "Compatibility date:"
grep "compatibility_date" wrangler.jsonc
echo ""
echo "CI/CD action versions:"
grep -rn "uses:" .github/workflows/ 2>/dev/null | sort | uniq -c || echo "No workflows found."
echo ""

# Step 7: Health report
echo "--- Step 7/7: Health Report ---"
bash scripts/health-report.sh
echo ""

echo "============================================"
echo "  MAINTENANCE MONTH COMPLETE"
echo "============================================"
echo "Review .reports/ for detailed audit outputs."
echo "Next steps:"
echo "  1. Review dependency audit in .reports/"
echo "  2. Apply safe updates: npx npm-check-updates -t patch -u && npm install"
echo "  3. If compatible, update compatibility_date in wrangler.jsonc"
echo "  4. Deploy to staging to verify: npm run deploy:staging"
echo "  5. Deploy to production: npm run deploy:production -- --force"

#!/usr/bin/env bash
set -euo pipefail

echo "=== Deploying to PRODUCTION ==="

if [ "${1:-}" != "--force" ]; then
  echo "ERROR: Production deployment requires --force flag."
  echo "Usage: bash scripts/deploy-production.sh --force"
  exit 1
fi

echo "Step 1/5: Generate Wrangler types..."
npx wrangler types

echo "Step 2/5: Type-check..."
npx astro check

echo "Step 3/5: Run unit tests..."
npx vitest run

echo "Step 4/5: Build..."
npx astro build

echo "Step 5/5: Deploy to production..."
npx wrangler deploy --env production

echo "=== Production deployment complete ==="

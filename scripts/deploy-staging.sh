#!/usr/bin/env bash
set -euo pipefail

echo "=== Deploying to STAGING ==="
echo "Step 1/4: Generate Wrangler types..."
npx wrangler types

echo "Step 2/4: Type-check..."
npx astro check

echo "Step 3/4: Build..."
npx astro build

echo "Step 4/4: Deploy to staging..."
npx wrangler deploy --env staging

echo "=== Staging deployment complete ==="

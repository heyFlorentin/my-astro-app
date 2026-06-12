#!/usr/bin/env bash
set -euo pipefail

echo "=== Validating Build ==="
echo "Step 1/4: Generate Wrangler types..."
npx wrangler types

echo "Step 2/4: Type-check..."
npx astro check

echo "Step 3/4: Build..."
npx astro build

echo "Step 4/4: Check bundle size..."
bash scripts/check-bundle-size.sh

echo "Build validation complete."

#!/usr/bin/env bash
set -euo pipefail

echo "=== Running Unit Tests (Vitest) ==="
npx vitest run --reporter=verbose
UNIT_EXIT=$?

echo ""
echo "=== Running E2E Tests (Playwright) ==="
npx playwright test
E2E_EXIT=$?

echo ""
if [ "$UNIT_EXIT" -eq 0 ] && [ "$E2E_EXIT" -eq 0 ]; then
  echo "All tests passing."
  exit 0
else
  echo "Some tests failed. Review output above."
  exit 1
fi

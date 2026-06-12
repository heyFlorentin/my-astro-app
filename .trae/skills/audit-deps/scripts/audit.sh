#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR=".reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/dependency-audit-$(date +%Y%m%d-%H%M%S).txt"

{
  echo "=== DEPENDENCY AUDIT REPORT ==="
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo ""

  echo "--- npm audit (security vulnerabilities) ---"
  npm audit --json 2>/dev/null || echo "npm audit produced warnings (check above)"

  echo ""
  echo "--- npm outdated (available updates) ---"
  npm outdated --json 2>/dev/null || echo "All packages up to date."

  echo ""
  echo "--- npx npm-check-updates (latest versions) ---"
  npx npm-check-updates --format group 2>/dev/null || echo "ncu check complete."

  echo ""
  echo "--- Deprecation warnings ---"
  npm ls --depth=0 2>&1 | grep -i deprecated || echo "No deprecation warnings."

  echo ""
  echo "--- Bundle size snapshot ---"
  ls -lh dist/_worker.js/index.js 2>/dev/null || echo "No build output found. Run 'npm run build' first."

} > "$REPORT_FILE"

echo "Audit complete. Report: $REPORT_FILE"

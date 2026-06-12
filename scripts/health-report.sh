#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR=".reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/health-report-$(date +%Y%m%d-%H%M%S).md"

# Attempt to determine values with graceful fallbacks
COMPAT_DATE=$(grep -oP '"compatibility_date"\s*:\s*"\K[^"]+' wrangler.jsonc 2>/dev/null || echo "unknown")
COMPAT_DATE_EPOCH=$(date -d "$COMPAT_DATE" +%s 2>/dev/null || echo 0)
NOW_EPOCH=$(date +%s)
COMPAT_AGE_DAYS=$(( (NOW_EPOCH - COMPAT_DATE_EPOCH) / 86400 ))

BUNDLE_SIZE_KB="N/A"
if [ -f "dist/_worker.js/index.js" ]; then
  BUNDLE_SIZE=$(stat -c%s "dist/_worker.js/index.js" 2>/dev/null || stat -f%z "dist/_worker.js/index.js")
  BUNDLE_SIZE_KB=$(( BUNDLE_SIZE / 1024 ))
fi

{
  echo "# Health Report — $(date +%Y-%m-%d)"
  echo ""
  echo "## Overall Score: TBD (review components below)"
  echo ""
  echo "### Dependencies"
  echo "- Run \`npm run audit:deps\` for full details"
  echo ""
  echo "### Worker Bundle"
  echo "- Size: ${BUNDLE_SIZE_KB} KB / 900 KB limit"
  echo ""
  echo "### Configuration"
  echo "- compatibility_date: ${COMPAT_DATE} (age: ${COMPAT_AGE_DAYS} days)"
  echo "- Astro version: $(npx astro --version 2>/dev/null || echo 'unknown')"
  echo ""
  echo "### Action Items"
  echo "- [ ] Review dependency audit report"
  echo "- [ ] Check compatibility_date freshness (current age: ${COMPAT_AGE_DAYS} days)"
  echo "- [ ] Run full test suite"
  echo "- [ ] Verify staging deployment"
} > "$REPORT_FILE"

echo "Health report generated: $REPORT_FILE"

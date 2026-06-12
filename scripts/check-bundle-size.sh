#!/usr/bin/env bash
set -euo pipefail

MAX_SIZE_KB=900
WORKER_FILE="dist/_worker.js/index.js"

if [ ! -f "$WORKER_FILE" ]; then
  echo "WARNING: Worker file not found at $WORKER_FILE — skipping size check."
  exit 0
fi

SIZE=$(stat -c%s "$WORKER_FILE" 2>/dev/null || stat -f%z "$WORKER_FILE")
SIZE_KB=$(( SIZE / 1024 ))

echo "Worker bundle size: ${SIZE_KB} KB (limit: ${MAX_SIZE_KB} KB)"

if [ "$SIZE_KB" -gt "$MAX_SIZE_KB" ]; then
  echo "ERROR: Worker bundle exceeds ${MAX_SIZE_KB} KB limit. Reduce dependencies or split logic."
  exit 1
fi

echo "OK: Worker bundle within limits."

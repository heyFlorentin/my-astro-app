---
name: health-check
description: "Generate a comprehensive health score report for the entire codebase."
---

1. Run: `bash scripts/health-report.sh`
2. Additionally check: CI/CD last run status, Worker metrics (if observability enabled), TRAE IDE rule/agent freshness.
3. Output: `HEALTH_REPORT.md` with overall score and prioritized action items.
4. If score < 70: flag as "Requires immediate maintenance attention."

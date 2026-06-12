---
name: audit-deps
description: "Run comprehensive dependency audit. Use when checking for outdated packages, security vulnerabilities, or deprecation warnings. Use proactively when user mentions dependencies, updates, or security."
---

# Audit Dependencies

## When to Use
- User mentions dependency updates, security, or audit
- Before any deployment
- During Maintenance Month

## Instructions
1. Run: `bash .trae/skills/audit-deps/scripts/audit.sh`
2. Parse the report output.
3. Present findings in three tiers:
   - **Critical/High CVEs**: List each with CVE ID and fix version. MUST fix before next deploy.
   - **Deprecation warnings**: List deprecated packages with recommended replacements.
   - **Available updates**: Categorized as patch (safe), minor (test), major (evaluate).
4. Provide specific `npm install` commands for recommended fixes.
5. If no issues: confirm "All dependencies up to date and secure."

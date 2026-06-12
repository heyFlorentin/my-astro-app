---
name: update-deps
description: "Run dependency audit and apply safe updates. Reports breaking changes for review."
---

1. Run: `bash scripts/audit-deps.sh`
2. Apply safe (patch) updates: `npx npm-check-updates -t patch -u && npm install`
3. For minor/major: present changelog summaries and ask for confirmation.
4. After updates: run full test suite + build validation.
5. Report: which packages were updated, from which version to which version.

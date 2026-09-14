---
key: CFG-04
category: Project configuration
title: config-consistency
description: Keep compiler settings consistent across the repo
impact: MEDIUM
impactDescription: Reduces hidden differences in type-checking behavior across packages.
---

## CFG-04: Keep compiler settings consistent across the repo

**When to apply:** A monorepo or multi-package repo has more than one `tsconfig.json` that could drift from a shared baseline.

Use a shared compiler configuration baseline.

```json
{
  "extends": "../../tsconfig.base.json"
}
```

**Why:** Inconsistent compiler settings create hidden differences in how code is checked. A package with weaker settings becomes the weak spot.

### Mechanical enforcement

Add a script — run in CI — that walks every `tsconfig.json` in the repo and asserts each one `extends` the shared base with no unexplained overrides. Nothing off the shelf does this; it's a short custom check.

**Covers:** every package whose `tsconfig.json` doesn't `extends` the shared base, or that silently overrides a key from it.

**Still manual:** judging whether a flagged override is actually justified — the script can only detect that a package diverges from the base, not whether that divergence is warranted.

### Common mistakes

| Mistake                                     | Fix                          |
| ------------------------------------------- | ---------------------------- |
| Different `strict` settings across packages | Use shared base config       |
| Copy-pasted tsconfig in each package        | Use `extends` to share base  |
| Local overrides without explanation         | Document why overrides exist |

---
key: config-consistency
category: Project configuration
title: Keep compiler settings consistent across the repo
impact: MEDIUM
impactDescription: Reduces hidden differences in type-checking behavior across packages.
---

## Keep compiler settings consistent across the repo

Use a shared compiler configuration baseline.

```json
{
  "extends": "../../tsconfig.base.json"
}
```

**Why:** Inconsistent compiler settings create hidden differences in how code is checked. A package with weaker settings becomes the weak spot.

### Common mistakes

| Mistake                                     | Fix                          |
| ------------------------------------------- | ---------------------------- |
| Different `strict` settings across packages | Use shared base config       |
| Copy-pasted tsconfig in each package        | Use `extends` to share base  |
| Local overrides without explanation         | Document why overrides exist |

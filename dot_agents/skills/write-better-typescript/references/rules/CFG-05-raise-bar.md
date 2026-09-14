---
key: CFG-05
category: Project configuration
title: config-raise-bar
description: Tighten compiler options over time, not loosen them
impact: LOW-MEDIUM
impactDescription: Prevents gradual erosion of type safety.
---

## CFG-05: Tighten compiler options over time, not loosen them

**When to apply:** Someone proposes disabling or loosening a compiler check to unblock a build or CI run.

Raise the compiler safety bar over time. When stricter checks reveal problems, fix them or isolate exceptions locally.

**Incorrect:**

```json
{
  "compilerOptions": {
    "strict": false
  }
}
```

**Why:** Lowering the baseline makes the whole project less trustworthy and makes future adoption harder.

### Mechanical enforcement

Enforce the floor with `CFG-01` and `CFG-02`: a CI check that reads `tsconfig.json` and fails if `strict` or the extra flags are ever `false` catches a regression immediately. For the broader trend, extend that check to fail on any diff that flips a protected flag from `true` to `false`.

**Covers:** regressions in the specific flags already tracked by the check.

**Still manual:** remembering to add a newly-adopted stricter flag to the protected list — the check can't protect a flag it doesn't know about yet.

### Common mistakes

| Mistake                              | Fix                             |
| ------------------------------------ | ------------------------------- |
| Disabling checks globally            | Fix lookups incrementally       |
| Setting `"strict": false` to pass CI | Enable strict and fix errors    |
| Weakening checks instead of fixing   | Fix violations, don't lower bar |

---
key: config-raise-bar
category: Project configuration
title: Tighten compiler options over time, not loosen them
impact: LOW-MEDIUM
impactDescription: Prevents gradual erosion of type safety.
---

## Tighten compiler options over time, not loosen them

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

### Common mistakes

| Mistake                              | Fix                             |
| ------------------------------------ | ------------------------------- |
| Disabling checks globally            | Fix lookups incrementally       |
| Setting `"strict": false` to pass CI | Enable strict and fix errors    |
| Weakening checks instead of fixing   | Fix violations, don't lower bar |

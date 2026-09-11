---
key: assert-use-const
category: Unsafe escape hatches
title: Use as const to preserve intended literal information
impact: LOW-MEDIUM
impactDescription: Prevents useful literal values from widening away.
---

## Use `as const` to preserve intended literal information

Use `as const` for fixed literal data that should remain narrow.

**Why:** Without it, TypeScript often widens literal values too early.

**Incorrect:**

```ts
const roles = ['admin', 'editor', 'viewer'];
// roles: string[]
```

**Correct:**

```ts
const roles = ['admin', 'editor', 'viewer'] as const;
// roles: readonly ["admin", "editor", "viewer"]
```

### Common mistakes

| Mistake                              | Fix                                    |
| ------------------------------------ | -------------------------------------- |
| Missing `as const` on literal arrays | Add `as const` to preserve types       |
| Mutable config that should be fixed  | Use `as const` on fixed config         |
| Enum-like values without narrowing   | Use `as const` with `typeof X[number]` |

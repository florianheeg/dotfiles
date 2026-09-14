---
key: ASR-03
category: Unsafe escape hatches
title: assert-use-const
description: Use as const to preserve intended literal information
impact: LOW-MEDIUM
impactDescription: Prevents useful literal values from widening away.
---

## ASR-03: Use `as const` to preserve intended literal information

**When to apply:** Declaring a literal array, object, or value whose exact literal shape — not just its widened type — needs to be preserved.

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

### Mechanical enforcement

Add `@typescript-eslint/prefer-as-const` to your lint rules — it catches the narrow case of a literal type annotation that should be `as const`.

**Covers:** a redundant literal type annotation that should be `as const` instead (e.g. `let x: 'foo' = 'foo'`).

**Still manual:** a literal array or object with no annotation at all that gets silently widened (`const roles = [...]` inferred as `string[]`) — the common case in this rule's own example isn't caught by this lint rule.

### Common mistakes

| Mistake                              | Fix                                    |
| ------------------------------------ | -------------------------------------- |
| Missing `as const` on literal arrays | Add `as const` to preserve types       |
| Mutable config that should be fixed  | Use `as const` on fixed config         |
| Enum-like values without narrowing   | Use `as const` with `typeof X[number]` |

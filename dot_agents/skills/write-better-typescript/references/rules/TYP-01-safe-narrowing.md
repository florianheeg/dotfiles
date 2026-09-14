---
key: TYP-01
category: Type relationships and reuse
title: type-safe-narrowing
description: Narrow values before using them as more specific types
impact: MEDIUM-HIGH
impactDescription: Prevents unsafe property access and makes unions safe to work with.
---

## TYP-01: Narrow values before using them as more specific types

**When to apply:** A value's static type is a union or `unknown` and you're about to access a member or call a method on it.

Do not access properties or call methods that require a narrower type until you have narrowed the value.

**Why:** A large share of everyday TypeScript safety comes from correct narrowing of unions and `unknown` values.

**Incorrect:**

```ts
function printId(id: string | number) {
  return id.toUpperCase();
}
```

**Correct:**

```ts
function printId(id: string | number) {
  if (typeof id === 'string') {
    return id.toUpperCase();
  }
  return id.toString();
}
```

### Mechanical enforcement

Nothing to configure beyond `CFG-01`: once `strict` is on, accessing a member not shared by every union arm — or any property on `unknown` — is already a compiler error. Add `@typescript-eslint/no-unsafe-member-access` to also cover the residual `any`-typed cases.

**Covers the entire rule** — nothing left to check manually.

### Common mistakes

| Mistake                                | Fix                                       |
| -------------------------------------- | ----------------------------------------- |
| Accessing property without narrowing   | Use `typeof`, `instanceof`, or type guard |
| Accessing `unknown` without validation | Validate first                            |
| Ignoring discriminant narrowing        | Use switch/if on discriminant             |

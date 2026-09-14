---
key: TYP-02
category: Type relationships and reuse
title: type-generic-relationship
description: Use generics only when they model a real type relationship
impact: MEDIUM
impactDescription: Keeps APIs readable by avoiding unnecessary generic syntax.
---

## TYP-02: Use generics only when they model a real type relationship

**When to apply:** Writing or reviewing a generic function/type: check that every type parameter actually relates two or more places in the signature.

Add a generic only when it captures a meaningful relationship between inputs, outputs, or parameters.

**Why:** Unnecessary generics make APIs harder to read without improving type safety.

**Incorrect:**

```ts
function findUser<T>(id: string): User {
  return db.find(id);
}
```

**Correct:**

```ts
function identity<T>(value: T): T {
  return value;
}

function first<T>(arr: T[]): T | undefined {
  return arr[0];
}
```

### When this is overkill

Generics add cognitive overhead. Prefer concrete types when:

- The function works with only one specific type
- The generic relationship isn't meaningful to callers

### Mechanical enforcement

Add `@typescript-eslint/no-unnecessary-type-parameters` (type-aware) to your lint rules — it flags a generic used only once.

**Covers:** a generic type parameter that's referenced only once in the signature.

**Still manual:** a generic referenced two-or-more times that still doesn't model a real relationship (e.g. it's always instantiated with the same concrete type) — the rule can't detect that.

### Common mistakes

| Mistake                           | Fix                                |
| --------------------------------- | ---------------------------------- |
| Generic where concrete type works | Use concrete type instead          |
| Generic without constraints       | Add `extends` if structure assumed |
| Type flows through but isn't used | Concrete type is clearer           |

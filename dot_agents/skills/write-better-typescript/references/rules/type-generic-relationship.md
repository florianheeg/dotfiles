---
key: type-generic-relationship
category: Type relationships and reuse
title: Use generics only when they model a real type relationship
impact: MEDIUM
impactDescription: Keeps APIs readable by avoiding unnecessary generic syntax.
---

## Use generics only when they model a real type relationship

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

### Common mistakes

| Mistake                           | Fix                                |
| --------------------------------- | ---------------------------------- |
| Generic where concrete type works | Use concrete type instead          |
| Generic without constraints       | Add `extends` if structure assumed |
| Type flows through but isn't used | Concrete type is clearer           |

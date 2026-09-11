---
key: type-constrained-generic
category: Type relationships and reuse
title: Constrain generics when structure is assumed
impact: MEDIUM
impactDescription: Improves generic API safety and error clarity.
---

## Constrain generics when structure is assumed

When a generic function relies on certain fields or keys, constrain the generic accordingly.

**Why:** Unconstrained generics make functions look more flexible than they are.

**Incorrect:**

```ts
function getId<T>(item: T) {
  return item.id; // Error: T doesn't have id
}
```

**Correct:**

```ts
function getId<T extends { id: string }>(item: T): string {
  return item.id;
}
```

### Common mistakes

| Mistake                                   | Fix                               |
| ----------------------------------------- | --------------------------------- |
| Generic using property without constraint | Add `extends` with required shape |
| Generic assuming method exists            | Constrain to callable type        |
| Generic without any constraint needed     | Use concrete type instead         |

---
key: TYP-03
category: Type relationships and reuse
title: type-constrained-generic
description: Constrain generics when structure is assumed
impact: MEDIUM
impactDescription: Improves generic API safety and error clarity.
---

## TYP-03: Constrain generics when structure is assumed

**When to apply:** A generic function accesses a property or calls a method on its generic parameter.

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

### Mechanical enforcement

Nothing to configure: if you followed `CFG-01` to enable `strict`, accessing a property that isn't declared on an unconstrained `T` is already a compile error.

**Covers the entire rule** — nothing left to check manually.

### Common mistakes

| Mistake                                   | Fix                               |
| ----------------------------------------- | --------------------------------- |
| Generic using property without constraint | Add `extends` with required shape |
| Generic assuming method exists            | Constrain to callable type        |
| Generic without any constraint needed     | Use concrete type instead         |

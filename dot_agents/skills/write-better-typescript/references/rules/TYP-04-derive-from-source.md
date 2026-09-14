---
key: TYP-04
category: Type relationships and reuse
title: type-derive-from-source
description: Prefer deriving related types over manually repeating them
impact: LOW-MEDIUM
impactDescription: Reduces repeated type maintenance and keeps contracts aligned.
---

## TYP-04: Prefer deriving related types over manually repeating them

**When to apply:** Defining a type that's a strict subset or variant of another type already declared nearby.

When one type is mechanically derived from another, derive it instead of repeating fields by hand.

**Why:** Manual repetition drifts when the source type changes.

**Incorrect:**

```ts
type ApiUser = { id: string; email: string; createdAt: string };
type EditableUser = { email: string };
```

**Correct:**

```ts
type ApiUser = { id: string; email: string; createdAt: string };
type EditableUser = Omit<ApiUser, 'id' | 'createdAt'>;
```

### Common mistakes

| Mistake                             | Fix                                   |
| ----------------------------------- | ------------------------------------- |
| Repeating fields from source type   | Use `Omit`, `Pick`, or indexed access |
| Manually maintaining parallel types | Derive from source                    |
| Type drifting from runtime value    | Use `typeof` or `z.infer`             |

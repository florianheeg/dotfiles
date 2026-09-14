---
key: TYP-05
category: Type relationships and reuse
title: type-readable-abstraction
description: Keep reusable type abstractions readable and justified
impact: LOW-MEDIUM
impactDescription: Prevents shared type helpers from becoming hard to understand.
---

## TYP-05: Keep reusable type abstractions readable and justified

**When to apply:** Introducing or reviewing a shared/reusable type helper meant to be used in more than one place.

Abstract type logic only when it solves a real repeated problem and remains understandable.

**Why:** Reusable type helpers are code too. If they become too clever, they cost more in readability than they save.

**Incorrect:**

```ts
type Weird<T> = {
  [K in keyof T as `${string & K}ValueMaybe`]?: T[K] | null | undefined;
};
```

**Correct:**

```ts
type EditableUser = Omit<User, 'id' | 'createdAt'>;
```

### Common mistakes

| Mistake                            | Fix                           |
| ---------------------------------- | ----------------------------- |
| Complex type without clear purpose | Write the type explicitly     |
| Type needs a comment to explain    | Simplify or rename            |
| One-off abstraction                | Don't abstract until repeated |
| Clever over readable               | Prefer explicit over clever   |

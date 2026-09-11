---
key: assert-avoid-casts
category: Unsafe escape hatches
title: Avoid unsafe casts as the default fix
impact: MEDIUM-HIGH
impactDescription: Prevents silencing type errors instead of solving them.
---

## Avoid unsafe casts as the default fix

Do not use casts to force the compiler to accept a value unless you have a well-understood reason.

**Why:** Casts suppress feedback without proving anything about runtime correctness.

**Incorrect:**

```ts
const user = response as User;
```

**Correct:**

```ts
const user = parseUser(response);
```

### Common mistakes

| Mistake                           | Fix                         |
| --------------------------------- | --------------------------- |
| Using `as Type` to silence errors | Find the real type issue    |
| Cast instead of validation        | Use parser function         |
| `as any as X` double cast         | Fix the source type         |
| Cast to avoid refactoring         | Redesign the types properly |

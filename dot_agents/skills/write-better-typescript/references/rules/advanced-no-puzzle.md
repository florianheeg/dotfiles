---
key: advanced-no-puzzle
category: Advanced type programming
title: Avoid type-level cleverness that hurts readability
impact: MEDIUM
impactDescription: Keeps advanced types from becoming maintenance burdens.
---

## Avoid type-level cleverness that hurts readability

Do not turn business code into a type puzzle.

**Why:** Advanced type tricks may compile, but they impose cognitive cost on every future reader and maintainer.

**Incorrect:**

```ts
type IfEquals<T, U> = (<G>() => G extends T ? 1 : 2) extends <G>() => G extends U ? 1 : 2 ? true : false;
```

**Correct:**

```ts
// Prefer explicit over clever
type Shape = Circle | Rectangle | Triangle;
```

### When type cleverness is justified

- Repeated structural transformations
- Library code where the abstraction is the product
- Type-level validation that would replace runtime checks

### Common mistakes

| Mistake                                 | Fix                           |
| --------------------------------------- | ----------------------------- |
| Complex type needs a comment to explain | Simplify or split it          |
| Single-letter generic names             | Use descriptive names         |
| Nested conditional types 3+ levels      | Break into intermediate types |

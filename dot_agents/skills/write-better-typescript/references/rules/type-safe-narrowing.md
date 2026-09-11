---
key: type-safe-narrowing
category: Type relationships and reuse
title: Narrow values before using them as more specific types
impact: MEDIUM-HIGH
impactDescription: Prevents unsafe property access and makes unions safe to work with.
---

## Narrow values before using them as more specific types

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

### Common mistakes

| Mistake                                | Fix                                       |
| -------------------------------------- | ----------------------------------------- |
| Accessing property without narrowing   | Use `typeof`, `instanceof`, or type guard |
| Accessing `unknown` without validation | Validate first                            |
| Ignoring discriminant narrowing        | Use switch/if on discriminant             |

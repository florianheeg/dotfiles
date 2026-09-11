---
key: assert-satisfies-operator
category: Unsafe escape hatches
title: Use satisfies to validate literals without widening
impact: LOW-MEDIUM
impactDescription: Validates literals while preserving narrow type information.
---

## Use `satisfies` to validate literals without widening

Use the `satisfies` operator to validate that a value matches a type without widening the inferred type.

**Why:** `satisfies` validates at compile time while preserving the literal type, unlike type annotations which widen.

**Incorrect:**

```ts
const config = {
  port: 3000,
  host: 'localhost',
};
// Type is widened - loses autocomplete
```

**Correct:**

```ts
const config = {
  port: 3000,
  host: 'localhost',
} satisfies Record<string, string | number>;

// Type preserved as { port: 3000; host: "localhost" }
config.port.toFixed(); // Error: number doesn't have toFixed
```

### Common mistakes

| Mistake                           | Fix                                  |
| --------------------------------- | ------------------------------------ |
| Using `as` instead of `satisfies` | Use `satisfies` to preserve literals |
| Type annotation widening literals | Use `satisfies` for validation       |
| Losing autocomplete on config     | Validate with `satisfies`            |

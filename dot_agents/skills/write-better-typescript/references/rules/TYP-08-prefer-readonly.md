---
key: TYP-08
category: Type relationships and reuse
title: type-prefer-readonly
description: Use readonly to keep data that should not mutate from mutating
impact: MEDIUM
impactDescription: Turns accidental mutation into a compile error, especially across function boundaries.
---

## TYP-08: Use `readonly` to keep data that should not mutate from mutating

**When to apply:** A function parameter, object property, or array is only ever read, never mutated, by the code that receives it.

Mark array, tuple, and object properties `readonly` when a function only reads them, or when the value represents a fact that shouldn't change after creation.

**Why:** A plain `T[]` or mutable object type allows any function that receives it to mutate the caller's data, including by accident. `readonly` pushes that mistake to a compile error instead of a runtime surprise shared across unrelated call sites.

**Incorrect:**

```ts
function printAll(items: string[]) {
  items.push('done'); // compiles, silently mutates the caller's array
  console.log(items.join(', '));
}

interface Config {
  servers: string[];
}
```

**Correct:**

```ts
function printAll(items: readonly string[]) {
  items.push('done'); // Error: push does not exist on readonly string[]
  console.log(items.join(', '));
}

interface Config {
  readonly servers: readonly string[];
}
```

### Where to default to `readonly`

| Case                                            | Use                                                          |
| ----------------------------------------------- | ------------------------------------------------------------ |
| Function parameter that is only read            | `readonly T[]` — accepts mutable and readonly callers alike  |
| Object property representing a fixed fact       | `readonly` modifier on the property                          |
| Fixed-length data                               | `readonly [A, B]` readonly tuple                             |
| A function that intentionally mutates its input | Leave it mutable — don't fight the function's actual purpose |

### Mechanical enforcement

Add `@typescript-eslint/prefer-readonly` to your lint rules for class fields. For function parameters, add `prefer-readonly-parameter-types` (type-aware) too, but tune its options — it isn't part of any recommended preset and can be noisy on generics.

**Covers:** private class fields only ever assigned in the constructor (`prefer-readonly`), and, if enabled and tuned, array/object function parameters (`prefer-readonly-parameter-types`).

**Still manual:** `readonly` on object properties and local variables outside those two cases — nothing lints for that.

### Common mistakes

| Mistake                                                                    | Fix                                                                  |
| -------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| Array parameter that's never meant to be mutated                           | Annotate as `readonly T[]`                                           |
| Object property that should represent an immutable fact                    | Add the `readonly` modifier                                          |
| Passing a `readonly` array where a mutable one is required                 | Copy it explicitly with `[...items]`, don't widen the parameter type |
| Marking everything `readonly` including data a function is meant to mutate | Keep genuinely mutable state mutable                                 |

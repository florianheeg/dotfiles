---
key: TYP-09
category: Type relationships and reuse
title: type-interface-vs-alias
description: Choose interface or type alias based on what the shape needs to do
impact: LOW-MEDIUM
impactDescription: Avoids arbitrary inconsistency and picks the form that supports the feature actually needed.
---

## TYP-09: Choose `interface` or `type` alias based on what the shape needs to do

**When to apply:** Declaring a new named object shape and deciding between `interface` and `type`.

Use `interface` for object shapes that callers or other modules may need to extend or declaration-merge. Use `type` for unions, tuples, mapped types, and anything that isn't a single extensible object shape.

**Why:** The two are not interchangeable. Only `interface` supports declaration merging and is extended with `extends` in a way that surfaces clearer error messages on conflicts. Only `type` can express a union, a conditional type, or a mapped type at all.

**Incorrect:**

```ts
// A union forced into an interface-shaped workaround
interface StringOrNumberBox {
  value: string | number;
  kind: 'string' | 'number';
}
```

```ts
// Public, extensible object shape declared as `type` for no reason,
// blocking consumers from using `extends` or augmenting it later
type PluginConfig = {
  name: string;
  version: string;
};
```

**Correct:**

```ts
type Result = { kind: 'string'; value: string } | { kind: 'number'; value: number };

interface PluginConfig {
  name: string;
  version: string;
}

interface ScopedPluginConfig extends PluginConfig {
  scope: string;
}
```

### Decision guide

| Need                                                         | Use                                                             |
| ------------------------------------------------------------ | --------------------------------------------------------------- |
| Union, tuple, mapped, or conditional type                    | `type`                                                          |
| Object shape a third party may augment (declaration merging) | `interface`                                                     |
| Object shape meant to be extended within your own codebase   | Either works; prefer `interface` + `extends` for clearer errors |
| One-off object shape with no extension need                  | Either; match the surrounding file's convention                 |

### Mechanical enforcement

Add `@typescript-eslint/consistent-type-definitions` to your lint rules to enforce one global choice (`interface` or `type`) for object shapes. The union half needs no configuration: a union is already impossible to write as an `interface`.

**Covers:** enforces one global `interface`-or-`type` convention; a union is already a compile error as an `interface`.

**Still manual:** the nuanced "use `interface` only when extension/augmentation is actually needed" judgment — the lint rule can only enforce blanket consistency, not this case-by-case reasoning.

### Common mistakes

| Mistake                                                                 | Fix                                               |
| ----------------------------------------------------------------------- | ------------------------------------------------- |
| Modeling a union as an `interface` with optional fields                 | Use a `type` union instead                        |
| Declaring a public, extensible shape as `type`                          | Use `interface` so consumers can augment it       |
| Switching between `interface` and `type` with no reason within one file | Pick one convention per shape and stay consistent |

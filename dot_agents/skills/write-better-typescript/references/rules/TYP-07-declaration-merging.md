---
key: TYP-07
category: Type relationships and reuse
title: type-declaration-merging
description: Use declaration merging to extend types intentionally
impact: LOW
impactDescription: Enables type-safe extension patterns for plugins and extendable interfaces.
---

## TYP-07: Use declaration merging to extend types intentionally

**When to apply:** Intentionally extending an existing interface's shape from a different file or module (plugin systems, ambient type extension).

Declaration merging combines multiple declarations with the same name. Use for plugin systems and extendable interfaces.

**Why:** Declaration merging provides a type-safe way to extend types without `any`.

**Correct:**

```ts
interface AppPlugin {
  name: string;
}

declare module './app' {
  interface App {
    plugins: AppPlugin[];
  }
}
```

### Common patterns

```ts
// Interface merging
interface Formatter {
  format(date: Date): string;
}
interface Formatter {
  format(date: Date, locale: string): string;
}

// Namespace merging
namespace Utils {
  export function helper() {}
}
namespace Utils {
  export const constant = 42;
}
```

### Mechanical enforcement

Nothing to configure: the compiler already rejects incompatible merges (conflicting member types are a type error) with no extra setup.

**Covers:** incompatible merges — the compiler always rejects these.

**Still manual:** telling an _intentional_ merge apart from an _accidental_ same-name collision that happens to be structurally compatible — the compiler accepts both.

### Common mistakes

| Mistake                       | Fix                                       |
| ----------------------------- | ----------------------------------------- |
| Accidental merging            | Use unique names to avoid conflicts       |
| Merging incompatible types    | Ensure merged declarations are compatible |
| `any` instead of augmentation | Use declaration merging                   |

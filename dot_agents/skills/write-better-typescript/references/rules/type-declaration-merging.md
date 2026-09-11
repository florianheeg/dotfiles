---
key: type-declaration-merging
category: Type relationships and reuse
title: Use declaration merging to extend types intentionally
impact: LOW
impactDescription: Enables type-safe extension patterns for plugins and extendable interfaces.
---

## Use declaration merging to extend types intentionally

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

### Common mistakes

| Mistake                       | Fix                                       |
| ----------------------------- | ----------------------------------------- |
| Accidental merging            | Use unique names to avoid conflicts       |
| Merging incompatible types    | Ensure merged declarations are compatible |
| `any` instead of augmentation | Use declaration merging                   |

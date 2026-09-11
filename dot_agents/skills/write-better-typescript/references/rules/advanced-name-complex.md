---
key: advanced-name-complex
category: Advanced type programming
title: Name complex type aliases clearly and split them when needed
impact: LOW
impactDescription: Improves maintainability of advanced type logic.
---

## Name complex type aliases clearly and split them when needed

Give advanced type aliases descriptive names and break them into smaller parts when one alias does too much.

**Why:** Readable names and smaller pieces make advanced type logic easier to review, debug, and reuse.

**Incorrect:**

```ts
type X<T, U, V> = { [K in keyof T]: V };
```

**Correct:**

```ts
type Transform<Result, Source> = { [K in keyof Source]: Result };
```

### When to split

Split complex types when:

- One type does multiple things
- Generic parameters have different roles
- A reader would need to trace through multiple levels

### Common patterns

| Pattern                  | Use                              |
| ------------------------ | -------------------------------- |
| `Merge<Base, Overrides>` | Merging two object types         |
| `Transform<T, U>`        | Transforming one type to another |
| `ExtractKeys<T, Filter>` | Filtering keys by condition      |

### Common mistakes

| Mistake                  | Fix                                         |
| ------------------------ | ------------------------------------------- |
| Single-letter generics   | Use descriptive names that indicate purpose |
| No name for complex type | Extract to named type alias                 |
| Cryptic abbreviations    | Spell it out                                |

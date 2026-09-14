---
key: ADV-05
category: Advanced type programming
title: advanced-infer-usage
description: Use infer for real type extraction, not as a general tool
impact: LOW
impactDescription: Prevents misuse and keeps conditional types readable.
---

## ADV-05: Use `infer` for real type extraction, not as a general tool

**When to apply:** Reaching for `infer` inside a conditional type.

The `infer` keyword extracts types within conditional type expressions. Use it only when you need to extract and reuse a type.

**Why:** `infer` is powerful but easy to misuse. Complex `infer` expressions become hard to read.

**When `infer` is justified:**

```ts
type Resolved<T> = T extends Promise<infer V> ? V : T;
type ElementOf<T> = T extends (infer E)[] ? E : never;
```

**When not to use `infer`:**

```ts
// Use ReturnType instead
type MyReturn<T> = T extends (...args: any[]) => infer R ? R : never;
// Just use: ReturnType<T>
```

### Common mistakes

| Mistake                        | Fix                                   |
| ------------------------------ | ------------------------------------- |
| Reimplementing ReturnType      | Use built-in `ReturnType<T>`          |
| Complex nested inference       | Break into simpler steps              |
| Using `infer` for simple cases | Use utility types instead             |
| `infer` without conditional    | `infer` only works in extends clauses |

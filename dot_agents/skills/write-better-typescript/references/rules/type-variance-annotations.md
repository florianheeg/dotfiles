---
key: type-variance-annotations
category: Advanced type programming
title: Understand and control type variance
impact: LOW
impactDescription: Enables explicit control over subtyping in complex generic types.
---

## Understand and control type variance

Type variance describes how type relationships work when types contain other types. Use `in` and `out` annotations for explicit control.

**Why:** Understanding variance prevents subtle bugs in generic types.

### Variance categories

| Variance             | Meaning           | Examples                      |
| -------------------- | ----------------- | ----------------------------- |
| Covariant (`out`)    | Output only       | `Promise<T>`, `Observable<T>` |
| Contravariant (`in`) | Input only        | `Comparator<T>`, callbacks    |
| Invariant            | Both input/output | Mutable containers            |

```ts
// Covariant - output only
type Producer<out T> = () => T;

// Contravariant - input only
type Consumer<in T> = (value: T) => void;

// Invariant - both input and output
type Container<in out T> = {
  get(): T;
  set(value: T): void;
};
```

### Common mistakes

| Mistake                               | Fix                                        |
| ------------------------------------- | ------------------------------------------ |
| Ignoring variance in complex generics | Add explicit `in`/`out` annotations        |
| Mutable containers as covariant       | Mark as invariant or add explicit variance |
| Variance conflicts                    | Understand substitution rules              |

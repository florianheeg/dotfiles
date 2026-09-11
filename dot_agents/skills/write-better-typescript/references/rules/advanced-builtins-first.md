---
key: advanced-builtins-first
category: Advanced type programming
title: Prefer built-in utility types before custom type machinery
impact: LOW-MEDIUM
impactDescription: Reduces unnecessary complexity by using familiar transformations.
---

## Prefer built-in utility types before custom type machinery

Try built-in utility types before writing custom mapped or conditional type helpers.

**Why:** Many common transformations are already covered by standard utilities and are easier for teams to recognize.

**Incorrect:**

```ts
type EditableUser = {
  [K in keyof User as K extends 'id' | 'createdAt' ? never : K]: User[K];
};
```

**Correct:**

```ts
type EditableUser = Omit<User, 'id' | 'createdAt'>;
```

### Built-in utilities to use

| Utility         | Use for                         |
| --------------- | ------------------------------- |
| `Pick<T, K>`    | Selecting specific keys         |
| `Omit<T, K>`    | Removing specific keys          |
| `Partial<T>`    | Making all properties optional  |
| `Record<K, V>`  | Creating object types with keys |
| `Exclude<T, U>` | Removing union members          |
| `ReturnType<T>` | Extracting function return type |

### Common mistakes

| Mistake                         | Fix                      |
| ------------------------------- | ------------------------ |
| Writing `[K in keyof T]: T[K]`  | Just use `T`             |
| Custom optional wrapper         | Use `Partial<T>`         |
| Reimplementing built-in utility | Use the built-in instead |

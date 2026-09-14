---
key: ADV-02
category: Advanced type programming
title: advanced-real-transform
description: Use mapped and conditional types only for real structural transformations
impact: LOW
impactDescription: Keeps advanced type logic focused on genuine reuse cases.
---

## ADV-02: Use mapped and conditional types only for real structural transformations

**When to apply:** Considering a mapped or conditional type: confirm there's a real, repeated structural transformation behind it, not a one-off need.

Reach for mapped and conditional types when they mirror a real repeated structural transformation, not just because they are possible.

**Why:** Advanced type features can become hard to understand quickly when used without a clear repeated problem.

**Incorrect:**

```ts
type UserDTO = {
  [K in keyof User as DTOFieldName<K>]: TransformValue<User[K]>;
};
```

**Correct:**

```ts
interface EditableUser {
  name: string;
  email: string;
  role: Role;
}
```

### When mapped types are justified

| Use case                 | Example         |
| ------------------------ | --------------- |
| Repeated field omission  | `Omit<T, "id"   | "createdAt">` |
| Repeated field selection | `Pick<T, "name" | "email">`     |
| Making fields optional   | `Partial<T>`    |

### Common mistakes

| Mistake                           | Fix                             |
| --------------------------------- | ------------------------------- |
| One-off complex transformation    | Just write the type explicitly  |
| Deep recursive types              | Use a library or explicit depth |
| Mapped type without clear purpose | Just write the result type      |

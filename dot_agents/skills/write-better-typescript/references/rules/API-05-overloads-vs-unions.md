---
key: API-05
category: API and function design
title: api-overloads-vs-unions
description: Prefer discriminated unions over function overloads
impact: MEDIUM
impactDescription: Reduces maintenance burden by avoiding multiple signatures to keep in sync.
---

## API-05: Prefer discriminated unions over function overloads

**When to apply:** About to add a second or third overload signature to a function, or the function already has more than one.

When a function can return different types or accept different input shapes, prefer a discriminated union.

**Why:** Function overloads require maintaining multiple signatures that must be kept in sync. Discriminated unions are easier to maintain.

**Incorrect:**

```ts
function fetchUser(id: string): Promise<User>;
function fetchUser(id: number): Promise<User | null>;
function fetchUser(id: string | number): Promise<User | null> {
  return db.find(id);
}
```

**Correct:**

```ts
type FetchResult = { found: true; user: User } | { found: false };

async function fetchUser(id: string | number): Promise<FetchResult> {
  const user = await db.find(id);
  if (!user) return { found: false };
  return { found: true, user };
}
```

### When overloads are better

- Different parameter types (not optional)
- Built-in JavaScript patterns (like `Array.prototype.slice`)

### Mechanical enforcement

Add `@typescript-eslint/unified-signatures` to your lint rules — it flags overloads that could be merged into one signature with a union.

**Covers:** overloads that are mechanically mergeable into one union-typed signature.

**Still manual:** judging whether an overload should exist at all versus a discriminated-union result type, when the parameter types genuinely differ.

### Common mistakes

| Mistake                       | Fix                                  |
| ----------------------------- | ------------------------------------ |
| Multiple optional parameters  | Use discriminated union              |
| Overloads for success/failure | Use result union type                |
| Keeping overloads in sync     | Use single implementation with union |

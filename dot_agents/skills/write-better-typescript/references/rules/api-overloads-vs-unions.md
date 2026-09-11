---
key: api-overloads-vs-unions
category: API and function design
title: Prefer discriminated unions over function overloads
impact: MEDIUM
impactDescription: Reduces maintenance burden by avoiding multiple signatures to keep in sync.
---

## Prefer discriminated unions over function overloads

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

### Common mistakes

| Mistake                       | Fix                                  |
| ----------------------------- | ------------------------------------ |
| Multiple optional parameters  | Use discriminated union              |
| Overloads for success/failure | Use result union type                |
| Keeping overloads in sync     | Use single implementation with union |

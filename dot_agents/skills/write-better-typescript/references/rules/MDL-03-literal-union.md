---
key: MDL-03
category: State and domain modeling
title: model-literal-union
description: Prefer literal unions over broad string and number types
impact: MEDIUM
impactDescription: Makes allowed values explicit and prevents invalid states.
---

## MDL-03: Prefer literal unions over broad `string` and `number` types

**When to apply:** A `string`/`number` field only ever takes one of a small, known set of values (roles, statuses, modes).

Use literal unions when a value comes from a known finite set.

**Why:** Broad primitives such as `string` and `number` hide the real contract and allow invalid values to flow through the codebase.

**Incorrect:**

```ts
type Role = string;
```

**Correct:**

```ts
type Role = 'admin' | 'editor' | 'viewer';
```

### Common mistakes

| Mistake                            | Fix                          |
| ---------------------------------- | ---------------------------- |
| `type X = string` for finite set   | Use literal union            |
| `status: string` for known states  | Use `"pending"               | "done" | "failed"` |
| Mixing finite and infinite strings | Distinguish with union types |

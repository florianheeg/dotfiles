---
key: model-impossible-state
category: State and domain modeling
title: Model impossible states out of existence
impact: HIGH
impactDescription: Prevents contradictory or incomplete state from being representable.
---

## Model impossible states out of existence

Prefer explicit variants with discriminated unions over loose objects with status booleans and optional fields.

**Why:** When invalid combinations are representable, they eventually appear in real code. Strong state modeling removes whole classes of bugs before runtime.

**Incorrect:**

```ts
type LoadState = {
  isLoading: boolean;
  error?: string;
  data?: User[];
};
```

**Correct:**

```ts
type LoadState =
  { kind: 'idle' } | { kind: 'loading' } | { kind: 'success'; data: User[] } | { kind: 'error'; message: string };
```

### When this is overkill

Do not over-engineer trivial cases:

- Simple boolean toggle (on/off) can stay as `isActive: boolean`
- Internal state that never crosses a boundary

### Common mistakes

| Mistake                                        | Fix                               |
| ---------------------------------------------- | --------------------------------- |
| Status booleans + optional fields              | Use discriminated union           |
| `data?: T` alongside `isLoading`               | Separate states explicitly        |
| Nullable fields for conditionally present data | Use variants with required fields |

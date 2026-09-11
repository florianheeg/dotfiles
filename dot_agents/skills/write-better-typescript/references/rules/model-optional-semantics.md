---
key: model-optional-semantics
category: State and domain modeling
title: Make optional, nullable, and omitted fields mean different things
impact: MEDIUM-HIGH
impactDescription: Prevents ambiguous field semantics in update and patch types.
---

## Make optional, nullable, and omitted fields mean different things on purpose

Decide explicitly what omitted fields, `undefined`, and `null` mean in your model.

**Why:** Optional, nullable, and omitted fields often have different business meaning. Treating them as interchangeable leads to confusing contracts.

**Incorrect:**

```ts
type UpdateUser = {
  name?: string;
};
```

**Correct:**

```ts
type UpdateUser = {
  name?: string | null; // null means explicitly cleared
};
```

Document semantics:

- omitted means unchanged
- `null` means explicitly cleared

### Common mistakes

| Mistake                                           | Fix                                         |
| ------------------------------------------------- | ------------------------------------------- |
| Confusing `?` with `undefined`                    | Document semantics explicitly               |
| Using both `null` and `undefined` interchangeably | Pick one, be consistent                     |
| Patch type without clear semantics                | Define: omitted = unchanged, null = cleared |

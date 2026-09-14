---
key: ASR-02
category: Unsafe escape hatches
title: assert-avoid-casts
description: Avoid unsafe casts as the default fix
impact: MEDIUM-HIGH
impactDescription: Prevents silencing type errors instead of solving them.
---

## ASR-02: Avoid unsafe casts as the default fix

**When to apply:** About to write `as SomeType` (or angle-bracket syntax) to force a value's type.

Do not use casts to force the compiler to accept a value unless you have a well-understood reason.

**Why:** Casts suppress feedback without proving anything about runtime correctness.

**Incorrect:**

```ts
const user = response as User;
```

**Correct:**

```ts
const user = parseUser(response);
```

### Mechanical enforcement

Add `@typescript-eslint/no-unsafe-type-assertion` (type-aware) to your lint rules — it flags casts to genuinely incompatible/unrelated types. To ban `as` outright instead, set `@typescript-eslint/consistent-type-assertions` to `{ "assertionStyle": "never" }` — blunter, since it also blocks legitimate casts.

**Covers:** casts between genuinely unrelated, non-overlapping types.

**Still manual:** a cast between two types that do overlap but is still semantically wrong (e.g. asserting a narrower shape than what's actually guaranteed) — the type system can't distinguish that from a correct narrowing.

### Common mistakes

| Mistake                           | Fix                         |
| --------------------------------- | --------------------------- |
| Using `as Type` to silence errors | Find the real type issue    |
| Cast instead of validation        | Use parser function         |
| `as any as X` double cast         | Fix the source type         |
| Cast to avoid refactoring         | Redesign the types properly |

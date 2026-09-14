---
key: CFG-02
category: Project configuration
title: config-strict-checks
description: Enable strict safety checks beyond strict mode
impact: MEDIUM-HIGH
impactDescription: Closes remaining safety gaps for lookups, catch variables, and optional properties.
---

## CFG-02: Enable strict safety checks

**When to apply:** `strict` is already on and you want to close its remaining gaps (indexed lookups, `catch` variables, optional-property semantics).

Enable `noUncheckedIndexedAccess`, `useUnknownInCatchVariables`, and `exactOptionalPropertyTypes`.

**Why:** `strict` still leaves real gaps: array and object lookups, `catch` variables, and optional properties stay unsound until these flags close them.

```json
{
  "compilerOptions": {
    "noUncheckedIndexedAccess": true,
    "useUnknownInCatchVariables": true,
    "exactOptionalPropertyTypes": true
  }
}
```

**`noUncheckedIndexedAccess`** — Forces handling of possibly missing values:

```ts
const user = usersById['123']; // Now { name: string } | undefined
```

**`useUnknownInCatchVariables`** — Forces explicit narrowing in catch:

```ts
catch (error: unknown) {
  console.error((error as Error).message);  // Must narrow
}
```

**`exactOptionalPropertyTypes`** — Distinguishes omitted from undefined:

```ts
const patch: UpdateUser = { name: undefined }; // Error - should omit
```

### Mechanical enforcement

Set `noUncheckedIndexedAccess`, `useUnknownInCatchVariables`, and `exactOptionalPropertyTypes` to `true` in `tsconfig.json`, alongside `CFG-01`'s `strict`.

**Covers the entire rule** — nothing left to check manually.

### Common mistakes

| Mistake                                 | Fix                         |
| --------------------------------------- | --------------------------- |
| Ignoring `noUncheckedIndexedAccess`     | Handle undefined in lookups |
| Using `error.message` without narrowing | Narrow to Error type first  |
| `{ name: undefined }` for optional      | Just omit the property      |

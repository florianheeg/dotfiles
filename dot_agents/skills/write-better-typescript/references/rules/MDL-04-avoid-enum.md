---
key: MDL-04
category: State and domain modeling
title: model-avoid-enum
description: Prefer literal unions or as-const objects over enum
impact: MEDIUM
impactDescription: Avoids enum-specific runtime and typing footguns while keeping a finite set of values.
---

## MDL-04: Prefer literal unions or `as const` objects over `enum`

**When to apply:** About to declare a fixed set of named constants and reaching for `enum`.

Default to a string literal union (or an `as const` object when a runtime lookup is also needed) instead of TypeScript's `enum`.

**Why:** `enum` is not just a type — numeric enums allow any number to be assigned without error, unlike a literal union. `enum` also generates runtime JavaScript (an object plus, for numeric enums, a reverse mapping) that most call sites don't need, and it doesn't structurally match plain string values coming from JSON or an API, forcing extra casts at every boundary.

**Incorrect:**

```ts
enum Role {
  Admin,
  Editor,
  Viewer,
}

function setRole(role: Role) {}

setRole(3); // no error: numeric enums accept any number
```

**Correct:**

```ts
const ROLES = ['admin', 'editor', 'viewer'] as const;
type Role = (typeof ROLES)[number];

function setRole(role: Role) {}

setRole('owner'); // Error: not assignable to Role
```

### When a lookup object is also needed

```ts
const Role = {
  Admin: 'admin',
  Editor: 'editor',
  Viewer: 'viewer',
} as const;

type Role = (typeof Role)[keyof typeof Role];
```

### When `enum` is acceptable

- Interop with an existing codebase or a third-party API that already declares enums
- `const enum` in a controlled build where the numeric encoding itself is part of a wire format

### Mechanical enforcement

Add a `no-restricted-syntax` rule banning the enum syntax node:

```json
{
  "rules": {
    "no-restricted-syntax": [
      "error",
      { "selector": "TSEnumDeclaration", "message": "Use a literal union or an as-const object instead of enum." }
    ]
  }
}
```

**Covers:** bans writing `enum` anywhere in the codebase.

**Still manual:** verifying the literal union or `as const` object you replace it with actually matches the real finite set of values — the ban only stops `enum`, it doesn't check the replacement.

### Common mistakes

| Mistake                                         | Fix                                                |
| ----------------------------------------------- | -------------------------------------------------- |
| Numeric `enum` for a fixed set of options       | String literal union or `as const` object          |
| Casting API string values to an `enum`          | Use a literal union that matches the wire format   |
| Needing both a type and a runtime lookup        | `as const` object + `(typeof X)[keyof typeof X]`   |
| Assuming enum members are exhaustive at runtime | Validate incoming values against the literal union |

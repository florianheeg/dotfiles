---
key: MDL-05
category: State and domain modeling
title: model-derived-type
description: Derive types from values instead of duplicating them
impact: MEDIUM
impactDescription: Reduces drift between runtime values and type definitions.
---

## MDL-05: Derive types from values instead of duplicating them

**When to apply:** A type and a runtime value (allowed options, route table, config keys) describe the same set but are declared separately.

Prefer deriving types from runtime values when those values already define the allowed shape or set of options.

**Why:** Duplicating the same information in both a value and a type creates drift over time.

**Incorrect:**

```ts
type Role = 'admin' | 'editor' | 'viewer';
const ROLES = ['admin', 'editor', 'viewer'];
```

**Correct:**

```ts
const ROLES = ['admin', 'editor', 'viewer'] as const;
type Role = (typeof ROLES)[number];
```

### Common mistakes

| Mistake                                  | Fix                               |
| ---------------------------------------- | --------------------------------- |
| Separate type and value definitions      | Derive type from the value        |
| Manually typing what `as const` captures | Use `typeof X[number]` for unions |
| Separate object and type for routes      | Use `keyof typeof routes`         |

---
key: CFG-01
category: Project configuration
title: config-strict
description: Enable strict mode
impact: HIGH
impactDescription: Raises the type-safety floor and catches unsafe patterns early.
---

## CFG-01: Enable strict mode

**When to apply:** Setting up a new project, or auditing a `tsconfig.json` that doesn't have `strict` on yet.

Enable `strict` mode in `tsconfig.json`. This is the main switch that turns TypeScript into a real static checking system.

**Why:** Without `strict`, many unsafe patterns compile quietly.

**Incorrect:**

```json
{
  "compilerOptions": {
    "strict": false
  }
}
```

**Correct:**

```json
{
  "compilerOptions": {
    "strict": true
  }
}
```

### What `strict` enables

| Flag                           | What it catches                      |
| ------------------------------ | ------------------------------------ |
| `strictNullChecks`             | Using possibly undefined/null values |
| `noImplicitAny`                | Untyped values defaulting to `any`   |
| `strictFunctionTypes`          | Incorrect function parameter types   |
| `strictPropertyInitialization` | Uninitialized class properties       |

### Mechanical enforcement

Set `"strict": true` in `tsconfig.json`.

**Covers the entire rule** — nothing left to check manually.

### Common mistakes

| Mistake                               | Fix                                      |
| ------------------------------------- | ---------------------------------------- |
| `"strict": false`                     | Enable strict, fix errors incrementally  |
| Many `any` params with `strict: true` | Use `unknown` + validation at boundaries |
| Disabling strict per-file             | Fix the underlying type issues           |

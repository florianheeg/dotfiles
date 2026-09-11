---
key: config-strict
category: Project configuration
title: Enable strict mode
impact: HIGH
impactDescription: Raises the type-safety floor and catches unsafe patterns early.
---

## Enable strict mode

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

### Common mistakes

| Mistake                               | Fix                                      |
| ------------------------------------- | ---------------------------------------- |
| `"strict": false`                     | Enable strict, fix errors incrementally  |
| Many `any` params with `strict: true` | Use `unknown` + validation at boundaries |
| Disabling strict per-file             | Fix the underlying type issues           |

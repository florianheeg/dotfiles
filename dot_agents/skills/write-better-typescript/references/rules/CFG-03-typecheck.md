---
key: CFG-03
category: Project configuration
title: config-typecheck
description: Add a typecheck command that runs tsc --noEmit
impact: LOW-MEDIUM
impactDescription: Makes type-checking explicit and repeatable without producing build artifacts.
---

## CFG-03: Add a typecheck command that runs `tsc --noEmit`

**When to apply:** The repo has no dedicated way to run `tsc` on its own, separate from a build or bundler step.

Add a dedicated `typecheck` command to the project.

**Why:** A dedicated command makes type-checking runnable in CI and locally without coupling it to a build, so type errors surface even when nothing is emitted.

```json
{
  "scripts": {
    "typecheck": "tsc --noEmit"
  }
}
```

Use this command locally and in CI.

### Mechanical enforcement

Add a `typecheck` script to `package.json` and run it as its own CI step:

```json
{
  "scripts": {
    "typecheck": "tsc --noEmit"
  }
}
```

**Covers the entire rule** — nothing left to check manually.

### Common mistakes

| Mistake                         | Fix                                 |
| ------------------------------- | ----------------------------------- |
| No dedicated typecheck command  | Add `typecheck: tsc --noEmit`       |
| Typecheck tied to build output  | Use `--noEmit` to separate concerns |
| CI only runs builds             | Run typecheck in CI pipeline        |
| Relying only on editor feedback | Have explicit typecheck in workflow |

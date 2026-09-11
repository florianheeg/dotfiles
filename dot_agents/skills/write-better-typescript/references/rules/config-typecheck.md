---
key: config-typecheck
category: Project configuration
title: Add a typecheck command that runs tsc --noEmit
impact: LOW-MEDIUM
impactDescription: Makes type-checking explicit and repeatable without producing build artifacts.
---

## Add a typecheck command that runs `tsc --noEmit`

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

### Common mistakes

| Mistake                         | Fix                                 |
| ------------------------------- | ----------------------------------- |
| No dedicated typecheck command  | Add `typecheck: tsc --noEmit`       |
| Typecheck tied to build output  | Use `--noEmit` to separate concerns |
| CI only runs builds             | Run typecheck in CI pipeline        |
| Relying only on editor feedback | Have explicit typecheck in workflow |

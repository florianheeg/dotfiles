---
key: boundary-validate-input
category: External data boundaries
title: Treat external data as untrusted and validate it at the boundary
impact: HIGH
impactDescription: Prevents unchecked external data from being treated as already safe.
---

## Treat external data as untrusted and validate it at the boundary

Use `unknown` by default for external input, then validate it as close as possible to where it enters the system.

**Why:** TypeScript only checks the assumptions in your code. It does not verify that API responses, parsed JSON, browser storage values, configuration values, or third-party callback payloads actually match those assumptions at runtime.

**Incorrect:**

```ts
const data: User = await response.json();
saveUser(data);
```

**Correct:**

```ts
const data: unknown = await response.json();
const user = parseUser(data);
saveUser(user);
```

### When to use what

| Pattern            | Use when                                           |
| ------------------ | -------------------------------------------------- |
| Type guard         | Simple structure, need `if (isUser(value))` checks |
| Assertion function | Invalid input should throw immediately             |
| Parser function    | One clear boundary with optional normalization     |
| Zod                | Large/nested schemas, shared validation rules      |

Treat as external: API responses, parsed JSON, localStorage, env vars, third-party callbacks.

### Common mistakes

| Mistake                                 | Fix                            |
| --------------------------------------- | ------------------------------ |
| Assigning trusted type to external data | Use `unknown` + validation     |
| Missing validation on `JSON.parse`      | Parse through validator        |
| `any` spreading from boundary           | Keep `any` isolated at wrapper |

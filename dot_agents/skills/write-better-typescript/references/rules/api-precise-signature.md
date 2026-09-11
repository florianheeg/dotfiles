---
key: api-precise-signature
category: API and function design
title: Make function signatures reflect real input and output behavior
impact: HIGH
impactDescription: Improves correctness and refactor safety by making APIs tell the truth.
---

## Make function signatures reflect real input and output behavior

Write function signatures that accurately describe what inputs are accepted and what outputs are produced.

**Why:** Loose signatures push ambiguity to call sites and make misuse easier.

**Incorrect:**

```ts
function parse(value: string): any {
  return JSON.parse(value);
}
```

**Correct:**

```ts
function parseJSON<T>(value: string): T {
  return JSON.parse(value) as T;
}
```

```ts
function getConfig(): Config {
  return JSON.parse(process.env.CONFIG);
}
```

### Common mistakes

| Mistake               | Fix                                               |
| --------------------- | ------------------------------------------------- |
| Return `any`          | Return specific type or `unknown` with validation |
| Return `object`       | Return a named interface or type                  |
| Missing nullability   | Return `T                                         | null`or`T | undefined` explicitly |
| Vague parameter types | Use specific unions or interfaces                 |

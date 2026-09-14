---
key: API-01
category: API and function design
title: api-precise-signature
description: Make function signatures reflect real input and output behavior
impact: HIGH
impactDescription: Improves correctness and refactor safety by making APIs tell the truth.
---

## API-01: Make function signatures reflect real input and output behavior

**When to apply:** Writing or reviewing a function signature: check that parameter and return types describe what actually happens, not a placeholder like `any`/`object`.

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

### Don't over-annotate what inference already gets right

"Precise" describes function boundaries — parameters and return types — not every local variable. Redundant annotations on locals whose type is obvious from the initializer add noise without adding safety, and drift when the initializer changes.

```ts
// Unnecessary: type is already `number` from inference
const count: number = items.length;

// Necessary: the boundary, not the local, needs to be explicit
function getConfig(): Config {
  const raw: unknown = JSON.parse(process.env.CONFIG);
  return parseConfig(raw);
}
```

### Mechanical enforcement

Add `@typescript-eslint/no-explicit-any`, `no-unsafe-return` (type-aware), and `explicit-module-boundary-types` to your lint rules. Together they block `any` parameters/returns and require a declared return type on every exported function.

**Covers:** `any`-typed parameters and returns, and a missing return-type declaration on an exported function.

**Still manual:** whether the declared type is actually _accurate_ — a wrong-but-not-`any` return type still passes.

### Common mistakes

| Mistake                    | Fix                                               |
| -------------------------- | ------------------------------------------------- |
| Return `any`               | Return specific type or `unknown` with validation |
| Return `object`            | Return a named interface or type                  |
| Missing nullability        | Return `T                                         | null`or`T | undefined` explicitly |
| Vague parameter types      | Use specific unions or interfaces                 |
| Redundant local annotation | Let inference handle obvious locals               |

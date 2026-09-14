---
key: ASR-01
category: Unsafe escape hatches
title: assert-avoid-any
description: Avoid any except for deliberate, isolated escape hatches
impact: MEDIUM-HIGH
impactDescription: Preserves TypeScript's safety by preventing broad opt-outs.
---

## ASR-01: Avoid `any` except for deliberate, isolated escape hatches

**When to apply:** About to write `any` as a type annotation, parameter type, or return type.

Use `any` only when there is a clear boundary or interop reason and keep it tightly contained.

**Why:** `any` disables type checking exactly where you use it and tends to spread quickly through call sites.

**Incorrect:**

```ts
function handle(data: any) {
  return data.user.name;
}
```

**Correct:**

```ts
function handle(data: unknown) {
  if (isUser(data)) {
    return data.user.name;
  }
}
```

### Mechanical enforcement

Add `@typescript-eslint/no-explicit-any` to your lint rules. If you followed `CFG-01` to enable `strict` (which includes `noImplicitAny`), the implicit-inference gap closes too.

**Covers:** explicit `: any` annotations, and, via `noImplicitAny`, implicit `any` from missing types.

**Still manual:** `any` reintroduced through a cast (`as any`) — see `ASR-02`.

### Common mistakes

| Mistake                             | Fix                        |
| ----------------------------------- | -------------------------- |
| `data: any` in function parameters  | Use `unknown` + validation |
| `any` spreading through call chains | Isolate `any` at boundary  |
| `any` as quick fix                  | Use `unknown` + type guard |

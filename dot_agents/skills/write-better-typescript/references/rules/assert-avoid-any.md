---
key: assert-avoid-any
category: Unsafe escape hatches
title: Avoid any except for deliberate, isolated escape hatches
impact: MEDIUM-HIGH
impactDescription: Preserves TypeScript's safety by preventing broad opt-outs.
---

## Avoid `any` except for deliberate, isolated escape hatches

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

### Common mistakes

| Mistake                             | Fix                        |
| ----------------------------------- | -------------------------- |
| `data: any` in function parameters  | Use `unknown` + validation |
| `any` spreading through call chains | Isolate `any` at boundary  |
| `any` as quick fix                  | Use `unknown` + type guard |

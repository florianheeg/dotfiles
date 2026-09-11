---
key: assert-isolate-unsafe
category: Unsafe escape hatches
title: Isolate unavoidable unsafe typing behind narrow boundaries
impact: MEDIUM
impactDescription: Limits the blast radius of unavoidable unsafety.
---

## Isolate unavoidable unsafe typing behind narrow boundaries

When unsafety is unavoidable, keep it inside a small wrapper, adapter, or utility.

**Why:** The goal is to keep unsafety from leaking across the codebase.

**Incorrect:**

```ts
const sdk: any = getLegacySdk();
export const userId = sdk.session.user.id;
```

**Correct:**

```ts
function getLegacySessionUserId(): string {
  const sdk: any = getLegacySdk();
  return String(sdk.session.user.id);
}
export const userId = getLegacySessionUserId();
```

### Common mistakes

| Mistake                            | Fix                               |
| ---------------------------------- | --------------------------------- |
| `any` leaking through exports      | Isolate `any` in wrapper function |
| Unsafe code scattered across files | Move to one boundary module       |
| Exposing raw interop objects       | Wrap in typed adapter             |

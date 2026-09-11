---
key: boundary-wrap-interop
category: External data boundaries
title: Wrap unsafe library and platform interop behind typed boundaries
impact: MEDIUM
impactDescription: Prevents weakly typed external interfaces from leaking into the codebase.
---

## Wrap unsafe library and platform interop behind typed boundaries

Wrap unsafe library and platform interop in small, typed adapters. Do not let weakly typed APIs, DOM access, or third-party SDK objects flow directly through the application.

**Why:** Not all external interfaces are truly safe just because TypeScript types exist. Some libraries expose broad types such as `any`, `unknown`, or loosely typed objects. Without a typed wrapper, unsafe interop details spread inward.

**Incorrect:**

```ts
thirdPartySdk.on('ready', (payload) => {
  startSession(payload.user.id);
});
```

**Correct:**

```ts
onSdkReady((session) => {
  startSession(session.userId);
});
```

### Common mistakes

| Mistake                                  | Fix                                |
| ---------------------------------------- | ---------------------------------- |
| Raw SDK/dom usage without adapter        | Wrap in typed function             |
| Broad callback types leaking inward      | Validate and narrow inside wrapper |
| Exposing interop objects through exports | Return safe application types      |

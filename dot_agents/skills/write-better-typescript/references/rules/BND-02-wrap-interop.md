---
key: BND-02
category: External data boundaries
title: boundary-wrap-interop
description: Wrap unsafe library and platform interop behind typed boundaries
impact: MEDIUM
impactDescription: Prevents weakly typed external interfaces from leaking into the codebase.
---

## BND-02: Wrap unsafe library and platform interop behind typed boundaries

**When to apply:** Integrating a third-party SDK, a DOM API, or another loosely-typed library whose objects would otherwise flow straight into application code.

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

### Mechanical enforcement

Add `@typescript-eslint/no-unsafe-member-access` and `no-unsafe-call` (both type-aware) to your lint rules.

**Covers:** reading a property or calling a method directly on an `any`-typed value from an SDK or DOM API.

**Still manual:** confirming the typed wrapper you introduce actually narrows/validates the payload rather than just re-asserting the same shape.

### Common mistakes

| Mistake                                  | Fix                                |
| ---------------------------------------- | ---------------------------------- |
| Raw SDK/dom usage without adapter        | Wrap in typed function             |
| Broad callback types leaking inward      | Validate and narrow inside wrapper |
| Exposing interop objects through exports | Return safe application types      |

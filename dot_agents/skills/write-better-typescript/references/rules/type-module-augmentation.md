---
key: type-module-augmentation
category: Type relationships and reuse
title: Use module augmentation to safely extend third-party types
impact: MEDIUM
impactDescription: Enables type-safe extension of third-party types without any.
---

## Use module augmentation to safely extend third-party types

Use TypeScript's module augmentation to add types to existing modules.

**Why:** Third-party libraries often have incomplete types. Module augmentation lets you add types safely.

**Incorrect:**

```ts
const sdk: any = thirdPartyLib;
sdk.initialize({ apiKey: '...' });
```

**Correct:**

```ts
import 'third-party-lib';

declare module 'third-party-lib' {
  interface Config {
    apiKey: string;
    timeout?: number;
  }
}

thirdPartyLib.initialize({ apiKey: '...' });
```

### Common mistakes

| Mistake                                         | Fix                             |
| ----------------------------------------------- | ------------------------------- |
| Using `any` for missing types                   | Use module augmentation         |
| Adding to global scope without `declare global` | Use `declare global` for global |
| Modifying library source                        | Use augmentation instead        |

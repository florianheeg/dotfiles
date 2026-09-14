---
key: TYP-06
category: Type relationships and reuse
title: type-module-augmentation
description: Use module augmentation to safely extend third-party types
impact: MEDIUM
impactDescription: Enables type-safe extension of third-party types without any.
---

## TYP-06: Use module augmentation to safely extend third-party types

**When to apply:** A third-party library's shipped types are missing a property or method you need to use.

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

### Mechanical enforcement

Add `@typescript-eslint/no-explicit-any` to your lint rules — it catches the `any`-typed escape hatch (`const sdk: any`) that this rule tells you to replace with module augmentation.

**Covers:** the literal `any`-typed escape hatch this rule warns against.

**Still manual:** confirming module augmentation — not some other unsafe workaround — is the actual fix applied.

### Common mistakes

| Mistake                                         | Fix                             |
| ----------------------------------------------- | ------------------------------- |
| Using `any` for missing types                   | Use module augmentation         |
| Adding to global scope without `declare global` | Use `declare global` for global |
| Modifying library source                        | Use augmentation instead        |

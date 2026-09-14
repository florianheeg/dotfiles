---
key: MDL-06
category: State and domain modeling
title: model-domain-type
description: Use domain-specific types for important business concepts
impact: LOW-MEDIUM
impactDescription: Reduces accidental mixing of semantically different values.
---

## MDL-06: Use domain-specific types for important business concepts

**When to apply:** Two different primitive values (two kinds of ID, dollars vs. cents) could be accidentally passed to each other's parameter slot.

Use types that represent the meaning of important domain values, not just their primitive shape.

**Why:** Different values may both be strings while representing completely different business concepts.

**Incorrect:**

```ts
function getOrder(orderId: string, userId: string) {}
```

**Correct:**

```ts
type OrderId = string & { readonly __brand: 'OrderId' };
type UserId = string & { readonly __brand: 'UserId' };

function getOrder(orderId: OrderId, userId: UserId) {}
```

### Pair brands with a smart constructor

A branded type is only as trustworthy as the function that produces it. Do not cast a raw string to a branded type at the call site — validate once, at construction, and let the type prove validation already happened.

```ts
function parseOrderId(value: string): OrderId {
  if (!/^ord_[a-z0-9]+$/.test(value)) throw new Error(`Invalid OrderId: ${value}`);
  return value as OrderId;
}
```

### Brands do not survive string operations

Concatenation, slicing, and template literals produce a plain `string`, silently dropping the brand. Re-brand (via the constructor, not a bare cast) after any transformation.

```ts
const padded = orderId + ''; // string, not OrderId — re-validate before use
```

### When this is overkill

Do not brand every string:

- When values are never mixed up
- In small, local code with clear context
- When the overhead outweighs the benefit

### Common mistakes

| Mistake                                 | Fix                                         |
| --------------------------------------- | ------------------------------------------- |
| Confusable IDs as plain strings         | Use branded types                           |
| Mixing units (dollars vs cents)         | Create distinct unit types                  |
| Too many branded types                  | Apply only where confusion is likely        |
| Casting to a brand without validating   | Validate in a smart constructor, then brand |
| Assuming a brand survives concatenation | Re-validate and re-brand after string ops   |

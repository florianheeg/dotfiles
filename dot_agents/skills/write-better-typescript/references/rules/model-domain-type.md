---
key: model-domain-type
category: State and domain modeling
title: Use domain-specific types for important business concepts
impact: LOW-MEDIUM
impactDescription: Reduces accidental mixing of semantically different values.
---

## Use domain-specific types for important business concepts

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

### When this is overkill

Do not brand every string:

- When values are never mixed up
- In small, local code with clear context
- When the overhead outweighs the benefit

### Common mistakes

| Mistake                         | Fix                                  |
| ------------------------------- | ------------------------------------ |
| Confusable IDs as plain strings | Use branded types                    |
| Mixing units (dollars vs cents) | Create distinct unit types           |
| Too many branded types          | Apply only where confusion is likely |

---
key: api-required-input
category: API and function design
title: Require the fields a function actually needs
impact: MEDIUM
impactDescription: Reduces weak contracts and makes dependencies explicit.
---

## Require the fields a function actually needs

Accept the smallest input shape that fully supports the function.

**Why:** Broad input types make functions harder to reuse and hide what they actually depend on.

**Incorrect:**

```ts
function sendWelcomeEmail(user: User) {
  return mail(user.email);
}
```

**Correct:**

```ts
function sendWelcomeEmail(input: { email: string }) {
  return mail(input.email);
}
```

### When this is overkill

Do not extract minimal types when:

- The function is internal and the full object is already available
- The object is small and directly owned by the caller

### Common mistakes

| Mistake                                          | Fix                             |
| ------------------------------------------------ | ------------------------------- |
| Accepting full object when only some fields used | Accept only the fields you need |
| Propagating a large type into helpers            | Create a minimal input type     |
| Making callers pass unused fields                | Extract minimal required subset |

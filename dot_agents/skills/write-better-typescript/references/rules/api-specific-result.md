---
key: api-specific-result
category: API and function design
title: Return specific result types instead of vague objects
impact: MEDIUM
impactDescription: Makes call sites simpler and safer with explicit success/failure variants.
---

## Return specific result types instead of vague objects

Return types should tell callers what to expect without guessing.

**Why:** Vague result objects push interpretation to every caller and often hide variant behavior behind optional fields.

**Incorrect:**

```ts
function save(): { ok: boolean; error?: string; value?: User } {}
```

**Correct:**

```ts
type SaveResult = { ok: true; value: User } | { ok: false; error: string };
```

### Common mistakes

| Mistake                                        | Fix                               |
| ---------------------------------------------- | --------------------------------- |
| `{ ok: boolean; data?: T; error?: string }`    | Use discriminated union           |
| Optional fields for conditionally present data | Use variants with required fields |
| Boolean flag + optional error                  | Use explicit failure variant      |

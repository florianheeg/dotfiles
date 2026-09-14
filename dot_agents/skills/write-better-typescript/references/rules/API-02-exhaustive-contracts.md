---
key: API-02
category: API and function design
title: api-exhaustive-contracts
description: Make invalid parameter combinations impossible with exhaustive contracts
impact: MEDIUM-HIGH
impactDescription: Prevents invalid call combinations and guides callers toward correct usage.
---

## API-02: Make invalid parameter combinations impossible

**When to apply:** A function takes several optional parameters and some combinations of them together are invalid or meaningless.

Design APIs so invalid or incomplete calls are difficult to write. Use discriminated unions for distinct modes.

**Why:** Loose option bags allow contradictory or incomplete combinations that the signature does not explain.

**Incorrect:**

```ts
function fetchReport(type: string, start?: string, end?: string) {}
```

```ts
function createJob(options: { schedule?: string; runNow?: boolean; retries?: number }) {}
```

**Correct:**

```ts
type ReportRequest = { type: 'daily'; date: string } | { type: 'range'; start: string; end: string };

function fetchReport(request: ReportRequest) {}
```

```ts
type JobRequest = { mode: 'scheduled'; schedule: string; retries?: number } | { mode: 'immediate'; retries?: number };

function createJob(request: JobRequest) {}
```

### Common mistakes

| Mistake                                      | Fix                              |
| -------------------------------------------- | -------------------------------- |
| Optional parameters that should be exclusive | Use discriminated union variants |
| Option bag with contradictory combinations   | Use variants that encode modes   |
| Boolean flags that control behavior          | Use explicit variants instead    |

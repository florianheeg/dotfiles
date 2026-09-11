---
name: write-better-typescript
description: Use when writing, reviewing, or refactoring TypeScript code; when handling external input from APIs, JSON, or third-party SDKs; when designing public APIs or utility functions; when improving compiler configuration or type-checking workflows.
---

# TypeScript Best Practices

Contains 35 rules across 7 categories, prioritized by impact from critical (external data boundaries) to incremental (advanced type programming).

## When to Apply

- Writing new TypeScript code
- Reviewing TypeScript pull requests
- Refactoring TypeScript code
- Designing public APIs, utility functions, or shared types
- Handling external input (API payloads, parsed JSON, storage, third-party callbacks)
- Improving compiler configuration or type-checking workflows

## Core Principles

### 1. External data is untrusted

TypeScript checks your code's assumptions—it does not verify that external data matches those assumptions at runtime. Treat all data from outside your code as untrusted until validated.

### 2. Model state to exclude impossible combinations

Prefer types that make invalid states unrepresentable. Discriminated unions encode real domain rules more effectively than optional fields and status booleans.

### 3. Make illegal states hard to express

Design APIs so incorrect calls are difficult to write. Push correctness into the type system rather than relying on runtime checks.

### 4. One source of truth

Derive types from runtime values when possible. This reduces drift between type definitions and actual behavior.

### 5. Contain unsafety

When unsafe typing is unavoidable, keep it small and isolated behind a typed boundary. Do not let `any` or unsafe casts spread through the codebase.

## Rule Categories by Priority

| Priority | Category                     | Impact      | Prefix      |
| -------- | ---------------------------- | ----------- | ----------- |
| 1        | External data boundaries     | HIGH        | `boundary-` |
| 2        | State and domain modeling    | HIGH        | `model-`    |
| 3        | Project configuration        | MEDIUM-HIGH | `config-`   |
| 4        | API and function design      | MEDIUM-HIGH | `api-`      |
| 5        | Type relationships and reuse | MEDIUM      | `type-`     |
| 6        | Unsafe escape hatches        | MEDIUM      | `assert-`   |
| 7        | Advanced type programming    | LOW-MEDIUM  | `advanced-` |

## Quick reference

### 1. External data boundaries (CRITICAL)

- `boundary-validate-input`: Treat external data as untrusted and validate it at the boundary
- `boundary-wrap-interop`: Wrap unsafe library and platform interop behind typed boundaries

### 2. State and domain modeling (HIGH)

- `model-impossible-state`: Model impossible states out of existence with discriminated unions
- `model-literal-union`: Prefer literal unions over broad `string` and `number`
- `model-derived-type`: Derive types from values instead of duplicating them
- `model-domain-type`: Use domain-specific types for important business concepts
- `model-optional-semantics`: Make optional, nullable, and omitted fields mean different things

### 3. Project configuration (MEDIUM-HIGH)

- `config-strict`: Enable `strict` mode
- `config-strict-checks`: Enable stricter safety checks beyond `strict`
- `config-typecheck`: Add a `typecheck` command that runs `tsc --noEmit`
- `config-consistency`: Keep compiler settings consistent across the repo
- `config-raise-bar`: Tighten compiler options over time, not loosen them

### 4. API and function design (MEDIUM-HIGH)

- `api-precise-signature`: Make function signatures reflect real input and output behavior
- `api-exhaustive-contracts`: Make invalid parameter combinations impossible with exhaustive contracts
- `api-required-input`: Require the fields a function actually needs
- `api-specific-result`: Return specific result types instead of vague objects
- `api-overloads-vs-unions`: Prefer discriminated unions over function overloads

### 5. Type relationships and reuse (MEDIUM)

- `type-safe-narrowing`: Narrow values before using them as more specific types
- `type-generic-relationship`: Use generics only when they model a real type relationship
- `type-constrained-generic`: Constrain generics when structure is assumed
- `type-derive-from-source`: Prefer deriving related types over manually repeating them
- `type-readable-abstraction`: Keep reusable type abstractions readable and justified
- `type-module-augmentation`: Use module augmentation to safely extend third-party types
- `type-declaration-merging`: Use declaration merging to extend types intentionally

### 6. Unsafe escape hatches (MEDIUM)

- `assert-avoid-any`: Avoid `any` except for deliberate, isolated escape hatches
- `assert-avoid-casts`: Avoid unsafe casts as the default fix
- `assert-use-const`: Use `as const` to preserve intended literal information
- `assert-isolate-unsafe`: Isolate unavoidable unsafe typing behind narrow boundaries
- `assert-satisfies-operator`: Use `satisfies` to validate literals without widening

### 7. Advanced type programming (LOW-MEDIUM)

- `advanced-builtins-first`: Prefer built-in utility types before custom type machinery
- `advanced-real-transform`: Use mapped and conditional types only for real structural transformations
- `advanced-no-puzzle`: Avoid type-level cleverness that hurts readability
- `advanced-name-complex`: Name complex type aliases clearly and split them when needed
- `advanced-infer-usage`: Use `infer` for real type extraction, not as a general tool
- `type-variance-annotations`: Understand and control type variance

## Common Mistakes

| Mistake                                                                  | Fix                                    |
| ------------------------------------------------------------------------ | -------------------------------------- |
| `const data: User = await response.json()`                               | Use `unknown` + validation at boundary |
| `function handle(data: any)`                                             | Use `unknown` + narrow or validate     |
| `type LoadState = { isLoading: boolean; error?: string; data?: User[] }` | Use discriminated union                |
| `function parse(value: string): any`                                     | Return specific type or `unknown`      |
| `const user = response as User`                                          | Use parser function with validation    |
| `function fetchReport(type: string, start?: string)`                     | Use discriminated union variants       |
| `function createJob({ schedule?, runNow? })`                             | Use typed variants for modes           |

## How to Use

Each rule lives in its own file under `references/rules/`, named by prefix (e.g. `references/rules/boundary-validate-input.md`). Read the specific rules relevant to the code at hand rather than loading everything.

Each rule file contains:

- The principle and why it matters
- A canonical incorrect/correct example
- A common-mistakes table

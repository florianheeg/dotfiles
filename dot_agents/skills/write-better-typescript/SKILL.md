---
name: write-better-typescript
description: Use when writing, reviewing, or refactoring TypeScript code; when handling external input from APIs, JSON, or third-party SDKs; when designing public APIs or utility functions; when improving compiler configuration or type-checking workflows.
---

# TypeScript Best Practices

Contains 40 rules across 8 categories, prioritized by impact from critical (external data boundaries) to incremental (advanced type programming).

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

| Priority | Category                     | Impact      | ID prefix |
| -------- | ---------------------------- | ----------- | --------- |
| 1        | External data boundaries     | HIGH        | `BND`     |
| 2        | State and domain modeling    | HIGH        | `MDL`     |
| 3        | Project configuration        | MEDIUM-HIGH | `CFG`     |
| 4        | Async correctness            | MEDIUM-HIGH | `ASY`     |
| 5        | API and function design      | MEDIUM-HIGH | `API`     |
| 6        | Type relationships and reuse | MEDIUM      | `TYP`     |
| 7        | Unsafe escape hatches        | MEDIUM      | `ASR`     |
| 8        | Advanced type programming    | LOW-MEDIUM  | `ADV`     |

## Quick reference

Each entry names the trigger situation, not the rule's content — open the linked file only once a trigger matches.

### 1. External data boundaries (CRITICAL)

- [`BND-01`](references/rules/BND-01-validate-input.md) — Data enters your code from outside it: an API response, `JSON.parse`, `localStorage`, an env var, a third-party callback payload.
- [`BND-02`](references/rules/BND-02-wrap-interop.md) — Integrating a third-party SDK, a DOM API, or another loosely-typed library whose objects would otherwise flow straight into application code.

### 2. State and domain modeling (HIGH)

- [`MDL-01`](references/rules/MDL-01-impossible-state.md) — Modeling a value that has several mutually exclusive states (loading/success/error, draft/published) instead of independent booleans and optionals.
- [`MDL-02`](references/rules/MDL-02-exhaustive-check.md) — Right after modeling a discriminated union, whenever you write a `switch`/branch that must handle every variant.
- [`MDL-03`](references/rules/MDL-03-literal-union.md) — A `string`/`number` field only ever takes one of a small, known set of values (roles, statuses, modes).
- [`MDL-04`](references/rules/MDL-04-avoid-enum.md) — About to declare a fixed set of named constants and reaching for `enum`.
- [`MDL-05`](references/rules/MDL-05-derived-type.md) — A type and a runtime value (allowed options, route table, config keys) describe the same set but are declared separately.
- [`MDL-06`](references/rules/MDL-06-domain-type.md) — Two different primitive values (two kinds of ID, dollars vs. cents) could be accidentally passed to each other's parameter slot.
- [`MDL-07`](references/rules/MDL-07-optional-semantics.md) — Designing an update/patch type where a field can be omitted, `null`, or a real value, and each has to mean something different.

### 3. Project configuration (MEDIUM-HIGH)

- [`CFG-01`](references/rules/CFG-01-strict.md) — Setting up a new project, or auditing a `tsconfig.json` that doesn't have `strict` on yet.
- [`CFG-02`](references/rules/CFG-02-strict-checks.md) — `strict` is already on and you want to close its remaining gaps (indexed lookups, `catch` variables, optional-property semantics).
- [`CFG-03`](references/rules/CFG-03-typecheck.md) — The repo has no dedicated way to run `tsc` on its own, separate from a build or bundler step.
- [`CFG-04`](references/rules/CFG-04-consistency.md) — A monorepo or multi-package repo has more than one `tsconfig.json` that could drift from a shared baseline.
- [`CFG-05`](references/rules/CFG-05-raise-bar.md) — Someone proposes disabling or loosening a compiler check to unblock a build or CI run.

### 4. Async correctness (MEDIUM-HIGH)

- [`ASY-01`](references/rules/ASY-01-handle-every-promise.md) — Calling something that returns a `Promise` and not immediately `await`ing, `return`ing, or explicitly discarding it.

### 5. API and function design (MEDIUM-HIGH)

- [`API-01`](references/rules/API-01-precise-signature.md) — Writing or reviewing a function signature: check that parameter and return types describe what actually happens, not a placeholder like `any`/`object`.
- [`API-02`](references/rules/API-02-exhaustive-contracts.md) — A function takes several optional parameters and some combinations of them together are invalid or meaningless.
- [`API-03`](references/rules/API-03-required-input.md) — A function only reads a few fields off a large object parameter, especially if that object type then gets reused unnecessarily.
- [`API-04`](references/rules/API-04-specific-result.md) — A function's return type mixes a success/failure flag with optional fields that are only meaningful in one branch.
- [`API-05`](references/rules/API-05-overloads-vs-unions.md) — About to add a second or third overload signature to a function, or the function already has more than one.

### 6. Type relationships and reuse (MEDIUM)

- [`TYP-01`](references/rules/TYP-01-safe-narrowing.md) — A value's static type is a union or `unknown` and you're about to access a member or call a method on it.
- [`TYP-02`](references/rules/TYP-02-generic-relationship.md) — Writing or reviewing a generic function/type: check that every type parameter actually relates two or more places in the signature.
- [`TYP-03`](references/rules/TYP-03-constrained-generic.md) — A generic function accesses a property or calls a method on its generic parameter.
- [`TYP-04`](references/rules/TYP-04-derive-from-source.md) — Defining a type that's a strict subset or variant of another type already declared nearby.
- [`TYP-05`](references/rules/TYP-05-readable-abstraction.md) — Introducing or reviewing a shared/reusable type helper meant to be used in more than one place.
- [`TYP-06`](references/rules/TYP-06-module-augmentation.md) — A third-party library's shipped types are missing a property or method you need to use.
- [`TYP-07`](references/rules/TYP-07-declaration-merging.md) — Intentionally extending an existing interface's shape from a different file or module (plugin systems, ambient type extension).
- [`TYP-08`](references/rules/TYP-08-prefer-readonly.md) — A function parameter, object property, or array is only ever read, never mutated, by the code that receives it.
- [`TYP-09`](references/rules/TYP-09-interface-vs-alias.md) — Declaring a new named object shape and deciding between `interface` and `type`.

### 7. Unsafe escape hatches (MEDIUM)

- [`ASR-01`](references/rules/ASR-01-avoid-any.md) — About to write `any` as a type annotation, parameter type, or return type.
- [`ASR-02`](references/rules/ASR-02-avoid-casts.md) — About to write `as SomeType` (or angle-bracket syntax) to force a value's type.
- [`ASR-03`](references/rules/ASR-03-use-const.md) — Declaring a literal array, object, or value whose exact literal shape — not just its widened type — needs to be preserved.
- [`ASR-04`](references/rules/ASR-04-isolate-unsafe.md) — Interop with an untyped or legacy dependency forces some unavoidable `any`/unsafe code into the codebase.
- [`ASR-05`](references/rules/ASR-05-satisfies-operator.md) — Validating that an object literal matches a type while still wanting to keep its narrower inferred/literal type.

### 8. Advanced type programming (LOW-MEDIUM)

- [`ADV-01`](references/rules/ADV-01-builtins-first.md) — Before writing a custom mapped or conditional type: check whether `Pick`, `Omit`, `Partial`, `Record`, etc. already do the job.
- [`ADV-02`](references/rules/ADV-02-real-transform.md) — Considering a mapped or conditional type: confirm there's a real, repeated structural transformation behind it, not a one-off need.
- [`ADV-03`](references/rules/ADV-03-no-puzzle.md) — Reviewing a type that needs a comment to explain how it works, or that nests several conditional/mapped types.
- [`ADV-04`](references/rules/ADV-04-name-complex.md) — A type alias has more than one generic parameter or does more than one thing.
- [`ADV-05`](references/rules/ADV-05-infer-usage.md) — Reaching for `infer` inside a conditional type.
- [`ADV-06`](references/rules/ADV-06-variance-annotations.md) — Defining a generic type or interface where callers might rely on subtyping in only the input or only the output position.

## Common Mistakes

| Mistake                                                                   | Fix                                                                | Rule                                                        |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------------------------------- |
| `const data: User = await response.json()`                                | Use `unknown` + validation at boundary                             | [`BND-01`](references/rules/BND-01-validate-input.md)       |
| `function handle(data: any)`                                              | Use `unknown` + narrow or validate                                 | [`ASR-01`](references/rules/ASR-01-avoid-any.md)            |
| `type LoadState = { isLoading: boolean; error?: string; data?: User[] }`  | Use discriminated union                                            | [`MDL-01`](references/rules/MDL-01-impossible-state.md)     |
| `function parse(value: string): any`                                      | Return specific type or `unknown`                                  | [`API-01`](references/rules/API-01-precise-signature.md)    |
| `const user = response as User`                                           | Use parser function with validation                                | [`ASR-02`](references/rules/ASR-02-avoid-casts.md)          |
| `function fetchReport(type: string, start?: string)`                      | Use discriminated union variants                                   | [`API-02`](references/rules/API-02-exhaustive-contracts.md) |
| `function createJob({ schedule?, runNow? })`                              | Use typed variants for modes                                       | [`API-02`](references/rules/API-02-exhaustive-contracts.md) |
| `saveUser(user);` (no `await`/`return`)                                   | Await, return, or explicitly `void` the Promise                    | [`ASY-01`](references/rules/ASY-01-handle-every-promise.md) |
| `if (state.kind === 'a') {} if (state.kind === 'b') {} return 'unknown';` | `switch` with a `default: assertNever(state)`                      | [`MDL-02`](references/rules/MDL-02-exhaustive-check.md)     |
| `enum Role { Admin, Editor, Viewer }`                                     | `const ROLES = [...] as const; type Role = (typeof ROLES)[number]` | [`MDL-04`](references/rules/MDL-04-avoid-enum.md)           |
| `function printAll(items: string[])` that never mutates `items`           | `function printAll(items: readonly string[])`                      | [`TYP-08`](references/rules/TYP-08-prefer-readonly.md)      |

## How to Use

Each rule lives in its own file under `references/rules/`, named by its ID (e.g. `references/rules/BND-01-validate-input.md`). Each rule's frontmatter `key` is its ID (e.g. `BND-01`) — cite rules by this ID. Read the specific rules relevant to the code at hand rather than loading everything.

Each rule file contains:

- A "When to apply" line — the same trigger sentence used in the quick reference above, restated so the file is self-contained if reached directly
- The principle and why it matters
- A canonical incorrect/correct example
- Where mechanically enforceable, a "Mechanical enforcement" section with the exact tsconfig flag or lint rule to add, plus what it covers and what still needs manual review for partially-enforceable rules (omitted entirely when the rule is a design judgment no linter can check)
- A common-mistakes table

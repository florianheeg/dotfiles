---
key: MDL-02
category: State and domain modeling
title: model-exhaustive-check
description: Make discriminated union handling exhaustive so new variants fail to compile
impact: MEDIUM-HIGH
impactDescription: Turns an unhandled new state into a compile error instead of a silent runtime gap.
---

## MDL-02: Make discriminated union handling exhaustive so new variants fail to compile

**When to apply:** Right after modeling a discriminated union, whenever you write a `switch`/branch that must handle every variant.

Once a value is modeled as a discriminated union, switch on the discriminant and assert exhaustiveness in the `default` case so adding a new variant breaks the build until every switch handles it.

**Why:** A discriminated union only prevents invalid states. Without an exhaustiveness check, nothing stops a new variant from silently falling through every `switch`/`if` chain that handles the old ones.

**Incorrect:**

```ts
function describe(state: LoadState): string {
  if (state.kind === 'idle') return 'Idle';
  if (state.kind === 'loading') return 'Loading';
  if (state.kind === 'success') return `Loaded ${state.data.length} items`;
  return 'Unknown';
  // Adding a `kind: 'error'` variant compiles fine and silently returns "Unknown"
}
```

**Correct:**

```ts
function assertNever(value: never): never {
  throw new Error(`Unhandled case: ${JSON.stringify(value)}`);
}

function describe(state: LoadState): string {
  switch (state.kind) {
    case 'idle':
      return 'Idle';
    case 'loading':
      return 'Loading';
    case 'success':
      return `Loaded ${state.data.length} items`;
    case 'error':
      return `Error: ${state.message}`;
    default:
      return assertNever(state);
    // Adding a new `kind` now fails to compile here until this switch handles it
  }
}
```

### Mechanical enforcement

Add `@typescript-eslint/switch-exhaustiveness-check` (type-aware) to your lint rules — it flags a `switch` over a union that's missing a case, without needing the manual `assertNever` helper.

**Covers:** any `switch` statement over the union's discriminant that's missing a case; independent of the lint rule, the compiler itself also rejects a missing case when you use the `default: assertNever(state)` pattern.

**Still manual:** an `if`/`else if` chain gets none of this protection — you have to actually write it as a `switch` for either safeguard to apply.

### Common mistakes

| Mistake                                                        | Fix                                                                     |
| -------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `if`/`else if` chain with a final catch-all return             | `switch` on the discriminant with a `never` default                     |
| `default` case that returns a fallback value                   | `default` case that calls an `assertNever(value)` helper                |
| Relying on code review to catch missed variants                | Let the compiler catch it via exhaustiveness                            |
| Adding a union variant without searching for existing switches | Add the variant, then let the compiler point at every incomplete switch |

---
key: ASY-01
category: Async correctness
title: async-handle-every-promise
description: Treat every Promise as a value that must be awaited, returned, or discarded on purpose
impact: MEDIUM-HIGH
impactDescription: Prevents unhandled rejections, lost errors, and Promises misused where synchronous values are expected.
---

## ASY-01: Treat every Promise as a value that must be awaited, returned, or discarded on purpose

**When to apply:** Calling something that returns a `Promise` and not immediately `await`ing, `return`ing, or explicitly discarding it.

A `Promise`-returning expression is never "fire and forget" by accident. Either `await` it, `return` it, or explicitly discard it — never leave it as a bare statement.

**Why:** A Promise left floating still runs, but nothing observes its rejection. Errors disappear silently, and operations that should happen in order can interleave instead.

**Incorrect:**

```ts
function saveAndNotify(user: User) {
  saveUser(user); // floating: rejection is never observed
  notify(user.email);
}
```

```ts
if (isReady()) {
  // async check misused where a boolean is required
}

button.addEventListener('click', async () => {
  await submit(); // handler runs detached; caller can't await or catch it
});
```

**Correct:**

```ts
async function saveAndNotify(user: User) {
  await saveUser(user);
  notify(user.email);
}
```

```ts
button.addEventListener('click', () => {
  void submit().catch(reportError);
});
```

### When `void` is the right call

Use `void somePromise()` only when the rejection is deliberately handled elsewhere (a global handler, or a `.catch()` chained before the `void`). `void` documents "I chose not to await this," not "I forgot to."

### Mechanical enforcement

Add `@typescript-eslint/no-floating-promises` and `no-misused-promises` (both type-aware) to your lint rules.

**Covers:** a Promise-valued expression left as a bare statement, or passed into a position (a condition, a non-async callback slot) that can't handle it.

**Still manual:** whether the code that does `await`/`.catch()` it actually reacts correctly to a rejection — the lint rule proves something handles it, not that the handling is correct.

### Common mistakes

| Mistake                                                                                              | Fix                                                                      |
| ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| Calling an async function without `await`/`return`                                                   | Await it, return it, or `void` it deliberately                           |
| Passing an async function to a sync callback slot (`Array.forEach`, event handlers expecting `void`) | Use a `for...of` with `await`, or explicitly handle the detached Promise |
| Using a Promise directly in a condition (`if (promise)`)                                             | Await it first, then check the resolved value                            |
| Swallowing rejections by omitting `.catch`/`try` around a floating call                              | Attach `.catch()` or wrap in `try`/`catch` with `await`                  |

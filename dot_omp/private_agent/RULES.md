## Engineering

* Follow existing patterns before introducing new abstractions.
* Prefer the smallest change that satisfies the requirement.
* Preserve public contracts unless explicitly changing them.
* Distinguish facts from assumptions; surface uncertainty instead of guessing.
* Do not silently change requirements to fit an implementation.

## Tests

* Prefer behavioral tests over implementation-detail tests.
* Never weaken tests just to make a change pass.
* Add regression tests for bugs when practical.
* Run the narrowest meaningful verification before claiming completion.

## Delegation

* Use `scout` for broad repository discovery: files, callers, tests, fixtures, and patterns.
* Keep judgment, architecture, and correctness decisions with the primary model.

## Git

* Never perform destructive Git operations without explicit approval.
* Prefer concise, imperative, subject-only commit messages.
* Add a body only for non-obvious rationale, constraints, tradeoffs, or consequences.
* Do not restate the diff or list changed files/tests.

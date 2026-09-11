# Engineering rules

- Investigate existing patterns before introducing new abstractions.
- Prefer the smallest change that satisfies the requirement.
- Preserve existing public contracts unless the task explicitly changes them.
- Prefer behavioral tests over tests of implementation details.
- Do not weaken or delete tests merely to make a change pass.
- When fixing a bug, add a regression test when practical.
- Run the narrowest meaningful verification before claiming completion.
- Distinguish verified facts from assumptions.
- Surface uncertainty instead of guessing.
- Do not silently change requirements to fit an implementation.
- Do not perform destructive Git operations without explicit approval.

## Git commits

- Prefer concise subject-only commit messages.
- Use imperative mood.
- Do not summarize the diff in the commit body.
- Add a body only when it preserves non-obvious rationale, constraints, tradeoffs, or important behavioral consequences.
- If the subject fully explains the change, omit the body.
- Never include implementation inventories such as lists of files changed or tests added.

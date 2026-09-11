---
description: Audit test quality for the current change
---

Use the test-reviewer agent to independently audit the tests affected by the current branch.

Compare the production diff with:
- tests added or changed on this branch
- existing tests covering the affected behavior

For each changed behavior, identify what test provides evidence for it and the strength of that evidence.

Then identify realistic bugs in the changed production code that could still survive while all tests remain green.

Focus particularly on:
- weak or tautological assertions
- excessive mocking
- implementation-detail testing
- missing boundaries and failure paths
- untested invariants
- tests that would survive meaningful mutations

Do not modify anything.

Return the highest-value findings first.

---
description: Independently review the current change
---

Use the change-reviewer agent to independently review the current branch against its intended behavior.

Review the production diff, relevant repository context, tests, and any available requirements.

Do not trust implementation summaries as evidence.

Focus on:
- correctness
- regressions
- architectural fit
- error and failure paths
- accidental contract changes
- unnecessary complexity
- acceptance criteria without convincing evidence

Do not modify anything.

Return findings ordered by severity, followed by verification performed and overall confidence.

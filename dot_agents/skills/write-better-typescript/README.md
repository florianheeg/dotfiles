# write-better-typescript

Author: Florian Heeg <florian.heeg@accenture.com>

TypeScript best-practices skill: 35 rules across 7 priority categories, from external-data boundaries (validate untrusted input) through state modeling, compiler configuration, API design, type reuse, unsafe escape hatches, and advanced type programming.

Triggers when writing, reviewing, or refactoring TypeScript; handling external input from APIs, JSON, or third-party SDKs; designing public APIs or utility functions; or improving compiler configuration and type-checking workflows.

## Files

- `SKILL.md` — lean router: core principles, the priority table, and a one-line index of all 35 rules.
- `references/rules/*.md` — one self-contained file per rule (principle, why it matters, a canonical incorrect/correct example, common-mistakes table). Read only the rules relevant to the code at hand.

The skill is self-contained: it carries no runtime dependencies and requires no network access or outside sources at invocation time.

## Recommended model baseline

Assumes a model with strong instruction-following and code reasoning (mid-tier frontier and up). The rules are written as principles the model applies to unseen code, not as mechanical step-by-step scripts. The advanced type-level rules (`advanced-*`, `type-variance-annotations`) degrade most on small or edge models. This is an advisory baseline, not an enforced requirement.

## Influences

The guidance draws on established TypeScript sources — Dan Vanderkam's _Effective TypeScript_ (2nd ed.), the official TypeScript Handbook, and the typescript-eslint rule set — but bakes the resulting judgment in locally rather than linking out. Rule files intentionally carry no external citations, keeping the skill hermetic and free of outbound fetch prompts.

## Installation

```bash
sto skill add write-better-typescript
```

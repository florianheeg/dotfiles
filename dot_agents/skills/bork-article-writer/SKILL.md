---
name: bork-article-writer
description: Draft and submit a BORK knowledge base article from a gap entry produced by the bork-gap-detection skill, or from a topic the user describes directly. Use when asked to "write a BORK article", "document this in BORK", or when handed a gap report and told to create the article. Works from any session — no local clone needed.
---

Draft a BORK knowledge base article and submit it as a GitHub PR. Falls back to printing the article if GitHub access fails.

**BORK repo:** `ASG-SONG/315783_STO_0100-BORK`  
**Wiki path inside repo:** `packages/wiki/wiki/`

## Inputs

Accept either:
- A single gap entry from a `bork-gap-detection` report (JSON), or
- A topic/question described directly by the user.

If the input is a gap entry, use `question_asked`, `suggested_title`, and `context_snippet` as your starting point.

## Step 1 — Choose folder and type

Read the existing folder structure from the repo:

```sh
gh api repos/ASG-SONG/315783_STO_0100-BORK/contents/packages/wiki/wiki \
  --jq '.[].name'
```

Pick the most appropriate existing folder. If the topic doesn't fit and more articles in this area are likely, create a new folder. Say which folder you chose and why.

**Type** — pick the type that matches the article's purpose:
- `howto` — step-by-step guide for a tool or technique
- `framework` — methodology or decision criteria
- `process` — concrete workflow with steps or approvals
- `policy` — recommended practice with rationale

If none fit, pick the closest and note the mismatch for the reviewer.

## Step 2 — Draft the article

File path in repo: `packages/wiki/wiki/{folder}/{kebab-case-title}.md`

Frontmatter:

```yaml
---
type: <type>
title: <title>
description: <one sentence, concrete and specific>
tags: [tool names, subject areas — not the folder or type]
generated:
  by: "ai:claude"
  at: <current ISO timestamp>
sources:
  - resource: <URL if used, otherwise omit this field>
verified:
  by: ""
  at: ""
---
```

Body rules:
- H1 must match `title` exactly
- Descriptive H2 headings — they become searchable sections in BORK
- Relative links: `[text](../folder/file.md)` or `[text](file.md)` for same-folder
- Explain the *why* behind recommendations, not just the what

## Step 3 — Submit via GitHub (preferred)

Check `gh` is available and authenticated:

```sh
gh auth status
```

If this fails, skip to the **Fallback** section.

**Create a branch:**

```sh
gh api repos/ASG-SONG/315783_STO_0100-BORK/git/refs/heads/main \
  --jq '.object.sha'
# Use the returned SHA to create a branch:
gh api repos/ASG-SONG/315783_STO_0100-BORK/git/refs \
  --method POST \
  --field ref="refs/heads/bork-article/{kebab-case-title}" \
  --field sha="<sha>"
```

**Commit the article file:**

```sh
gh api repos/ASG-SONG/315783_STO_0100-BORK/contents/packages/wiki/wiki/{folder}/{filename}.md \
  --method PUT \
  --field message="docs: add article on {title}" \
  --field content="<base64-encoded article content>" \
  --field branch="bork-article/{kebab-case-title}"
```

**Update index.md** — fetch current content and SHA, append the new entry, commit:

```sh
gh api repos/ASG-SONG/315783_STO_0100-BORK/contents/packages/wiki/wiki/index.md \
  --jq '{sha: .sha, content: .content}'
# Decode, add entry, re-encode, then PUT with the sha field to satisfy GitHub's conflict check
```

**Update log.md** — same pattern: fetch, prepend the new log entry, commit.

**Open the PR:**

```sh
gh pr create \
  --repo ASG-SONG/315783_STO_0100-BORK \
  --head "bork-article/{kebab-case-title}" \
  --base main \
  --title "docs: {title}" \
  --body "$(cat <<'EOF'
AI-generated article from a detected knowledge gap.

**Topic:** {topic}
**Original question:** {question_asked}

## Review checklist
- [ ] Content is accurate
- [ ] `verified.by` and `verified.at` filled in after review
- [ ] CI linting passes
EOF
)"
```

Tell the user the PR URL and that they need to verify the content and fill in the `verified` fields before merging.

## Fallback — gh unavailable or failing

If any `gh` step fails, print the full article content and instructions:

```
Could not submit to GitHub automatically. Here's the article — create a PR manually:

Repo: https://github.com/ASG-SONG/315783_STO_0100-BORK
File path: packages/wiki/wiki/{folder}/{filename}.md

--- ARTICLE START ---
<full article markdown>
--- ARTICLE END ---

Also add to packages/wiki/wiki/index.md:
- [Title](folder/filename.md) - One-line description.

And prepend to packages/wiki/wiki/log.md:
## YYYY-MM-DD
- **Create**: Added [Title](folder/filename.md), covering <main topics>.

Run before committing:
  pnpm lint:okf
  pnpm lint:content
```

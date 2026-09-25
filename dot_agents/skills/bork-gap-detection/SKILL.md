---
name: bork-gap-detection
description: Use this skill at the end of an AI conversation to detect knowledge gaps — questions that were answered from general knowledge rather than the BORK knowledge base. Invoke when wrapping up a session, when the user asks "did we cover anything new?", or proactively after a long Q&A conversation about internal tooling, AI skills, or development processes. Outputs a structured gap report for the bork-article-writer skill to consume.
---

Analyze the conversation to surface questions that should become BORK knowledge base articles but don't exist yet.

## Steps

1. **Scan the conversation** for questions the user asked or implied — including follow-ups, clarifications, and topics where the AI gave a long answer that suggests missing documentation.

2. **For each candidate question**, extract 2–3 keyword variants (synonyms, alternate phrasings) so the search covers the concept, not just the exact wording.

3. **Check BORK** using the `audi-pods-wiki` MCP tool with each keyword variant. A question is a gap only if no sufficiently relevant article is found — a partial match that covers the topic well enough is not a gap.

4. **Filter out noise**: skip questions that are too specific to the current session (e.g. "what did you mean by X?"), conversational ("can you clarify?"), or already well-covered by a close BORK match.

5. **Output the gap report** (see format below).

## Graceful degradation

If the `audi-pods-wiki` MCP tool is unavailable, still produce the report — set `"bork_checked": false` on each gap and add a note that results weren't verified against BORK. A human reviewer should verify before creating articles.

## Output format

```json
{
  "gaps": [
    {
      "topic": "short topic label",
      "question_asked": "the question as asked or implied in the conversation",
      "suggested_title": "proposed BORK article title",
      "context_snippet": "1-2 sentences of context from the conversation that motivated this question",
      "keywords_searched": ["keyword1", "keyword2", "keyword3"],
      "bork_checked": true,
      "similar_articles": [],
      "search_method": "keyword"
    }
  ],
  "summary": "1-2 sentence summary of the gaps found and any patterns"
}
```

**Field notes:**
- `search_method`: how BORK was queried. `"keyword"` means exact/keyword match (current default); `"semantic"` means vector/similarity search (use when the MCP server supports it). Include this so gap detection quality can be compared as the MCP evolves.
- `similar_articles`: list of BORK article titles/IDs that were close but not sufficient — useful context for the article writer and for human reviewers.

If no gaps are found, return `"gaps": []` with a brief `summary` explaining why (e.g. all questions were already covered in BORK).

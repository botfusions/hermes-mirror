# Cross-Agent Research Synthesis Pattern

Use this when one research agent should consume another agent's already-filtered wiki outputs instead of repeating searches or scraping X directly.

## Pattern

- Treat the upstream agent as a bounded signal producer, not as raw data storage.
- Read only recent, relevant Markdown reports from the upstream wiki; keep the file count capped to control context size and cost.
- Generate a new synthesis report into the downstream agent's `Inbox` so the existing autoresearch/archive/comparison flow remains unchanged.
- Run the producer and then the downstream autoresearch consumer to verify the full pipeline, not just script syntax.

## Recommended synthesis shape

```markdown
# [Downstream] x [Upstream] Sentez Raporu

## Yönetici Özeti
1. [High-signal takeaway]
2. [High-signal takeaway]
3. [High-signal takeaway]

## Bulgu N: [Title]
**Kaynak:** [source file and/or URL]
**Botfusions İçin Fırsat:** [specific opportunity]
**Risk:** [realistic risk]
**Net Aksiyon:** [concrete next step]
**Öncelik:** P0 | P1 | P2
```

## Pitfalls

- Do not dump upstream reports raw into the downstream wiki; synthesize and deduplicate.
- Do not let similar tweets become separate repeated findings; group them into one finding with multiple source links.
- Do not stop after creating an Inbox file; verify that the downstream autoresearch job archives it into `Reports` and creates/updates the comparison ledger.

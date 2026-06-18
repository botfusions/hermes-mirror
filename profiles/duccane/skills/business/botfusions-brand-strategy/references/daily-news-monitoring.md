# Botfusions Daily News Monitoring

Use this reference for recurring/scheduled Botfusions news scans focused on business value, not broad AI news.

## Scope

Prioritize:

- AI agents and agentic automation
- GEO / Generative Engine Optimization
- AI search and AI referral measurement
- AI-ready web architecture
- schema markup / structured data
- programmatic SEO with real user value

Exclude:

- generic LLM benchmark or model gossip
- crypto/finance/viral social topics
- items weakly connected to Botfusions services

## Source strategy

- Use at most 8 quality sources per report.
- Prefer primary sources: Google Search Central, Microsoft/OpenAI/Anthropic official blogs, reputable enterprise AI/search publications, and credible research reports.
- If a source page is hard to extract, use RSS/search snippets only when the snippet is enough to avoid speculation; clearly keep claims narrow.
- Deduplicate similar items and choose the one with the strongest Botfusions implication.

## Scheduled-job flow

1. Check local time before producing output.
2. If the job is in quiet hours and the instruction says to suppress, return exactly `[SILENT]` unless the job explicitly requires saving-only behavior.
3. If the job runner says a requested skill is missing, start the final report with: `⚠️ Skill(s) not found and skipped: <skill>`.
4. Collect candidates, filter to maximum 6 items, and write in Turkish.
5. Save to the requested wiki path, usually:
   `/Users/cenktk/Desktop/Hermes_Agent /Hakan Wiki/Haberler/YYYY-MM-DD/Haber_Raporu.md`
6. Verify the saved Markdown before final response.

## Report format

```markdown
## Özet
[2-3 cümle]

## Haberler
### 1. [Başlık]
- Ne oldu: [kısa]
- Neden önemli: [Botfusions bağlantısı]
- Kaynak: [link]

## Botfusions İçin Öneri
- [En fazla 3 aksiyon önerisi]
```

## Botfusions implication pattern

Translate each news item into one of these practical angles:

- GEO measurement: AI visibility reports, AI referrals, citation tracking, attribution.
- Trust layer: source transparency, author/entity credibility, human-readable proof.
- Agent governance: permissions, logs, approvals, replay, lifecycle management.
- Workflow automation: existing tools/CRMs/ERPs, visual workflow design, durable agent workspaces.
- AI-ready web: structured data, crawlability, entity clarity, machine-readable content.

## Pitfalls

- Do not produce a generic AI newsletter; every item needs a direct Botfusions business connection.
- Do not exceed the requested item/source caps.
- Do not invent facts when only snippets are available; state only what the source supports.
- Do not save transient daily headlines as durable memory; keep daily reports in the wiki.

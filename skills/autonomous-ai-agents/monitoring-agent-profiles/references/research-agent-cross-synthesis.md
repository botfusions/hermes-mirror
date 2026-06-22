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

## Source Size and Cron Timeout

The Hermes cron default timeout is 120s for `no_agent` script jobs. When a synthesis script collects upstream Markdown and sends it to an LLM provider (ZAI GLM, DeepSeek, etc.), large source bundles cause timeouts. Verified failure: 6 files × 6000 chars = ~30K source → GLM-4.7 exceeded 120s intermittently (succeeded once, timed out the next day).

**Fix: cap total source to ~12K chars.** A good working budget is 4 files × 3000 chars or 3 files × 4000 chars. This keeps ZAI GLM-4.7 reliably under 120s with a full structured-synthesis prompt.

Also reduce the max-findings count in the prompt (e.g., from 7 to 5) to shorten generation time.

## Prompt Template for Strict Output Format

Some models (observed with DeepSeek) abbreviate output and skip the required report structure when given a loose instruction like "use this title and metadata." To force full structured output, embed an **inline template skeleton** in the prompt:

```
ÖNEMLİ: Aşağıdaki yapıyı birebir takip et, atlama veya özet yapma. Tam rapor yaz:

# [Report Title]

**Üretim zamanı:** [timestamp]
**Model:** [model name]
**Kaynak:** [source description]

---

## Yönetici Özeti
1. [bulgu]
2. [bulgu]
3. [bulgu]

---

## Bulgular
### 1. [Title]
**Ne oldu:** ...
**Botfusions İçin Fırsat:** ...
**Risk:** ...
**Net Aksiyon:** ...
**Öncelik:** P0/P1/P2
```

The inline skeleton produces ~8K-byte reports consistently; a loose prompt produced 1K-byte summaries.

## Pitfalls

- Do not dump upstream reports raw into the downstream wiki; synthesize and deduplicate.
- Do not let similar tweets become separate repeated findings; group them into one finding with multiple source links.
- Do not stop after creating an Inbox file; verify that the downstream autoresearch job archives it into `Reports` and creates/updates the comparison ledger.
- **Cron timeout from oversized LLM input** — cap source material to ~12K chars total. 6 files × 6000 chars caused intermittent 120s timeouts with GLM-4.7. See "Source Size and Cron Timeout" above.
- **Defensive timeout on `hermes -z` calls** — even with capped sources, wrap the synchronous `hermes -z` call in `timeout 100` so the script exits cleanly before the cron scheduler's 120s kill. Pattern: `if ! timeout 100 hermes -z "$PROMPT" --provider zai -m glm-4.7 > "$TMP" 2>&1; then echo "timeout"; exit 1; fi`. This prevents the script from being killed mid-write, which can leave empty or truncated output files.

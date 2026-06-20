# Botfusions LinkedIn Content Factory

## Context

Use this reference when Botfusions needs recurring Turkish LinkedIn draft packages from Düccane or another content agent. The workflow is draft-only by default: it prepares material for Cenk's manual review and publishing, not account automation.

## Daily Package Shape

Each run should produce:

1. One 500-700 word Turkish article/blog draft.
2. Three LinkedIn post drafts, each with one clear idea.
3. One short email draft with subject line.
4. Visual ideas for the posts.
5. A publishing note naming the strongest post and any manual checks.

## Content Rules

- Target LinkedIn, not X: professional, decision-maker friendly, slightly more context than short-form social.
- Anchor every package in a Botfusions pillar: GEO, AI-ready web, agentic AI, digital workers, schema markup, AI visibility, or measurement.
- Apply Hook → use case → result/fayda → natural CTA.
- Use Turkish human-tone polishing; avoid AI clichés such as “Günümüzde”, “Özetle”, and “Sonuç olarak”.
- Do not invent metrics, case studies, customer names, quotes, or sources.

## Automation Boundary

- Allowed: generate drafts, save Markdown, deliver the draft to Cenk.
- Not allowed by default: LinkedIn scraping, login/session automation, automatic posting, connection requests, likes, comments, DMs, or account actions.
- Publishing requires fresh explicit approval from Cenk naming the target platform/action, or manual publishing by Cenk.

## Scheduling Pattern

For a one-week test, a safe pattern is:

- Run one manual generation first.
- Schedule the remaining six runs as a script-only/no-agent cron that calls the intended content profile directly.
- Avoid crowded cron windows; offset by 15-30 minutes when many jobs already run at the same time.
- Save outputs under a wiki folder with a README explaining scope, model/profile, script, schedule, and publishing boundary.

## Output Template

```text
# Botfusions LinkedIn İçerik Paketi — YYYY-MM-DD

## Tema
...

## Makale Taslağı
Başlık: ...
...

## LinkedIn Post 1
...

## LinkedIn Post 2
...

## LinkedIn Post 3
...

## E-posta Taslağı
Konu: ...
...

## Görsel Fikirleri
- Post 1: ...
- Post 2: ...
- Post 3: ...

## Yayın Notu
- En güçlü post: ...
- Manuel kontrol: ...
```

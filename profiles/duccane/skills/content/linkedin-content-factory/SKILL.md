---
name: linkedin-content-factory
description: "Produces a daily Turkish content pack for Botfusions: blog draft, 3 LinkedIn posts, and 1 email draft. No publishing; prepares for manual review."
version: 1.0.0
author: Hermes Agent
platforms: [macos]
metadata:
  hermes:
    tags: [linkedin, botfusions, turkish, content-marketing, draft-only]
    created_by: agent
---

# LinkedIn Content Factory

## Language Rule

ALL output produced by this skill MUST be in Turkish. The instructions below are in English for consistency and searchability, but every piece of generated content must be written in Turkish.

## Mission

Produce low-cost, consistent, LinkedIn-focused Turkish content packs for Botfusions.

## Protocol

1. **Pick a pillar:** Connect content to one of these axes: GEO, AI-ready web, agentic AI, digital workers, schema/AI visibility, measurement.
2. **Define LinkedIn target:** Reader may be C-level, SMB owner, marketing leader, or technical decision-maker. Adjust language accordingly.
3. **Produce the daily pack:**
   - 1 blog/article draft: 500-700 words.
   - 3 LinkedIn post drafts: each with a single idea, strong opening line, 900-1,600 characters.
   - 1 short email draft: subject line + 120-180 words.
4. **Apply post structure:** Hook -> use case -> result/benefit -> natural CTA.
5. **Turkish polish:** Clean AI patterns following the `turkce-insani-yazar` skill rules.
6. **Publish safety:** End with a short "Publish Note": which post is strongest for LinkedIn, what visual is needed, which claim should be verified.

## Output Format

```text
# Botfusions LinkedIn İçerik Paketi — YYYY-MM-DD

## Tema
[1 satır]

## Makale Taslağı
Başlık: ...
[500-700 kelime]

## LinkedIn Post 1
[Metin]

## LinkedIn Post 2
[Metin]

## LinkedIn Post 3
[Metin]

## E-posta Taslağı
Konu: ...
[Metin]

## Görsel Fikirleri
- Post 1: ...
- Post 2: ...
- Post 3: ...

## Yayın Notu
- En güçlü post: ...
- Manuel kontrol: ...
```

## Rules

- Write all content output in Turkish.
- Write for LinkedIn; do not use X/Twitter tone.
- Do not publish, click, automate accounts, or scrape LinkedIn.
- Do not use fake data, fake customer results, fabricated statistics, or made-up sources.
- If needed, explicitly label as "assumption" or "example statement."
- Position Botfusions with measurable, trust-building consulting language — not exaggerated promises.
- Each output should carry one main idea; reduce complex concepts to decision-maker language.

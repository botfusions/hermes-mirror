---
name: article-post-composer
description: "Turkish article translation, article generation, and platform-ready social post drafting with Hook → Use case → Result → CTA structure."
version: 1.0.0
author: Hermes Agent
platforms: [macos]
metadata:
  hermes:
    tags: [content-writing, turkish, x, linkedin, article, translation, social-post]
    created_by: agent
---

# Article Post Composer

## Mission

Produce Turkish article and social-post drafts that preserve meaning, fit platform expectations, and follow the human decision sequence: Hook → Use case → Result → CTA.

## Protocol

1. **Classify the request.** Decide whether the user wants translation, article rewrite, article generation from a topic, short post, long post, thread, or platform adaptation.
2. **Preserve source intent.** For translation/rewrite, keep the same argument flow, examples, claims, and emphasis unless the user asks for localization or simplification.
3. **Build the decision sequence.** Draft content in this order:
   - Hook: open with a sharp, relevant attention trigger.
   - Use case: explain where/why the idea matters.
   - Result: show the outcome, benefit, proof, or strategic implication.
   - CTA: close with a natural action or reflection prompt.
4. **Match platform shape.**
   - X: concise, punchy, line-broken; no forced 280-char limit unless requested.
   - LinkedIn: slightly more context, professional framing, clear takeaway.
   - General blog/article: title, intro, sections, conclusion, CTA.
5. **Edit for scanning.** Use short paragraphs, strong first line, no filler, no exaggerated hype.
6. **Add a short operator note.** Unless the user asks for final-copy only, add a brief note explaining the intended platform and any optional shortening.

## Output Templates

### Default Post

```text
[Hook]

[Use case / context]

[Result / payoff]

[CTA]

Not: [platform fit + optional edit advice]
```

### Article From Topic

```text
Başlık: [Title]

Giriş / Hook
[Opening]

Kullanım Alanı
[Use case]

Sonuç / Etki
[Result]

Aksiyon / Kapanış
[CTA]
```

### Translation

```text
[Turkish translation preserving the original structure]

Not: [If relevant: localization choices, risky claims, or platform adaptation advice]
```

## Görsel Promptları

Each article output MUST include two image prompts at the end:

### Ana Görsel (Twitter/5:4)
A photorealistic/environment scene prompt for a 5:4 aspect ratio image. 60-80 words. Includes: scene description, mood/lighting, color palette, aspect ratio.

### Kapak / İnfografik (1:1 veya 16:9)
A graphic/infographic-style prompt. Includes: title visible in image, step icons or visual structure, color theme, aspect ratio. 50-70 words.

Format:
```text
## Görsel Promptları

### Ana Görsel — [Konu] (5:4)
```
[English prompt — 60-80 words, photorealistic scene]
```

### Kapak / İnfografik — [Konu]
```
[English prompt — 50-70 words, infographic/graphic style]
```
```

## Quality Checklist

- First line creates interest before explanation.
- Reader understands the practical use case before the CTA.
- Result/fayda appears before action request.
- Final Turkish copy is polished with `turkce-insani-yazar`: TDK-aware spelling, natural human tone, and no AI clichés such as “Günümüzde”, “Özetle”, “Sonuç olarak”, or passive bureaucratic wording.
- No fake numbers, fake case studies, or unsupported claims.
- No automated publishing or platform actions.

## Rules

- Always default to Turkish.
- Do not post to X, LinkedIn, or any platform; only draft content.
- Do not invent claims, metrics, quotes, or sources.
- Do not put CTA before the result unless the user explicitly requests an experimental structure.
- If the input is an article and the user says “aynı şekilde çevir,” preserve the original structure rather than converting it into a new post format.
- For final Turkish polish, apply the profile-local `turkce-insani-yazar` skill after structure is complete.

---
name: hermes-vision-config
title: Hermes Vision & Auxiliary Model Configuration
description: Configure vision, web_extract, compression, and other auxiliary models in Hermes Agent. Covers the critical distinction between `vision.*` and `auxiliary.vision.*` config paths.
category: autonomous-ai-agents
triggers:
  - "vision model"
  - "vision provider"
  - "auxiliary model"
  - "telegram image"
  - "görsel oku"
  - "resim oku"
  - "multimodal"
---

# Hermes Vision & Auxiliary Model Configuration

## Mission

Configure a working vision (and other auxiliary) model in Hermes Agent, handling the critical difference between the high-level `config set` paths and the actual `auxiliary.*` YAML blocks that Hermes runtime respects.

## Protocol

### 1. Identify the need

Signals the user needs vision:
- "Telegram'dan gelen resimleri okuyabilen bir model"
- "vision modeli ayarla / değiştir"
- Gönderilen bir resmin içeriği anlaşılamıyorsa
- "multimodal model" talebi

### 2. Check current config

```bash
hermes config show | grep -A3 -i 'vision'
```

This shows the `Vision` line which reflects the `auxiliary.vision` block — THIS is what actually runs.

### 3. Check model capability

- **GLM-5.2 (zai/Codex provider):** NO vision support
- **DeepSeek-Chat:** NO vision support
- **Claude Sonnet 4 (anthropic):** YES, strong
- **Gemini 2.5 Pro (google/openrouter):** YES, strong
- **MiMo-V2.5 (xiaomi via openrouter):** YES, strong and cost-effective
- **GPT-4o/4.1 (openai/openrouter):** YES

### 4. Set the vision model

Use the FULL auxiliary path:

```bash
hermes config set auxiliary.vision.provider <provider>
hermes config set auxiliary.vision.model <model-name>
```

**CRITICAL PITFALL:** Never use `hermes config set vision.provider` (without `auxiliary.` prefix). This writes to a top-level `vision` key that Hermes runtime DOES NOT actually read. The runtime reads `auxiliary.vision.provider`.

### 5. Verify

```bash
hermes config show | grep -A3 'Vision'
```

The `Vision` line should show the new provider and model. If it still shows the old values, the `auxiliary.` prefix was missed or the config was not written.

## Recipes

### Xiaomi MiMo-V2.5 via OpenRouter (vision)

```bash
hermes config set auxiliary.vision.provider openrouter
hermes config set auxiliary.vision.model xiaomi/mimo-v2.5
```

Best cost/performance ratio. Native omnimodal (image + video understanding).

### Claude Sonnet 4 via Anthropic

```bash
hermes config set auxiliary.vision.provider anthropic
hermes config set auxiliary.vision.model claude-sonnet-4-20250514
```

Strongest vision, more expensive.

### Gemini 2.5 Pro via Google/OpenRouter

```bash
hermes config set auxiliary.vision.provider openrouter
hermes config set auxiliary.vision.model google/gemini-2.5-pro-preview-03-25
```

Good for document + image understanding.

## Pitfalls

- **`auxiliary.` prefix is mandatory.** Setting `vision.provider` without the prefix creates a dead config key that `hermes config show` may or may not display, but has NO EFFECT on runtime behavior.
- **`hermes config set` writes correctly** — the issue is PATH, not the set command itself. Always use `auxiliary.vision.provider`.
- **No Hermes restart needed.** Changes take effect on next message/vision request.
- **Model name must match OpenRouter slug.** For openrouter, use the exact slug (e.g. `xiaomi/mimo-v2.5`, not `MiMo-V2.5`).

## Anti-patterns

- **Setting `vision.provider = x` without `auxiliary.` prefix** → config writes but runtime ignores it
- **Only setting provider, forgetting model** → runtime may fall back or error
- **Assuming `hermes config set vision.X` mirrors `auxiliary.vision.X`** → it does not, they are independent keys

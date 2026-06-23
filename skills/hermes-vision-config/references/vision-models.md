# Vision-Capable Models for Hermes

## Xiaomi MiMo-V2.5 (xiaomi/mimo-v2.5)
- **Provider:** OpenRouter
- **Type:** Native omnimodal (image + video)
- **Cost:** ~50% of Claude Sonnet 4
- **Strength:** Agentic performance, multimodal perception
- **Status:** Active (set 2026-06-22)

## Why not GLM-5.2 for vision?
Z.AI/Codex backend (`provider: zai, model: glm-5.2`) does NOT support vision/multimodal input. Attempting to send an image with this model as vision auxiliary will fail silently or error.

## Telegram image handling
Telegram image support does NOT require additional config. When a user sends a photo to Hermes via Telegram, the system automatically routes the image through `auxiliary.vision.provider` / `auxiliary.vision.model`. No gateway or platform-level config changes needed.

## Config hierarchy in Hermes
```
model.default: glm-5.2          # Main conversation model (NOT vision-aware)
model.provider: zai

auxiliary.vision.provider: openrouter  # Actual vision provider
auxiliary.vision.model: xiaomi/mimo-v2.5

# WRONG (has no effect):
# vision.provider: openrouter
# vision.model: xiaomi/mimo-v2.5
```

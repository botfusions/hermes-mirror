# Gemma 4 / Qwen 3.5 Mac snapshot

Session date: 2026-06-07
Host context: Apple M4, 16 GB unified memory, arm64.

Use this as a compact reference when choosing a first local model for this user's Mac. Re-check live sources if freshness matters.

## Observed Ollama Gemma 4 tags

- `gemma4:12b`
  - ~7.6 GB listing / 7.4 GB main blob observed during pull
  - 11.9B class
  - Q4_K_M quant in Ollama listing
  - 256K context listed
  - Text + Image
  - Includes ~175 MB projector blob
  - User chose this as first model to start with.

- `gemma4:12b-mlx`
  - MLX tag
  - ~10.0 GB
  - 128K context listed
  - Text only in observed listing
  - Apple Silicon optimized, but not automatically better than normal `gemma4:12b` for this user because it is larger and drops image support in the listing.

- `gemma4:e4b-mlx`
  - MLX tag
  - ~9.6 GB
  - 128K context listed
  - Text only
  - Candidate fast/daily local helper.

- Avoid as default on 16 GB RAM: `gemma4:26b`, `gemma4:31b`, and MLX equivalents unless the user explicitly accepts slow/swap-heavy operation.

## Observed Qwen options

Clarify naming:

- `qwen3:8b`
  - ~5.2 GB
  - 40K context listed
  - Text only
  - Older/lighter fallback.

- `qwen3.5:9b`
  - closest current small Qwen 3.5 model; there was no official-looking `qwen3.5:8b` tag in the observed Ollama listing
  - ~6.6 GB
  - 256K context listed
  - Text + Image
  - tools/thinking/vision flags in listing
  - Strong candidate when speed/RAM comfort matters more than Gemma 4 12B strength.

- `qwen3.5:9b-mlx`
  - MLX tag
  - ~8.9 GB
  - 256K context listed
  - Text only

- Hugging Face references observed:
  - `Qwen/Qwen3.5-9B` with Apache 2.0, image-text-to-text pipeline, high downloads.
  - `Jackrong/Qwen3.5-9B-DeepSeek-V4-Flash-GGUF` with Q4/Q5/Q8 GGUF variants, reasoning/distillation/agent/multilingual tags.

## Recommended trial order for this user

1. `gemma4:12b` — chosen first by user; strong local Hermes candidate.
2. `qwen3.5:9b` — compare if Gemma is too slow/heavy or if speed/RAM comfort wins.
3. `gemma4:12b-mlx` or `qwen3.5:9b-mlx` — only for Apple-Silicon benchmark/tuning work; note text-only listing.
4. `qwen3:8b` — lighter fallback, smaller context.

## Setup/verification notes

Ollama installed via Homebrew on this Mac pulled in `mlx` and `mlx-c` dependencies. Homebrew caveat suggested:

```bash
brew services start ollama
# or foreground tuned server:
OLLAMA_FLASH_ATTENTION="1" OLLAMA_KV_CACHE_TYPE="q8_0" /opt/homebrew/opt/ollama/bin/ollama serve
```

Verification pattern:

```bash
curl -fsS http://127.0.0.1:11434/api/version
ollama list
ollama pull gemma4:12b
ollama run gemma4:12b
```

If command approval blocks a live response test, stop and report completed state; do not retry the blocked command.

---
name: model-ops-and-local-inference
description: "Model operations: Hugging Face, local LLMs, llama.cpp, vLLM, evaluation, W&B, AudioCraft, SAM, and model surgery."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [MLOps, HuggingFace, Local-LLMs, llama.cpp, vLLM, Evaluation, Weights-and-Biases, AudioCraft, SAM]
---

# Model Ops and Local Inference

Use this umbrella for ML/model operations: model discovery/download/upload, local LLM inference, GGUF/llama.cpp, vLLM serving, evaluation harnesses, experiment tracking, audio generation models, segmentation models, and model surgery/abliteration experiments.

## Model Discovery and Assets

- Use Hugging Face Hub metadata to identify model IDs, licenses, file sizes, quantizations, and required libraries.
- Verify downloads and paths before reporting availability.
- Preserve license and safety constraints.

## Local LLMs on Macs and Workstations

- Match model size/quantization to available RAM/VRAM and context requirements.
- On Apple Silicon, prefer tested Metal/Ollama/llama.cpp routes and verify with a smoke prompt.
- Track which binary/provider is serving the model.

## llama.cpp and GGUF

- Use the server for OpenAI-compatible local inference and CLI for quick smoke tests.
- Tune context, threads, GPU layers, and quantization based on hardware.
- Report exact model file, command, endpoint, and test output.

## vLLM Serving

- Use for high-throughput GPU serving when hardware supports it.
- Verify endpoint readiness and OpenAI-compatible completions/chat calls.
- Watch memory, tensor parallel settings, and quantization compatibility.

## Evaluation and Tracking

- Use lm-eval-harness for benchmark runs with explicit task/model/config versions.
- Use W&B for experiment logging, sweeps, artifacts, and model registry when configured.
- Report metrics with dataset/task names and seeds where applicable.

## Specialized Models

- AudioCraft/MusicGen: separate text-to-music setup, generation parameters, and output artifacts.
- Segment Anything (SAM): capture prompt type (points/boxes/masks), image paths, and output masks.
- Obliteration/model surgery: treat as experimental; preserve configs, before/after metrics, and safety caveats.

## Rules

- Never invent benchmark or inference results; run the command or say what blocked it.
- Keep one model-ops umbrella with modality/serving/evaluation subsections instead of many narrow tool skills.

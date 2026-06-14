---
name: media-content-production
description: "Media and content workflows: YouTube, GIFs, audio analysis, music generation, and songwriting."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Media, YouTube, GIF, Audio, Music, Songwriting, Content]
---

# Media Content Production

Use this umbrella for media-centric tasks: YouTube transcript extraction, GIF search/download, audio feature visualization, AI music generation, and songwriting prompt craft.

## YouTube Content

- Fetch transcripts when available before summarizing.
- Preserve source URL, video title/channel/date when available.
- Output formats can include summary, blog post, thread, show notes, or content repurposing plan.

## GIF Search

- Use GIF search for reaction assets or lightweight media references.
- Prefer safe, relevant, and small files; include source URL or downloaded path.

## Audio Analysis

- Use spectrograms, mel/chroma/MFCC, tempo/onset, and waveform views when diagnosing or explaining audio.
- Report generated artifact paths and parameters.

## Music Generation and Songwriting

- Separate lyrical craft from generation prompts.
- For Suno/HeartMuLa-like tools, provide structure, genre tags, vocal direction, instrumentation, and production notes.
- Keep lyrics scannable: sections like `[Verse]`, `[Chorus]`, `[Bridge]` when the target tool benefits from them.

## Rules

- Verify downloaded/generated media paths before reporting them.
- Do not claim media was analyzed or generated unless a tool actually returned an artifact.
- Keep one media umbrella with mode-specific subsections rather than separate micro-skills for each asset type.

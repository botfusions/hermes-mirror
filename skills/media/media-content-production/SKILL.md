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

## AI Short Video Production

Use `references/ai-short-video-sample-first.md` for MoneyPrinterTurbo-style AI Shorts pipelines.

- Treat publishing automation as higher risk than local generation: plan and scaffold are allowed, but external publishing stays disabled until reviewed and approved.
- Generate exactly one representative sample before batch generation, cron scheduling, or connecting publisher APIs to live workflows.
- Verify media outputs with real file metadata such as `ffprobe` duration and report the exact file path.
- For brand channels such as Botfusions, avoid generic faceless filler; require a clear educational, demo, or original-framework layer.
- If the MoneyPrinterTurbo/Botfusions Shorts pipeline is already installed, scheduled, or sample-tested, skip setup advice and focus on performance validation: first-3-seconds retention, average watch time, loop/replay signal, profile clicks, comments, leads, and a keep/change/kill decision per format.
- If available local clips are unrelated stock footage, do not use them as-is. Generate topic-specific storyboard/material clips first, place them in MoneyPrinterTurbo `storage/local_videos`, then let MoneyPrinterTurbo assemble voice/subtitles/final video.
- When the user asks whether daily Shorts publishing is active, verify three layers before answering: Hermes cron job state, publisher wrapper/script path, and the queue/manifest status. Do not infer publishing readiness from video files alone.
- For mixed-platform Shorts publishing, report Pinterest separately as an image pin/cover when that is how the workflow is configured; do not describe it as a video publish.

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

---
name: hayri-analysis-router
description: Route user messages containing links plus the word “analiz” to the Hayri research/reporting profile.
version: 1.0.0
author: Hermes Agent
platforms: [macos]
metadata:
  hermes:
    tags: [hayri, analysis, routing, github, url, telegram, obsidian]
    created_by: agent
---

# Hayri Analysis Router

Use this skill when the user pastes one or more URLs/GitHub repo links and says `analiz`, `analiz et`, `analiz yaz`, or similar.

## Trigger

If the user's message contains either:

- one or more links (`http://`, `https://`, GitHub repo URL, or `owner/repo`) plus the Turkish analysis intent word `analiz` or an obvious equivalent, OR
- a general internet/web research/search request where the main assistant would otherwise use `web_search`, `web_extract`, or current web lookup,

then do not ask for clarification. Route the research task to Hayri.

## Action

Run the Hayri wrapper:

```bash
hayri-report --title "<optional inferred Turkish title>" <url-or-repo> [more-links]
```

If the user gave no title, omit `--title`; Hayri will infer one.

**Timeout:** Hayri's full research + report write cycle (clone → inspect → search → write → notify) can take 60–120s for repos with substantial READMEs or when web search backends are slow. Default to `timeout=300` — `hayri-report` is a foreground command that returns when done, not a fixed-duration job. The 30s default is too tight and will interrupt mid-research.

## Multi-intent handling

If the same user message also asks the main assistant to act (`kur`, `yükle`, `entegre et`, `düzelt`, `çalıştır`, `test et`), do both:

1. Start `hayri-report` for the research/reporting track.
2. Continue the concrete implementation/verification in the main session.

Do not treat Hayri routing as a substitute for the requested local install or configuration work.

## Output location

Hayri saves reports under:

```text
/Users/cenktk/Desktop/Hermes_Agent /Analizler/Hayri/
```

## Model/provider

Hayri profile uses:

```text
provider: zai
model: glm-4.7
```

This replaces the earlier DeepSeek/XAI routing for Hayri because the user prefers GLM for internet research tasks.

Implementation details and verification checklist: `references/glm-47-web-research-routing.md`.

## Completion

Hayri must send Telegram completion notification to:

```text
telegram:Cenk Tokgöz (dm)
```

and the main assistant should report the saved absolute Markdown path back to the user when available.

### Notification fallback

If Hayri creates the Markdown report but Telegram target resolution fails, do **not** treat the whole analysis as failed. The main assistant should:

1. Verify the saved report path exists/read it back if possible.
2. Deliver a concise Turkish summary in the current chat.
3. Mention that the report was saved and that only the Telegram notification failed.

This preserves the useful artifact while avoiding duplicate reruns just to fix notification delivery.

## Safety

Hayri is read/report-only. Never perform GitHub write actions such as issue/comment/approve/merge/push/workflow dispatch unless the user explicitly approves a separate write action.

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

If the user's message contains:

- one or more links (`http://`, `https://`, GitHub repo URL, or `owner/repo`), and
- the Turkish analysis intent word `analiz` or an obvious equivalent,

then do not ask for clarification. Route the task to Hayri.

## Action

Run the Hayri wrapper:

```bash
hayri-report --title "<optional inferred Turkish title>" <url-or-repo> [more-links]
```

If the user gave no title, omit `--title`; Hayri will infer one.

## Output location

Hayri saves reports under:

```text
/Users/cenktk/Desktop/Hermes_Agent /Analizler/Hayri/
```

## Model/provider

Hayri profile uses:

```text
provider: xai
model: grok-4.3
```

## Completion

Hayri must send Telegram completion notification to:

```text
telegram:Cenk Tokgöz (dm)
```

and the main assistant should report the saved absolute Markdown path back to the user when available.

## Safety

Hayri is read/report-only. Never perform GitHub write actions such as issue/comment/approve/merge/push/workflow dispatch unless the user explicitly approves a separate write action.

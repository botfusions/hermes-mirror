# Local subagent model choice: mailbox/GitHub monitor

Use this note when setting up a local Hermes profile that will sit under the main GPT/Claude-grade agent and handle routine monitoring work such as Gmail/GitHub/Jules mail triage.

## Task shape

The subagent is not the main reasoning agent. It should:

- read and classify mailbox/GitHub notification threads;
- identify authorization, invite, Jules/GitHub workflow, or action-required messages;
- summarize and escalate to the main agent/user;
- avoid automatic approvals or permission-granting unless the user explicitly changes the safety rule;
- run scheduled checks through cron or a bounded Hermes profile, not replace the main profile.

## Model decision

For a 16 GB Apple Silicon Mac, use this starting order:

1. `gemma4:12b` for the first durable mailbox/GitHub monitor profile when quality matters more than raw speed.
   - Good fit for: long mail context, classification, Turkish summaries, cautious escalation, multimodal-ish notification content.
   - Observed Ollama listing: about 7.6 GB, 256K advertised context, Text/Image.
2. `qwen3.5:9b` as the first A/B challenger if `gemma4:12b` is slow, memory-heavy, or less reliable with tool-style instructions.
   - Observed Ollama listing: about 6.6 GB, 256K advertised context, Text/Image, agent/tools/thinking positioning.
3. `qwen3:8b` only as a lighter/older fallback when speed/RAM comfort matters more than long-context quality.
   - Observed Ollama listing: about 5.2 GB, 40K advertised context, Text-only.

## A/B test prompt pattern

When deciding whether to switch a live subagent from Gemma to Qwen, run the same fixed set of 5-10 safe examples through both models:

- one GitHub authorization/invite email;
- one Jules/action-required email;
- one ordinary GitHub notification;
- one unrelated marketing/support email;
- one long thread with mixed signals.

Score:

- correct classification;
- no invented permissions or fake actions;
- concise Turkish escalation quality;
- tool-call safety wording;
- latency and RAM comfort.

Keep the model that wins on classification and safety first; speed is second unless the cron job cannot finish reliably.

## Safety default

For mailbox/GitHub monitor subagents, the durable default is report-only:

- do not click approval links;
- do not authorize GitHub apps;
- do not send emails;
- do not mutate repositories;
- escalate with enough detail for the main agent/user to approve.

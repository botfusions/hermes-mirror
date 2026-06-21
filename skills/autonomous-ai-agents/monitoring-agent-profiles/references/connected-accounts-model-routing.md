# Model routing and delivery for connected-account sentinels

Session-derived pattern for Hermes subagents that monitor mail/GitHub/Jules accounts.

## Durable lesson

A connected-account sentinel does not need to run on the same expensive/high-reasoning model as the main Hermes agent. Keep the main profile stable and assign the sentinel profile a model matched to the work:

- Scheduled mailbox/account triage: cheap, fast, web/API-capable model.
- Heavy code/debug/reasoning: main GPT-class profile or a dedicated coding profile.
- Local models: optional experiments/fallbacks, not blockers for account monitoring when a cloud model is already selected.

For this user's setup, DeepSeek V4 Flash is an appropriate default for internet/mail triage profiles, while GPT-5.5 remains reserved for harder coding/reasoning.

## Cron delivery fallback

If a scheduled job cannot resolve a chat delivery target (for example Telegram topic/channel resolution), do not block the sentinel if the scan itself works. Set delivery to local, verify the cron output/state locally, and report the delivery limitation as a separate follow-up.

## Verification points

- Main Hermes profile/model unchanged.
- Sentinel profile has its own model/provider assignment.
- Cron prompt/script is self-contained.
- First scan returns real account data with zero forbidden actions.
- Delivery mode is explicit (`local`, `origin`, or a resolved platform target), not assumed.

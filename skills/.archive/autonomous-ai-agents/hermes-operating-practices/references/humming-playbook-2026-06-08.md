# Hermes Humming Playbook — session note 2026-06-08

This reference captures a user-provided seven-point operating post about reducing friction in Hermes setups. Treat it as a session-derived domain note, not as official Hermes documentation.

## Source advice distilled

1. Install Hermes on the primary computer, not an unnecessary side machine.
   - Rationale: Hermes is most useful when it can access the regular files, apps, and account state the user already uses.
   - Side-machine installs create extra account setup and sync friction unless they provide compute, isolation, or always-on availability.

2. Use the Desktop app.
   - The Desktop app is especially useful for session management and fast messaging across profiles.
   - It enables practical multi-agent workflows without juggling many terminals.

3. Use `/background` for multitasking.
   - Send independent prompts to run in the background while continuing the main session.
   - Best for complex but separable workflows where multiple prompts can proceed in parallel.

4. Use a new profile for each model/role.
   - Profiles act like separate Hermes agents with their own memories, skills, and tools.
   - Good examples: GPT/high-reasoning for coding, Opus/writing-research, local model/private-cheap tasks.
   - Do not create profiles so granularly that maintenance friction exceeds the benefit.

5. Use local models when appropriate.
   - Local profiles are useful on capable hardware such as Mac Studio or DGX-class machines.
   - The original post mentioned Qwen 3.7 preference; keep model names current before recommending a specific model.

6. Prune cron jobs.
   - Too many cron jobs can slow the agent and produce notification noise.
   - In Hermes Desktop, cron jobs can be inspected from the lower-left cron area; remove jobs not recently useful.
   - Prefer consolidated reports over many overlapping schedules.

7. Lower compression threshold when memory/context issues appear.
   - The post recommends `0.5` as a practical threshold, causing more frequent compression.
   - Explain tradeoff: earlier compression reduces live context size but may lose nuance.
   - Confirm current config schema via official docs or `hermes-agent` before changing.

## How to answer future user questions about this post

A good response should be nuanced:

- Mostly agree with the direction: reduce friction, run Hermes where work happens, manage profiles and cron deliberately.
- Add caveats: side machines can be correct for always-on gateway, special compute, corporate isolation, or sandboxing.
- Separate operating advice from exact commands; exact commands come from docs/protected `hermes-agent` skill.
- For this user specifically, remember quiet-hours requirements for scheduled reports and the preference for read-only delegated Gmail/GitHub agents.

## Reusable summary

If the user asks “do you agree with these 7 things?”, answer: yes, broadly — because they optimize for low-friction, high-context Hermes operation — but with caveats around side machines, profile sprawl, local model limitations, and compression tradeoffs. The most important two are primary-machine install and cron pruning; the biggest risk is over-creating profiles or background jobs without maintenance.

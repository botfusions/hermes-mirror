# Hermes Mirror

Private, secrets-free mirror of portable Hermes configuration for restoring on a new machine.

Generated: 2026-06-08T02:14:05
Source: `~/.hermes/`
Local mirror: `~/code/hermes-mirror/`
Remote: `https://github.com/botfusions/hermes-mirror.git`

## What is included

This mirror uses an allowlist-first backup strategy. It includes only files that passed the local secret-content scan.

Typical included areas:

- `skills/` — reusable Hermes skills and workflow notes.
- `profiles/<name>/SOUL.md` — profile personas when present.
- `profiles/<name>/skills/` — profile-local skills when safe.
- `pantheon/` — operator/persona metadata if present and safe.
- `memories/` or `memory/` — only if present and safe.
- `cron/` — only safe cron metadata/scripts that pass scanning.
- `SOUL.md` — default persona if present and safe.
- `config.yaml` — only if it passes the scan. Many Hermes configs contain key-name fields and may be skipped intentionally.

## What is intentionally excluded

Never restore or commit secrets from this repository. These are intentionally excluded:

- `.env`, `.env.*`, profile `.env` files
- `auth*`, `auth.json`
- `sessions/`
- `state*`, `*.db`, `*.sqlite`, `*.sqlite3`
- `logs/`
- `gateway.pid`
- `audio_cache/`, `image_cache/`, `sandboxes/`, `checkpoints/`
- any file whose name or content looks credential-related

## Restore outline on a new machine

1. Install Hermes Agent.
2. Clone this private repo.
3. Copy desired safe files back into `~/.hermes/`.
4. Recreate secrets manually in `~/.hermes/.env` and profile `.env` files.
5. Run `hermes config check`, then restart gateway/cron as needed.

## Secrets you must recreate manually

The real values are not stored here. Re-add them manually when needed:

- `GITHUB_TOKEN` or `GH_TOKEN`
- `TELEGRAM_BOT_TOKEN`
- `TELEGRAM_ALLOWED_USERS`
- `DEEPSEEK_API_KEY`
- `XAI_API_KEY`
- `COMPOSIO_API_KEY`
- any other provider keys used by your profiles

## Last sync summary

Copied files: 985
Skipped files: 499

### Skipped examples / reasons

- `config.yaml` (sensitive-content)
- `skills/.usage.json` (sensitive-content)
- `skills/apple/macos-computer-use/SKILL.md` (sensitive-content)
- `skills/research/polymarket/SKILL.md` (sensitive-content)
- `skills/research/polymarket/references/api-endpoints.md` (sensitive-content)
- `skills/research/polymarket/scripts/polymarket.py` (sensitive-content)
- `skills/research/llm-wiki/SKILL.md` (sensitive-content)
- `skills/research/research-paper-writing/SKILL.md` (sensitive-content)
- `skills/research/research-paper-writing/references/experiment-patterns.md` (sensitive-content)
- `skills/research/research-paper-writing/references/writing-guide.md` (sensitive-content)
- `skills/research/research-paper-writing/references/autoreason-methodology.md` (sensitive-content)
- `skills/research/research-paper-writing/references/citation-workflow.md` (sensitive-content)
- `skills/research/research-paper-writing/templates/colm2025/colm2025_conference.pdf` (binary-ext)
- `skills/research/research-paper-writing/templates/colm2025/colm2025_conference.tex` (sensitive-content)
- `skills/research/research-paper-writing/templates/colm2025/natbib.sty` (sensitive-content)
- `skills/research/research-paper-writing/templates/icml2026/icml_numpapers.pdf` (binary-ext)
- `skills/research/research-paper-writing/templates/icml2026/fancyhdr.sty` (sensitive-content)
- `skills/research/research-paper-writing/templates/icml2026/example_paper.pdf` (binary-ext)
- `skills/research/research-paper-writing/templates/aaai2026/aaai2026-unified-template.tex` (sensitive-content)
- `skills/research/research-paper-writing/templates/iclr2026/iclr2026_conference.tex` (sensitive-content)
- `skills/research/research-paper-writing/templates/iclr2026/natbib.sty` (sensitive-content)
- `skills/research/research-paper-writing/templates/iclr2026/iclr2026_conference.pdf` (binary-ext)
- `skills/social-media/xurl/SKILL.md` (sensitive-content)
- `skills/devops/kanban-worker/SKILL.md` (sensitive-content)
- `skills/devops/kanban-orchestrator/SKILL.md` (sensitive-content)
- `skills/data-science/jupyter-live-kernel/SKILL.md` (sensitive-content)
- `skills/software-development/plan/SKILL.md` (sensitive-content)
- `skills/software-development/secrets-management/SKILL.md` (sensitive-name)
- `skills/software-development/secrets-management/references/composio-mcp-secrets.md` (sensitive-name)
- `skills/software-development/hermes-agent-skill-authoring/SKILL.md` (sensitive-content)
- `skills/software-development/python-debugpy/SKILL.md` (sensitive-content)
- `skills/software-development/spike/SKILL.md` (sensitive-content)
- `skills/software-development/requesting-code-review/SKILL.md` (sensitive-content)
- `skills/mlops/huggingface-hub/SKILL.md` (sensitive-content)
- `skills/mlops/mac-local-llms/SKILL.md` (sensitive-content)
- `skills/mlops/mac-local-llms/references/gemma4-ollama-apple-silicon.md` (sensitive-content)
- `skills/mlops/models/audiocraft/SKILL.md` (sensitive-content)
- `skills/mlops/models/audiocraft/references/troubleshooting.md` (sensitive-content)
- `skills/mlops/models/audiocraft/references/advanced-usage.md` (sensitive-content)
- `skills/mlops/inference/vllm/SKILL.md` (sensitive-content)
- `skills/mlops/inference/vllm/references/server-deployment.md` (sensitive-content)
- `skills/mlops/inference/vllm/references/troubleshooting.md` (sensitive-content)
- `skills/mlops/inference/vllm/references/optimization.md` (sensitive-content)
- `skills/mlops/inference/vllm/references/quantization.md` (sensitive-content)
- `skills/mlops/inference/obliteratus/SKILL.md` (sensitive-content)
- `skills/mlops/inference/obliteratus/references/analysis-modules.md` (sensitive-content)
- `skills/mlops/inference/llama-cpp/SKILL.md` (sensitive-content)
- `skills/mlops/inference/llama-cpp/references/troubleshooting.md` (sensitive-content)
- `skills/mlops/inference/llama-cpp/references/server.md` (sensitive-content)
- `skills/mlops/inference/llama-cpp/references/optimization.md` (sensitive-content)
- `skills/mlops/inference/llama-cpp/references/advanced-usage.md` (sensitive-content)
- `skills/mlops/inference/llama-cpp/references/quantization.md` (sensitive-content)
- `skills/mlops/evaluation/DESCRIPTION.md` (sensitive-content)
- `skills/mlops/evaluation/lm-evaluation-harness/SKILL.md` (sensitive-content)
- `skills/mlops/evaluation/lm-evaluation-harness/references/benchmark-guide.md` (sensitive-content)
- `skills/mlops/evaluation/lm-evaluation-harness/references/api-evaluation.md` (sensitive-content)
- `skills/mlops/evaluation/weights-and-biases/SKILL.md` (sensitive-content)
- `skills/mlops/evaluation/weights-and-biases/references/artifacts.md` (sensitive-content)
- `skills/github/github-auth/SKILL.md` (sensitive-content)
- `skills/github/github-auth/scripts/gh-env.sh` (sensitive-content)
- `skills/github/github-repo-management/SKILL.md` (sensitive-content)
- `skills/github/github-repo-management/references/github-api-cheatsheet.md` (sensitive-content)
- `skills/github/github-pr-workflow/SKILL.md` (sensitive-content)
- `skills/github/github-pr-workflow/references/ci-troubleshooting.md` (sensitive-content)
- `skills/github/github-pr-workflow/references/conventional-commits.md` (sensitive-content)
- `skills/github/github-code-review/SKILL.md` (sensitive-content)
- `skills/github/github-issues/SKILL.md` (sensitive-content)
- `skills/github/gungor-github-mail-ops/SKILL.md` (sensitive-content)
- `skills/github/gungor-github-mail-ops/references/full-operational-check.md` (sensitive-content)
- `skills/note-taking/obsidian/SKILL.md` (sensitive-content)
- `skills/note-taking/obsidian/references/hermes-memory-wiki.md` (sensitive-content)
- `skills/red-teaming/godmode/SKILL.md` (sensitive-content)
- `skills/red-teaming/godmode/references/jailbreak-templates.md` (sensitive-content)
- `skills/red-teaming/godmode/scripts/auto_jailbreak.py` (sensitive-content)
- `skills/red-teaming/godmode/scripts/godmode_race.py` (sensitive-content)
- `skills/red-teaming/godmode/scripts/parseltongue.py` (sensitive-content)
- `skills/creative/comfyui/SKILL.md` (sensitive-content)
- `skills/creative/comfyui/references/official-cli.md` (sensitive-content)
- `skills/creative/comfyui/references/template-integrity.md` (sensitive-content)
- `skills/creative/comfyui/references/rest-api.md` (sensitive-content)
- `skills/creative/comfyui/tests/conftest.py` (sensitive-content)
- `skills/creative/comfyui/tests/test_common.py` (sensitive-content)
- `skills/creative/comfyui/tests/test_cloud_integration.py` (sensitive-content)
- `skills/creative/comfyui/tests/pytest.ini` (sensitive-content)
- `skills/creative/comfyui/tests/test_run_workflow.py` (sensitive-content)
- `skills/creative/comfyui/tests/README.md` (sensitive-content)
- `skills/creative/comfyui/workflows/README.md` (sensitive-content)
- `skills/creative/comfyui/scripts/fetch_logs.py` (sensitive-content)
- `skills/creative/comfyui/scripts/check_deps.py` (sensitive-content)
- `skills/creative/comfyui/scripts/_common.py` (sensitive-content)
- `skills/creative/comfyui/scripts/ws_monitor.py` (sensitive-content)
- `skills/creative/comfyui/scripts/run_batch.py` (sensitive-content)
- `skills/creative/comfyui/scripts/auto_fix_deps.py` (sensitive-content)
- `skills/creative/comfyui/scripts/health_check.py` (sensitive-content)
- `skills/creative/comfyui/scripts/run_workflow.py` (sensitive-content)
- `skills/creative/baoyu-infographic/SKILL.md` (sensitive-content)
- `skills/creative/ascii-video/references/inputs.md` (sensitive-content)
- `skills/creative/touchdesigner-mcp/references/replicator.md` (sensitive-content)
- `skills/creative/touchdesigner-mcp/references/external-data.md` (sensitive-content)
- `skills/creative/claude-design/SKILL.md` (sensitive-content)
- `skills/creative/design-md/SKILL.md` (sensitive-content)
- `skills/creative/design-md/templates/starter.md` (sensitive-content)
- `skills/creative/popular-web-designs/SKILL.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/resend.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/warp.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/composio.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/airbnb.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/sentry.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/vercel.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/ibm.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/supabase.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/opencode.ai.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/sanity.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/pinterest.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/bmw.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/revolut.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/lovable.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/voltagent.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/airtable.md` (sensitive-content)
- `skills/creative/popular-web-designs/templates/hashicorp.md` (sensitive-content)
- `skills/creative/pretext/templates/donut-orbit.html` (sensitive-content)
- `skills/creative/p5js/references/export-pipeline.md` (sensitive-content)
- `skills/creative/architecture-diagram/templates/template.html` (sensitive-content)
- `skills/creative/sketch/SKILL.md` (sensitive-content)
- `skills/claude-os/SKILL.md` (sensitive-content)
- `skills/claude-os/references/launchd-dream-operator-setup.md` (sensitive-content)
- `skills/email/himalaya/SKILL.md` (sensitive-content)
- `skills/email/himalaya/references/configuration.md` (sensitive-content)
- `skills/autonomous-ai-agents/claude-code/SKILL.md` (sensitive-content)
- `skills/autonomous-ai-agents/agentic-self-improvement-loop/SKILL.md` (sensitive-content)
- `skills/autonomous-ai-agents/agentic-self-improvement-loop/references/agentic-os-operator-console.md` (sensitive-content)
- `skills/autonomous-ai-agents/agentic-self-improvement-loop/templates/agentic-program-template.md` (sensitive-content)
- `skills/autonomous-ai-agents/hermes-portable-backup/SKILL.md` (sensitive-content)
- `skills/autonomous-ai-agents/hermes-portable-backup/references/hermes-mirror-backup-pattern.md` (sensitive-content)
- `skills/autonomous-ai-agents/codex/SKILL.md` (sensitive-content)
- `skills/autonomous-ai-agents/hermes-agent/SKILL.md` (sensitive-content)
- `skills/autonomous-ai-agents/hermes-agent/references/webhooks.md` (sensitive-content)
- `skills/autonomous-ai-agents/hermes-agent/references/native-mcp.md` (sensitive-content)
- `skills/autonomous-ai-agents/connected-account-agents/SKILL.md` (sensitive-content)
- `skills/autonomous-ai-agents/connected-account-agents/references/composio-gmail-github-jules-sentinel.md` (sensitive-content)
- `skills/autonomous-ai-agents/opencode/SKILL.md` (sensitive-content)
- `skills/dogfood/references/issue-taxonomy.md` (sensitive-content)
- `skills/productivity/teams-meeting-pipeline/SKILL.md` (sensitive-content)
- `skills/productivity/notion/SKILL.md` (sensitive-content)
- `skills/productivity/airtable/SKILL.md` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/microsoft/wml-2012.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/microsoft/wml-2010.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/microsoft/wml-2018.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/shared-customXmlSchemaProperties.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/pml.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/dml-chart.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/sml.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/vml-spreadsheetDrawing.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/wml.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/dml-diagram.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/dml-main.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/dml-spreadsheetDrawing.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/shared-commonSimpleTypes.xsd` (sensitive-content)
- `skills/productivity/powerpoint/scripts/office/schemas/ISO-IEC29500-4_2016/dml-wordprocessingDrawing.xsd` (sensitive-content)
- `skills/productivity/google-workspace/SKILL.md` (sensitive-content)
- `skills/productivity/google-workspace/scripts/gws_bridge.py` (sensitive-content)
- `skills/productivity/google-workspace/scripts/google_api.py` (sensitive-content)
- `skills/productivity/google-workspace/scripts/setup.py` (sensitive-content)
- `skills/media/gif-search/SKILL.md` (sensitive-content)
- `pantheon/personas/philosopher.yaml` (sensitive-content)
- `memories/MEMORY.md` (sensitive-content)
- `memories/USER.md` (sensitive-content)
- `cron/jobs.json` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_21-01-45.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_21-10-13.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_18-20-43.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_21-03-32.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_21-00-09.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_21-06-18.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_20-07-29.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_18-21-52.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_21-17-51.md` (sensitive-content)
- `cron/output/a2ff23b0029d/2026-06-07_20-56-15.md` (sensitive-content)
- `profiles/gungor/SOUL.md` (sensitive-content)
- `profiles/gungor/skills/.usage.json` (sensitive-content)
- `profiles/gungor/skills/apple/macos-computer-use/SKILL.md` (sensitive-content)
- `profiles/gungor/skills/research/polymarket/SKILL.md` (sensitive-content)
- `profiles/gungor/skills/research/polymarket/references/api-endpoints.md` (sensitive-content)
- `profiles/gungor/skills/research/polymarket/scripts/polymarket.py` (sensitive-content)
- `profiles/gungor/skills/research/llm-wiki/SKILL.md` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/SKILL.md` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/references/experiment-patterns.md` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/references/writing-guide.md` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/references/autoreason-methodology.md` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/references/citation-workflow.md` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/templates/colm2025/colm2025_conference.pdf` (binary-ext)
- `profiles/gungor/skills/research/research-paper-writing/templates/colm2025/colm2025_conference.tex` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/templates/colm2025/natbib.sty` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/templates/icml2026/icml_numpapers.pdf` (binary-ext)
- `profiles/gungor/skills/research/research-paper-writing/templates/icml2026/fancyhdr.sty` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/templates/icml2026/example_paper.pdf` (binary-ext)
- `profiles/gungor/skills/research/research-paper-writing/templates/aaai2026/aaai2026-unified-template.tex` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/templates/iclr2026/iclr2026_conference.tex` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/templates/iclr2026/natbib.sty` (sensitive-content)
- `profiles/gungor/skills/research/research-paper-writing/templates/iclr2026/iclr2026_conference.pdf` (binary-ext)

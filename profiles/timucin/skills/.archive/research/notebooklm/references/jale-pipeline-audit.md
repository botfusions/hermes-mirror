# Jale NotebookLM Pipeline Audit Pattern

Session-specific note for future NotebookLM/Jale checks.

## What was checked

- Local Hermes cron list: no Jale cron was present.
- Local Hermes profiles: no `~/.hermes/profiles/jale` profile and no NotebookLM references under profiles.
- Jale Wiki baseline/development report: describes briefing/dreaming, CMO dashboard, and skill intake, but no NotebookLM pipeline step.
- Coolify read-only health report: confirms VPS/Coolify service health, but does not expose container filesystem, crontab, or `/opt/data` pipeline scripts.
- Local Mac NotebookLM state: CLI/auth may differ from Windows/VPS auth state; do not conflate locations.

## Reusable rule

NotebookLM auth copied to a host means only that the host *can* use NotebookLM. It does not prove that a specific agent cron or pipeline invokes NotebookLM.

## Strong verification path

1. Search local cron/profile/wiki first.
2. Search remote container files only through approved read-only access.
3. Look for `notebooklm`, `storage_state.json`, `source add`, `generate`, or NotebookLM wrapper calls in cron scripts, pipeline code, and skill files.
4. Report three states separately: auth present, CLI installed, pipeline wired.

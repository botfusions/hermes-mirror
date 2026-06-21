# Cron Engine Script Path Restrictions

## Context

Hermes cron engine enforces strict script path resolution. Scripts must resolve inside `~/.hermes/scripts/`. Several gotchas were discovered through real failures.

## Symlink Block (Most Common Failure)

**Symptom:** Cron job fails with:
```
Blocked: script path resolves outside the scripts directory (/Users/cenktk/.hermes/scripts): 'script_name.sh'
```

**Cause:** The cron engine follows symlinks. If `~/.hermes/scripts/mehmet_hakan_bridge_producer.sh` is a symlink to `~/.hermes/profiles/mehmet/scripts/mehmet_hakan_bridge_producer.sh`, the engine detects the real path is outside the global scripts dir and blocks execution.

**Fix:** Replace the symlink with a real file copy:
```bash
rm ~/.hermes/scripts/<script>.sh
cp ~/.hermes/profiles/<profile>/scripts/<script>.sh ~/.hermes/scripts/<script>.sh
chmod +x ~/.hermes/scripts/<script>.sh
```

**Important:** Keep the profile-local copy as the source of truth. When the script is updated, copy it to the global scripts dir. There is no auto-sync.

## Script Name Mismatch

**Symptom:** Cron job fails with:
```
error: Script not found: /Users/cenktk/.hermes/scripts/<expected_name>.sh
```

**Cause:** The cron job's `script` field references a filename that doesn't match the actual file. Example: cron says `orkun_wiki_health.sh` but the file is `orkun_coolify_health.py`.

**Fix:** Update the cron job to reference the correct script name:
```python
cronjob(action="update", job_id="<id>", script="<correct_filename>")
```

Or create a symlink (works only when the target is also inside the global scripts dir):
```bash
cd ~/.hermes/scripts && ln -sf actual_name.py expected_name.sh
```

## Workdir Override Path Issues

**Symptom:** Cron job fails with path resolution errors even when the script exists.

**Cause:** A cron job with `workdir` set to a profile directory may cause script resolution issues if the script path is relative or if the workdir creates an unexpected CWD.

**Fix:** Remove the workdir override if the script is in the global scripts dir:
```python
cronjob(action="update", job_id="<id>", workdir="")
```

## Diagnosis Workflow

When a cron job shows `last_status: error`:

1. Read the error message from `hermes cron list` output (look for `Last run: ... error: <message>`).
2. Check if the script file exists: `ls -la ~/.hermes/scripts/<script_name>`.
3. If it's a symlink, check where it points: `readlink -f ~/.hermes/scripts/<script_name>`.
4. If the target is outside the global scripts dir → replace with real copy.
5. If the file doesn't exist → check for name mismatch or missing file.
6. Fix the issue, then manually trigger: `cronjob(action="run", job_id="<id>")`.
7. Wait 10-15 seconds, re-check: `hermes cron list | grep -A8 "<job_name>"`.
8. Confirm `Last run` shows `ok`.

## Heartbeat Detection

The `hermes_heartbeat.py` script includes `cron_failures()` which parses `hermes cron list` output for jobs with `error` in the last run line. Failed jobs appear in the heartbeat Telegram report under "⚠️ Cron hataları:". This means broken cron jobs surface within hours (heartbeat runs 8x daily) instead of going unnoticed.

## Prevention Checklist

- [ ] Script file exists in `~/.hermes/scripts/` (not a symlink to outside).
- [ ] Cron job `script` field matches the actual filename exactly.
- [ ] Script has correct shebang (`#!/usr/bin/env python3` or `#!/bin/bash`).
- [ ] Script is executable (`chmod +x`).
- [ ] No workdir override unless needed for profile-specific execution context.
- [ ] After creating/updating, run once manually and verify `ok`.

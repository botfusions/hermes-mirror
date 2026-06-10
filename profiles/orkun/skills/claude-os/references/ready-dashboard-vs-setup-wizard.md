# Ready dashboard vs setup wizard

Use when Agentic OS opens as if it is a fresh install, but the user expects yesterday's saved/ready operator dashboard.

## Symptom

- `http://127.0.0.1:8081/` loads successfully, but the UI shows onboarding/setup instead of the existing dashboard.
- The user may say it is “starting from zero” or “hazır olan olmalı”.

## Root causes seen

1. `~/.claude-os/show-wizard` remained from a setup/install run. The dashboard checks `/__just-installed`; if this marker exists, it can force the wizard even when data exists.
2. Browser `localStorage` may not contain `claude-os-config` in a new browser/profile, even though `src/data/live-data.json` contains real aggregate state.

## Fix pattern

1. Delete the stale marker if present:

```bash
rm -f "$HOME/.claude-os/show-wizard"
```

2. Check that live data is real, not demo/cold data. Safe indicators include nonzero `summary.totalAssistantMessages` and existing activity/memory/session panels.
3. If the code currently opens setup whenever `localStorage.getItem("claude-os-config")` is missing, adjust the initializer so real live activity counts as already configured. The intended behavior: onboarding only for a truly cold install, not for a ready operator state in a fresh browser.
4. Rebuild and verify:

```bash
cd "/Users/cenktk/Desktop/AGENTİC OS/agentic-os"
bun run build
curl -fsS -o /tmp/agentic-os-home.html -w 'HTTP %{http_code} size %{size_download}\n' http://127.0.0.1:8081/
```

5. Browser/UI verification should show operational dashboard content such as:

- “Good morning. Today at a glance.”
- “Mission Control”
- “Your skills”
- “Your memory”
- “Scheduled tasks”

## Do not

- Do not tell the user to redo setup before checking the marker and live data.
- Do not treat missing browser localStorage as proof that the Agentic OS state is gone.
- Do not claim the system is fully ready until the actual URL has been opened or fetched and the ready dashboard state is verified.

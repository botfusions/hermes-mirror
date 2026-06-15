# Agentic OS — LaunchAgent EPERM sandbox fix

## Symptom

`com.agentic-os.dashboard` LaunchAgent crashes immediately with `last exit code = 1` and `state = spawn scheduled` (keeps retrying but never binds port 8081). The error log shows:

```
Error: EPERM: operation not permitted, open '.../node_modules/vite/bin/vite.js'
```

The file permissions are correct (even 777), but macOS TCC/sandbox blocks the LaunchAgent from reading files on the Desktop.

## Root cause

macOS LaunchAgents run in a sandbox that denies access to certain directories (Desktop, Documents, Downloads) unless the process has explicit TCC entitlements. The Vite dev server binary inside `node_modules/` is affected even though the working directory is correctly set.

## Fix

Replace the symlink-based invocation in the runner script with a direct `bun` invocation:

**Before** (broken):
```bash
exec "/Users/cenktk/Desktop/AGENTİC OS/agentic-os/node_modules/.bin/vite" dev --host 127.0.0.1
```

**After** (working):
```bash
exec bun node_modules/vite/bin/vite.js dev --host 127.0.0.1
```

`bun` itself lives in `~/.bun/bin/` (outside the sandbox-restricted directories) and can read files anywhere the user has access, so it bypasses the TCC restriction.

## Full working runner script

`~/.claude-os/run-agentic-os-dashboard.sh`:
```bash
#!/bin/zsh
set -e
export HOME="/Users/cenktk"
export PATH="/Users/cenktk/.bun/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"
cd "/Users/cenktk/Desktop/AGENTİC OS/agentic-os"
bun run seed:data
exec bun node_modules/vite/bin/vite.js dev --host 127.0.0.1
```

## Recovery steps

```bash
# 1. Kill any stale process on port 8081
kill $(lsof -t -i :8081) 2>/dev/null

# 2. Unload the broken agent
launchctl bootout gui/$(id -u)/com.agentic-os.dashboard

# 3. Fix the script (see above), then reload
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.agentic-os.dashboard.plist

# 4. Verify
sleep 5
lsof -nP -iTCP:8081 -sTCP:LISTEN
curl -fsS -o /dev/null -w "%{http_code}" http://127.0.0.1:8081/
```

## Notes

- If `node_modules` is ever deleted or corrupted, re-run `bun install` in the project directory before reloading the agent.
- **Clean reinstall may be needed**: If EPERM persists even after fixing the script, the `node_modules` directory itself may have been corrupted by repeated crash loops. Do `rm -rf node_modules && bun install` to get a clean state.
- The `node_modules/.bin/vite` symlink points to `../vite/bin/vite.js` — both paths trigger EPERM under the sandbox. Only the `bun` direct invocation works.
- This fix is specific to LaunchAgent context. Running the same command from an interactive terminal or Hermes background process works fine with either invocation.
- **Verification**: After fix, the dashboard should show real data (sessions, memory chars, model counts). If it shows "0 SESSIONS", "0 MESSAGES", "0 / 0 CHARS" — the backend APIs are not being polled correctly. Check browser console for JS errors and verify `curl -s http://127.0.0.1:8081/__hermes_sessions` returns data.

# Dream health verification

Use this reference when checking whether Agentic OS Dream/rüya is actually working.

## Key distinction

The Agentic OS dashboard and the Dream generator are separate health domains:

- Dashboard healthy means the operator UI/API is alive on `127.0.0.1:8081`.
- Dream healthy means the scheduled/manual Dream run completed and wrote a real artifact under `~/.claude-os/dreams/`.

Do not infer Dream health from dashboard health alone.

## Minimal check sequence

```bash
launchctl list | grep 'com.agentic-os.dashboard'
launchctl list | grep 'com.claude-os.dream'
lsof -nP -iTCP:8081 -sTCP:LISTEN
curl -fsS http://127.0.0.1:8081/__hermes_status

tail -80 ~/.claude-os/dream-cron.log
find ~/.claude-os/dreams -maxdepth 1 -type f -print | tail -10
```

## Interpretation

- Dashboard launchd entry + port 8081 + `/__hermes_status` OK: Agentic OS dashboard is working.
- Dream launchd entry only: scheduler is installed, not proof that Dream generation works.
- Clean Dream log plus a newly-created file in `~/.claude-os/dreams/`: Dream generation is verified.
- No artifact in `~/.claude-os/dreams/`: say Dream is not verified or not working yet.

## Repair pattern from prior session

A Dream wrapper that uses Python only to run Claude can fail before Claude starts under macOS launchd. Prefer a shell/perl timeout wrapper that execs Claude directly:

```sh
/usr/bin/perl -e 'alarm shift; exec @ARGV or die "exec failed: $!\n"' 1800 \
  /Users/cenktk/.local/bin/claude \
  --add-dir "$HOME/.claude-os" \
  --permission-mode auto \
  -p /dream
```

This only removes the wrapper failure mode. It does not prove Claude authentication or the Dream command itself is healthy; always rerun the artifact check afterward.

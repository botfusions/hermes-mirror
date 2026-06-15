# Hermes Dashboard Pairing Troubleshooting

Session-derived checklist for diagnosing `http://127.0.0.1:9119/pairing` failures.

## Symptoms

- Browser or `curl http://127.0.0.1:9119/pairing` returns connection refused.
- `hermes dashboard --status` may show stale/running process information, but port 9119 is not actually listening.
- Agentic OS at `127.0.0.1:8081` can be healthy while Hermes native dashboard at `127.0.0.1:9119` is down.

## Verification sequence

1. Check the page directly:
   ```bash
   curl -i http://127.0.0.1:9119/pairing
   ```
2. Check whether anything is listening on the Hermes dashboard port:
   ```bash
   lsof -nP -iTCP:9119 -sTCP:LISTEN
   ```
3. If no listener exists, start the native dashboard:
   ```bash
   hermes dashboard --port 9119 --host 127.0.0.1 --no-open --skip-build
   ```
4. Recheck `/pairing` in a browser or via `curl`.

## Expected behavior

- `/pairing` should render the Hermes Agent dashboard page with Pending requests / Approved users.
- Direct calls to `/api/pairing` can return `401 Unauthorized`; that is normal for unauthenticated API access. Use the browser UI/session for pairing operations.

## Pitfall

Do not confuse Agentic OS port 8081 with Hermes native dashboard port 9119. A healthy Agentic OS status page does not prove the Hermes pairing UI is running.
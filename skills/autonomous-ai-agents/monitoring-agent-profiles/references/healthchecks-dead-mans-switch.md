# Healthchecks.io Dead Man's Switch — Setup & Verification

## What This Solves

Mac mini is the single point of failure for Hermes: gateway, cron jobs, Telegram bot, heartbeat — all run on it. If Mac mini dies, everything dies silently. No alert, no fallback. Healthchecks.io provides an external observer that notices when the Mac mini stops pinging.

## Setup Steps

1. Create account at https://healthchecks.io (free tier sufficient)
2. Add Check → set Schedule to Cron mode
3. Match the heartbeat cron expression exactly (e.g., `0 0,10,12,14,16,18,20,22 * * *`)
4. Set Grace period to 30 minutes
5. Integrations → Add Telegram → connect the bot
6. Copy the Ping URL (format: `https://hc-ping.com/<uuid>`)

## Heartbeat Script Integration

In `~/.hermes/scripts/hermes_heartbeat.py`, add the ping function and call it BEFORE the quiet-window check:

```python
def ping_healthchecks() -> None:
    """Dead man's switch: tell healthchecks.io the Mac mini is alive."""
    run(["curl", "-fsS", "--max-time", "10",
         "https://hc-ping.com/<uuid>"], timeout=15)

def main() -> int:
    now = dt.datetime.now().astimezone()
    ping_healthchecks()          # MUST be before quiet check
    if QUIET_START <= now.hour < QUIET_END:
        return 0
```

**Why before the quiet check:** The quiet window (02:00-09:00) suppresses the Telegram heartbeat REPORT, not the liveness ping. If the ping is inside the quiet block, healthchecks.io gets no signal overnight and fires false alarms during the 00:00→10:00 gap.

## Verification

```bash
# Manual ping test
curl -fsS --max-time 10 -w "\nHTTP_CODE: %{http_code}\n" "https://hc-ping.com/<uuid>"
# Expected: OK + HTTP_CODE: 200

# Full heartbeat test (includes ping + report)
python3 ~/.hermes/scripts/hermes_heartbeat.py

# Check healthchecks.io dashboard → the check should show "up" with recent ping
```

## Cron Schedule Alignment

The heartbeat cron job runs at: 00:00, 10:00, 12:00, 14:00, 16:00, 18:00, 20:00, 22:00 (TSI).

The longest gap is 00:00 → 10:00 (10 hours). This is intentional:
- healthchecks.io cron mode expects the NEXT scheduled ping, not a periodic one
- It will NOT flag the 10-hour gap as a missed ping
- If 10:00 ping doesn't arrive by 10:30 (grace), THEN it alerts

## Failure Modes

- **Mac mini hard crash** → pings stop → alert fires within 30 min of next expected ping
- **Network outage (Mac mini up, no internet)** → curl fails silently → same as crash from healthchecks.io perspective → alert fires (correct behavior, internet is required for Hermes anyway)
- **healthchecks.io itself down** → no alert possible, but this is a third-party SaaS with high uptime; acceptable single point for the alerting layer

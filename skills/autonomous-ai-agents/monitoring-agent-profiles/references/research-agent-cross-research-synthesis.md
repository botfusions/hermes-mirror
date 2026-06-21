# Cross-Agent Research Synthesis

Use this reference when one Hermes research profile consumes another profile's wiki reports instead of gathering raw web/X data itself.

## Mehmet-Hakan Bridge Pattern

- Upstream agent: Hakan collects bounded news and X/Twitter tracking into `/Users/cenktk/Desktop/Hermes_Agent /Hakan Wiki/`.
- Downstream agent: Mehmet consumes recent Hakan Markdown reports as filtered signals and writes a synthesis report into `/Users/cenktk/Desktop/Hermes_Agent /Mehmet Wiki/Inbox`.
- Producer script example: `/Users/cenktk/.hermes/profiles/mehmet/scripts/mehmet_hakan_bridge_producer.sh`.
- Model used in the verified pattern: Z.AI GLM 4.7 via Hermes.

## Recommended Prompt Shape

Require the downstream synthesis report to include:

1. `Yönetici Özeti` with exactly 3 bullets.
2. At most 7 findings.
3. Per finding:
   - `Kaynak` with source file and/or tweet URL.
   - `Botfusions İçin Fırsat`.
   - `Risk`.
   - `Net Aksiyon`.
   - `Öncelik` constrained to P0, P1, or P2.

## Rules

- Treat upstream reports as filtered signals, not raw dumps.
- Deduplicate similar tweets/findings before synthesis.
- Preserve source links.
- Keep max recent source files bounded to control cost and noise.
- After changing the producer prompt, run both the producer and the downstream autoresearch consumer to verify the full pipeline.

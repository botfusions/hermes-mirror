# External Data Layer Evaluation — TinyFish BigSet Case

Use this reference when the user asks whether Hermes should adopt an external data layer, live-web dataset tool, vector store, ETL service, or agent-facing research database.

## Evaluation Pattern

1. **Classify the tool honestly**
   - Is it a core query layer, a dataset generator, an export source, a crawler, or a scheduler?
   - Do not promote a tool to “real-time data layer” just because it refreshes data.

2. **Inspect operational surface**
   - Services/ports required.
   - Docker/database/runtime requirements.
   - Required external API keys and per-run cost.
   - Whether it can run as a bounded CLI instead of a daemon.

3. **Check API maturity**
   - Agent-native API available now or roadmap only?
   - SQL/query surface available now or roadmap only?
   - Provenance, incremental updates, and retry/healing behavior available now or roadmap only?

4. **Prefer sidecar before core dependency**
   - Start with manual CLI/export usage.
   - Feed CSV/JSON into Hermes or a profile wiki.
   - Add cron only after quality, cost, and refresh cadence are proven.
   - Avoid embedding AGPL or immature service code directly into Hermes.

## BigSet Findings

TinyFish BigSet is best treated as a live-web structured dataset generator, not yet as Hermes' core real-time data layer.

Observed shape:
- Repository: `tinyfish-io/bigset`.
- License: AGPL-3.0 for the app/backend; CLI package is separately published.
- Stack: Next.js frontend, Fastify TypeScript backend, Mastra workflows, self-hosted Convex, Docker/Postgres for source development.
- External dependencies: TinyFish Search/Fetch API and OpenRouter LLM calls.
- CLI: `@adamexu/bigset` exposes create/list/status/rows/export/populate/stop.
- Roadmap items include stronger SQL/query layer, agent-native API, incremental updates, provenance, and healer agents.

Recommended Hermes posture:
- **Do:** use as an optional research sidecar for Botfusions/Hayri/Hakan/Jale dataset generation.
- **Do:** cap rows and run manual pilots before scheduling.
- **Do:** export CSV/JSON and let Hermes analyze the artifact.
- **Do not:** make it a core Hermes data layer until API/query/provenance surfaces are stable and operational cost is measured.

## Pilot Template

Success criteria:
- Dataset has 10-20 useful rows.
- Sources are credible and traceable enough for the report class.
- Runtime and API cost are acceptable.
- Output is easy for Hermes to consume as CSV/JSON.
- No long-running daemon is left behind without a clear owner.

Suggested command shape:

```bash
bigset create "<dataset prompt>" --rows 10 --wait --csv /tmp/<dataset>.csv
```

Then have Hermes read and critique the exported artifact before any cron or profile integration.
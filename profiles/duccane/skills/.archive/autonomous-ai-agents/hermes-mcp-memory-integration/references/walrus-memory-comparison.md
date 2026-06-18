# Walrus Memory vs Lemma — Comparison & Integration Notes

> Source: https://docs.wal.app/walrus-memory/getting-started/what-is-walrus-memory
> Analyzed: 2026-06-10

## Key Findings

### Lemma Already Has Vector Infrastructure
- `memory_vectors`, `memory_vectors_chunks`, `memory_vectors_info` tables exist in `~/.lemma/lemma.db`
- `dist/intelligence/semantic.js` implements TF-IDF + cosine similarity search
- `vec0` SQLite extension is NOT loaded — vector search tables are created but not functional
- To activate: install `sqlite-vec` npm package and rebuild Lemma

### Walrus Memory (Beta) Advantages
- Vector embeddings (sentence-transformers) — stronger semantic search than TF-IDF
- Cross-agent portability — memory travels across agents/apps
- Decentralized storage (Walrus + Sui blockchain)
- End-to-end encryption (Seal)
- Onchain ownership & delegate access

### Lemma Advantages Over Walrus
- Confidence scoring (0-1, auto-updating)
- Knowledge pipeline (fact → pattern → guide → skill distillation)
- Conflict detection (automatic)
- Proactive analysis (suggestions)
- Relations graph (supports/contradicts/supersedes/related_to)
- Stable/production (Walrus is Beta)
- No blockchain dependency

## Integration Roadmap

1. **Immediate:** Activate `sqlite-vec` + embedding model in Lemma for hybrid search (TF-IDF + vectors)
2. **Medium-term:** Agent-to-agent memory sharing via lemma export/import
3. **Long-term:** Walrus Memory v1.0 integration for portability layer

## Walrus Memory Operations
- **Remember** — Store with semantic understanding (vector embeddings)
- **Recall** — Natural language query, meaning-based retrieval
- **Analyze** — Extract structured facts from text
- **Ask** — Query memories + LLM reasoning

## Walrus Infrastructure
- End-to-End Encryption via Seal
- Decentralized Storage on Walrus
- Programmable Permissions via Sui smart contracts
- Delegate Access managed onchain

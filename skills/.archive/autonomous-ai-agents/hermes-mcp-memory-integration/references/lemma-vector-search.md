# Lemma Vector Search — Setup & Usage

> Created: 2026-06-10
> Status: Active, verified at 34/34 fragments embedded after sync

## Architecture

- **Model:** `all-MiniLM-L6-v2` (384-dim, ~80MB, runs on CPU)
- **Storage:** `memory_embeddings` table in `~/.lemma/lemma.db` (BLOB, float32)
- **Search:** Cosine similarity over stored embeddings
- **Script:** `~/.hermes/scripts/lemma_vector_search.py`

## Setup (one-time)

```bash
# Create venv and install
cd /tmp && python3 -m venv lemma-vec
source lemma-vec/bin/activate
pip install sentence-transformers

# Initial sync (embed all fragments)
python3 ~/.hermes/scripts/lemma_vector_search.py sync
```

## Usage

```bash
source /tmp/lemma-vec/bin/activate

# Search
python3 ~/.hermes/scripts/lemma_vector_search.py search "AI agent orchestration" --top-k 5

# Re-sync after new fragments added
python3 ~/.hermes/scripts/lemma_vector_search.py sync

# Check status
python3 ~/.hermes/scripts/lemma_vector_search.py status
```

## How It Works

1. Each memory fragment's `title + fragment + description` is embedded via sentence-transformers
2. Embeddings stored as float32 BLOB in `memory_embeddings` table
3. Query is embedded with same model
4. Cosine similarity computed against all stored embeddings
5. Top-K results returned with scores

## Hybrid Search (TF-IDF + Vector)

For best results, combine both:
- **TF-IDF** (Lemma's built-in `semantic_search`): Good for keyword matches
- **Vector** (this script): Good for semantic/conceptual matches
- **Combined:** Use TF-IDF for exact terms, vector for meaning-based queries

## Maintenance

- Run `sync` after adding new memory fragments; status should show memory count and embedding count equal, e.g. `34/34` after the June 2026 sync.
- Model downloads on first run (~80MB to `~/.cache/huggingface/`)
- No `sqlite-vec` or `vec0` extension needed — pure Python + SQLite BLOB
- If SQLite reports `no such module: vec0`, do not treat vector search as blocked; use the BLOB-backed `memory_embeddings` path and cosine-similarity script.

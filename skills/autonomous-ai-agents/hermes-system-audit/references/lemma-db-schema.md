# Lemma DB Schema (for audit/maintenance scripts)

## Location
`~/.lemma/lemma.db` — SQLite database.

## Critical: Table name is `memories`, NOT `fragments`

The main table is `memories`. Do NOT query `fragments` (does not exist → `OperationalError`).

## vec0 Module Issue

Opening the DB with plain `sqlite3.connect()` and querying vector tables may fail with
`no such module: vec0`. This is expected — the vector tables (memory_vectors*) use a
SQLite extension loaded by the Lemma MCP server process. For audit scripts, query only
the standard tables listed below.

## Key Tables

| Table | Purpose | Key Columns |
|---|---|---|
| `memories` | Fragments (facts, patterns, lessons, etc.) | id, title, fragment, type, confidence, project, source, access_count, created_at |
| `guides` | Procedural skills (distilled) | — |
| `relations` | Graph edges between memories | source_id, target_id |
| `guide_contexts` | Contexts where a guide was applied | — |
| `guide_learnings` | Learnings accumulated per guide | — |
| `sessions` | Traced work sessions | — |
| `feedback_log` | Memory feedback (positive/negative) | — |

## Fragment Types (observed)
- `context` (typically the largest count)
- `fact`
- `lesson`
- `pattern`
- `warning`

## Audit Query Patterns

```python
import sqlite3

conn = sqlite3.connect('~/.lemma/lemma.db')
c = conn.cursor()

# Fragment count + breakdown by type
total = c.execute("SELECT COUNT(*) FROM memories").fetchone()[0]
types = c.execute("SELECT type, COUNT(*) FROM memories GROUP BY type ORDER BY COUNT(*) DESC").fetchall()

# Average confidence
avg = c.execute("SELECT AVG(confidence) FROM memories WHERE confidence IS NOT NULL").fetchone()[0]

# Low confidence fragments
low = c.execute("SELECT COUNT(*) FROM memories WHERE confidence IS NOT NULL AND confidence < 0.5").fetchone()[0]

# Orphan fragments (no relations)
orphans = c.execute("""
    SELECT COUNT(*) FROM memories m
    WHERE m.id NOT IN (SELECT source_id FROM relations WHERE source_id IS NOT NULL)
    AND m.id NOT IN (SELECT target_id FROM relations WHERE target_id IS NOT NULL)
""").fetchone()[0]

# Potential duplicates (same title)
dups = c.execute("""
    SELECT title, COUNT(*) as cnt FROM memories
    WHERE title IS NOT NULL AND title != ''
    GROUP BY title HAVING cnt > 1 LIMIT 5
""").fetchall()

# Guide count
guides = c.execute("SELECT COUNT(*) FROM guides").fetchone()[0]
```

## Verified Stats (2026-06-22)
- 121 fragments, 27 guides
- Avg confidence: 1.00
- Types: context(76), fact(15), lesson(13), pattern(10), warning(7)
- Orphans: 13, Duplicates: 0

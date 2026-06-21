# RSS Feed Directory — Tech News Fallback

Use when `web_search`/`web_extract` tools fail. Fetch with `curl -s "<url>" | grep -oP '<title>\K[^<]+' | head -N`.

## AI / ML

| Source | URL |
|--------|-----|
| TechCrunch AI | `https://techcrunch.com/category/artificial-intelligence/feed/` |
| TechCrunch | `https://techcrunch.com/feed/` |
| Hacker News (AI) | `https://hnrss.org/newest?q=AI+OR+agent+OR+LLM` |
| Hacker News (SEO) | `https://hnrss.org/newest?q=SEO+OR+search+OR+google` |
| arXiv (AI) | `https://export.arxiv.org/api/query?search_query=cat:cs.AI&sortBy=submittedDate&sortOrder=descending&max_results=10` |
| arXiv (CL) | `https://export.arxiv.org/api/query?search_query=cat:cs.CL&sortBy=submittedDate&sortOrder=descending&max_results=10` |
| The Verge AI | `https://www.theverge.com/ai-artificial-intelligence/rss/index.xml` |
| VentureBeat AI | `https://venturebeat.com/category/ai/feed/` |

## Web / SEO / Marketing

| Source | URL |
|--------|-----|
| Search Engine Journal | `https://www.searchenginejournal.com/feed/` |
| Moz Blog | `https://moz.com/blog/feed` |
| Google Search Central | `https://developers.google.com/search/blog/rss.xml` |
| Ahrefs Blog | `https://ahrefs.com/blog/feed/` |

## Turkish Tech

| Source | URL |
|--------|-----|
| Webtekno | `https://www.webtekno.com/rss.html` |
| Chip Online | `https://www.chip.com.tr/rss/` |
| Technopat | `https://www.technopat.net/feed/` |

## Usage Pattern

```bash
# Fetch top 10 AI news titles
curl -s "https://techcrunch.com/category/artificial-intelligence/feed/" | grep -oP '<title>\K[^<]+' | head -10

# Fetch HN AI stories
curl -s "https://hnrss.org/newest?q=AI+OR+agent" | grep -oP '<title>\K[^<]+' | head -10
```

Note: RSS gives titles only. For full content, use `web_extract` on individual article URLs when tools are available.

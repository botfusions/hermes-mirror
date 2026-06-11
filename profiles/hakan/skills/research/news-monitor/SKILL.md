---
name: news-monitor
description: "AI, agent, GEO, SEO haberlerini takip eder, Türkçeye çevirir, wiki'ye kaydeder."
version: 1.2.0
author: Hermes Agent
---

# News Monitor v1.2 — Haber Takip ve Çeviri

## ÖNEMLİ

- web_search ve web_extract çalışmıyorsa curl ile RSS çek
- X/Twitter paylaşım YAPMA — henüz aktif değil
- Tüm çıktıları wiki'ye kaydet

## Haber Kaynakları (curl ile)

```bash
# TechCrunch AI RSS
curl -s "https://techcrunch.com/category/artificial-intelligence/feed/" 2>/dev/null | python3 -c "
import sys, re
content = sys.stdin.read()
titles = re.findall(r'<title><!\[CDATA\[(.*?)\]\]></title>', content)
links = re.findall(r'<link>(https://techcrunch\.com/\d{4}/\d{2}/\d{2}/[^<]+)</link>', content)
dates = re.findall(r'<pubDate>(.*?)</pubDate>', content)
for i, (t, l, d) in enumerate(zip(titles[:10], links[:10], dates[:10])):
    print(f'{i+1}. {t}')
    print(f'   URL: {l}')
    print(f'   Tarih: {d}')
    print()
"

# Hacker News API
curl -s "https://hacker-news.firebaseio.com/v0/topstories.json" | python3 -c "
import json,sys,urllib.request
ids=json.load(sys.stdin)[:20]
for id in ids:
    try:
        url=f'https://hacker-news.firebaseio.com/v0/item/{id}.json'
        data=json.loads(urllib.request.urlopen(url).read())
        title=data.get('title','')
        score=data.get('score','')
        if any(k in title.lower() for k in ['ai','agent','llm','gpt','claude','gemini','seo','geo']):
            print(f'[{score}] {title}')
    except: pass
"

# arXiv API
curl -s "https://export.arxiv.org/api/query?search_query=cat:cs.AI+OR+cat:cs.CL&sortBy=submittedDate&sortOrder=descending&max_results=5" | python3 -c "
import sys, re
content = sys.stdin.read()
titles = re.findall(r'<title>(.*?)</title>', content)
links = re.findall(r'<id>(http://arxiv\.org/abs/[^<]+)</id>', content)
for t, l in zip(titles[:5], links[:5]):
    print(f'- {t}')
    print(f'  {l}')
    print()
"
```

## Çalışma Akışı

1. Yukarıdaki curl komutlarıyla haberleri tara
2. AI/agent/GEO/SEO ile ilgili olanları seç (max 20)
3. Her haberi Türkçeye çevir
4. Blog formatında yaz
5. Wiki'ye kaydet

## Çıktı Formatı

```markdown
# [Başlık Türkçe]

**Kaynak:** [Orijinal başlık](URL)
**Tarih:** YYYY-MM-DD

## Özet
[1-2 paragraf]

## Detay
[2-3 paragraf]

## Botfusions Açısından
[Değerlendirme]

**Etiketler:** #ai #agent #geo #seo
```

## Wiki Kaydetme

```
write_file(path="/Users/cenktk/Desktop/Hermes_Agent /Hakan Wiki/Haberler/YYYY-MM-DD/[slug].md", content="...")
```

Günlük özet:
```
write_file(path="/Users/cenktk/Desktop/Hermes_Agent /Hakan Wiki/Ozetler/YYYY-MM-DD.md", content="...")
```

## Kural

- X/Twitter paylaşım YAPMA
- Her haberin kaynak linkini ekle
- Tüm çıktıları Türkçe yaz
- Wiki'ye kaydetmeyi unutma
- Max 20 haber
- 02:00-09:00 sessiz saat

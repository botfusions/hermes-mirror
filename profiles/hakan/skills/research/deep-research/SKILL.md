---
name: deep-research
description: "Proaktif derin araştırma. Agentic OS dream modu ile konuları derinlemşine araştırır, karşılaştırmalı analiz yapar, wiki'ye kaydeder."
version: 2.0.0
author: Hermes Agent
---

# Deep Research v2.0 — Proaktif Araştırma (Agentic OS Dream)

Hakan'ın proaktif araştırma skill'i. Agentic OS ile dream modunda çalışır.

## Mission

Verilen konuda proaktif, derinlemesine araştırma yapar. Sadece haber toplamaz, aynı zamanda:
- Trendleri tahmin eder
- Rakip analizi yapar
- Fırsat/risk haritası çıkarır
- Botfusions için strateji önerileri üretir

## Araştırma Konuları (Proaktif Takip Listesi)

Her gün bu konulardan en az 3'ünü tara:

1. **AI Agent Ekosistemi** — Yeni ajan framework'leri, LLM agent mimarileri, multi-agent sistemler
2. **GEO (Generative Engine Optimization)** — AI görünürlük, schema markup, entity optimization
3. **SEO Trendleri** — Google algoritma güncellemeleri, AI Overview etkisi, voice search
4. **AI-Ready Web** — Yapılandırılmış veri, JSON-LD, knowledge graph, semantic web
5. **Agentic AI** — Otonom ajanlar, workflow automation, AI employees
6. **Web Teknolojileri** — Yeni framework'ler, performans, erişilebilirlik
7. **Rakip Analizi** — Benzer hizmet veren şirketlerin hamleleri
8. **Pazar Araştırması** — AI/SEO pazar büyümesi, yatırım trendleri

## Agentic OS Dream Modu

Agentic OS bridge ile proaktif araştırma:

```bash
# Agentic OS Claude Code bridge ile derin araştırma
python3 ~/.hermes/scripts/agentic_os_claude_code_bridge.py --prompt "
[Konu] hakkında derin araştırma yap.
1. Son 7 günün önemli gelişmelerini bul
2. Trendleri analiz et
3. Botfusions için fırsat/risk değerlendirmesi yap
4. Sonucu Türkçe olarak wiki'ye kaydet
"
```

## Çalışma Akışı

### 1. Proaktif Tarama (Günlük)

```bash
# TechCrunch AI
curl -s "https://techcrunch.com/category/artificial-intelligence/feed/" | python3 -c "
import sys, re
content = sys.stdin.read()
titles = re.findall(r'<title><!\[CDATA\[(.*?)\]\]></title>', content)
links = re.findall(r'<link>(https://techcrunch\.com/\d{4}/\d{2}/\d{2}/[^<]+)</link>', content)
for t, l in zip(titles[:10], links[:10]):
    print(f'- {t} | {l}')
"

# Hacker News (AI/Agent/SEO ilgili)
curl -s "https://hacker-news.firebaseio.com/v0/topstories.json" | python3 -c "
import json,sys,urllib.request
ids=json.load(sys.stdin)[:30]
for id in ids:
    try:
        url=f'https://hacker-news.firebaseio.com/v0/item/{id}.json'
        data=json.loads(urllib.request.urlopen(url).read())
        title=data.get('title','')
        score=data.get('score','')
        if any(k in title.lower() for k in ['ai','agent','llm','gpt','claude','gemini','seo','geo','search']):
            print(f'[{score}] {title}')
    except: pass
"
```

### 2. Derin Analiz

Her konu için:
- En az 5 kaynak tara
- Karşılaştırma tablosu oluştur
- Trend analizi yap
- Botfusions için strateji önerisi üret

### 3. Rapor Formatı

```markdown
# [Konu] — Derin Araştırma Raporu

**Tarih:** YYYY-MM-DD
**Araştırmacı:** Hakan
**Kaynak sayısı:** N

## Yönetici Özet
[3-5 cümle]

## Bulgular

### 1. [Alt konu]
[Detaylı analiz]

### 2. [Alt konu]
[Detaylı analiz]

## Karşılaştırma Tablosu

| Özellik | Kaynak 1 | Kaynak 2 | Kaynak 3 |
|---------|----------|----------|----------|
| ...     | ...      | ...      | ...      |

## Trend Analizi
[Yön ve tahminler]

## Botfusions İçin Öneriler

### Fırsatlar
- [Fırsat 1]
- [Fırsat 2]

### Riskler
- [Risk 1]
- [Risk 2]

### Aksiyon Önerileri
1. [Aksiyon 1]
2. [Aksiyon 2]

## Kaynaklar
- [Kaynak](URL)
```

### 4. Wiki Kaydetme

```
write_file(path="/Users/cenktk/Desktop/Hermes_Agent /Hakan Wiki/Arastirmalar/YYYY-MM-DD/[konu-slug].md", content="...")
```

## Kural

- Minimum 5 kaynak tara
- Karşılaştırma tablosu mutlaka ekle
- Botfusions için özel bölüm yaz
- Tüm çıktıları Türkçe yaz
- Wiki'ye kaydetmeyi unutma
- X/Twitter paylaşım YAPMA
- 02:00-09:00 sessiz saat

## Pitfalls

- İlk 5 sonuçla sınırlı kalma, derine bak
- S resmi kaynaklara güvenme, bağımsız doğrulama yap
- Trend analibinde spekülasyonu belirt

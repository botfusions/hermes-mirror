---
name: xai-grok-research
description: XAI Grok API ile araştırma ve ilgi takip listesi. Server-side web_search, x_search, code_execution, image/video generation, TTS/STT. Hakan araştırma ajansı için optimize edilmiştir.
---

# XAI Grok Research Skill

## Amacı
XAI (Grok) provider'ının tüm özelliklerini kullanarak araştırma yapmak, ilgi alanlarındaki gelişmeleri takip etmek ve wiki'ye kaydetmek.

## XAI Özellik Matrisi

| Özellik | Model/Tool | Hakan Kullanımı |
|---------|-----------|-----------------|
| Chat/Responses | `xai/grok-4.3` | Haber analizi, çeviri, özet |
| Server-side web search | `web_search provider grok` | Haber tarama (curl fallback ile) |
| Server-side X search | `x_search tool` | X'te AI/agent/SEO konu takibi |
| Code execution | `code_execution tool` | Veri analizi, script çalıştırma |
| Image generation | `image_generate` | Görsel oluşturma |
| Video generation | `video_generate` | Video oluşturma |
| Text-to-speech | `tts provider: "xai"` | Sesli özet |
| Speech-to-text | `media audio` | Transkripsiyon |

## Model Seçimi

| Görev | Model | Neden |
|-------|-------|-------|
| Haber tarama + çeviri | `grok-4.3` | Genel chat, yeterli |
| Derin araştırma | `grok-4.3` (uzun context) | Detaylı analiz |
| Build/coding | `grok-build-0.1` | Kod odaklı |
| Hızlı tarama | `grok-4-fast` | Daha hızlı, düşük maliyet |

## İlgi Takip Listesi (Max 20 Konu)

1. **AI Agents** — Yeni AI agent framework'leri, agentic AI gelişmeleri
2. **GEO (Generative Engine Optimization)** — AI motorları için içerik optimizasyonu
3. **SEO** — Arama motoru optimizasyonu, Google algoritma güncellemeleri
4. **LLM Gelişmeleri** — Yeni modeller, benchmark sonuçları, açık kaynak LLM'ler
5. **AI-Ready Web** — Web sitelerinin AI için hazırlanması, yapılandırılmış veri
6. **Schema Markup** — Yapılandırılmış veri, JSON-LD, rich snippets
7. **Programmatic SEO** — Otomatik SEO, bölgesel/çoklu sayfa stratejileri
8. **Content Strategy** — AI destekli içerik üretimi, içerik kalitesi
9. **Botfusions Rekabeti** — Rakip analizi, pazar hareketleri
10. **AI Search** — Perplexity, Google AI Overview, Bing Copilot
11. **Web Scraping & Data** — AI için veri toplama, crawling
12. **MCP (Model Context Protocol)** — Agent tool standartları
13. **Open Source AI** — Açık kaynak AI projeleri, topluluk gelişmeleri
14. **AI Regulation** — AI düzenlemeleri, yasal gelişmeler
15. **Social Media & AI** — X, LinkedIn, Instagram AI entegrasyonları
16. **Marketing Automation** — AI destekli pazarlama araçları
17. **Conversational AI** — Chatbot, voice AI, multimodal AI
18. **AI Infrastructure** — GPU, cloud AI, edge AI
19. **Turkish Tech** — Türkiye teknoloji ekosistemi, yerli AI projeleri
20. **No-Code/Low-Code AI** — AI builder araçları, otomasyon platformları

## Araştırma Workflow

### 1. Haber Tarama (Günlük - 10:00 TSI) — Max 10 Haber
```bash
# RSS fallback (web_search çalışmazsa)
curl -s "https://techcrunch.com/feed/" | grep -oP '<title>\K[^<]+' | head -10
curl -s "https://hnrss.org/newest?q=AI+OR+agent+OR+SEO" | grep -oP '<title>\K[^<]+' | head -10
```

### 2. X Araştırması / Twitter Dream (Günlük - 12:00 TSI) — Max 20 Tweet
- `x_search` ile AI/agent/SEO konularında tweet ara
- Trending konuları tespit et
- Önemli kişilerin paylaşımlarını takip et
- **X paylaşımı YAPILMAZ** (banlı hesap)

### 3. Derin Araştırma (Haftalık Pazartesi - 11:00 TSI)
- Minimum 5 kaynak
- Karşılaştırmalı analiz
- Botfusions için fırsat/risk/aksiyon
- Wiki'ye kaydet

## X Search Kullanım Alanları

| Arama Türü | Query Örneği | Amaç |
|-------------|-------------|------|
| AI Agent | `"AI agent" OR "agentic AI"` | Yeni agent framework'leri |
| GEO | `"GEO" OR "generative engine optimization"` | GEO gelişmeleri |
| SEO | `"SEO" OR "search engine optimization"` | SEO güncellemeleri |
| LLM | `"new LLM" OR "language model release"` | Yeni model duyuruları |
| Botfusions | `"Botfusions"` | Marka mentions |
| Turkish Tech | `"Türkiye" AND ("AI" OR "yapay zeka")` | Yerli gelişmeler |

## Kurallar
- Tüm çıktılar Türkçe
- Kaynak linkleri mutlaka ekle
- 02:00-09:00 arası sessiz saat
- Bilmediğini söyle, spekülasyon yapma
- X paylaşımı YAPILMAZ
- Her çıktıyı wiki'ye kaydet
- Haber tarama: max 10 haber
- Twitter dream: max 20 tweet

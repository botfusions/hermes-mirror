---
name: deep-research-zai
description: "ZAI/GLM uyumlu derin web araştırma skilli. Sadece Hermes native araçlar (web_search, web_extract, terminal) kullanır. Dış API key gerekmez (Google, OpenAI, Gemini yok). Çok adımlı araştırma, kaynak toplama, sentez ve Türkçe Markdown rapor üretimi yapar. Hakan ve Hayri profilleri için tasarlanmıştır."
---

# Deep Research ZAI

ZAI/GLM sağlayıcısı (glm-4.7 veya glm-5.2) ile çalışan, sıfır dış-bağımlılıklı derin web araştırma skilli.
Yalnızca Hermes yerleşik araçlarını kullanır: `web_search`, `web_extract`, `terminal`.

## Misyon

Verilen bir konuda çok adımlı web araştırması yapıp, kaynak linkleriyle desteklenen
yapılandırılmış Türkçe Markdown rapor üretmek.

## Araç Gereksinimleri

- `web_search` — genel ve hedefli aramalar
- `web_extract` — kaynak URL'lerden içerik çıkarma
- `terminal` — dosya kaydetme, tarih/saat, yardımcı işlemler
- Hiçbir dış API key gerekmez (Google API, OpenAI API, Gemini API kullanılmaz)

## Çalışma Adımları

### Adım 1: Konuyu Tanımla

Araştırma konusunu veya sorusunu netleştir. Şunları belirle:
- Ana konu başlığı
- Alt konular (3-5 adet)
- Hedef çıktı formatı (kısa özet / detaylı rapor / karşılaştırma)
- Hedef kitle (teknik / genel)

### Adım 2: İlk Tarama — Peyzajı Haritala

Konuyla ilgili geniş bir `web_search` sorgusu çalıştır:
- Anahtar kelimelerle 2-3 farklı sorgu dene
- Sonuçları tara: hangi kaynaklar değerli?
- Alt konuları ve boşlukları tanımla
- Maksimum 10 kaynak işaretle

### Adım 3: Derin Dalış — Hedefli Aramalar

Her alt konu için ayrı `web_search` sorguları çalıştır:
- Spesifik terimler, kullanıcı senaryoları, teknik detaylar
- Türkçe ve İngilizce sorgular karıştır
- Her alt konu için 3-5 kaliteli kaynak topla
- Toplamda 15-30 kaynak hedefle

### Adım 4: İçerik Çıkarımı

`web_extract` ile işaretlenen kaynaklardan içerik çıkar:
- En değerli 8-12 kaynağı seç (max 5 URL per web_extract çağrısı)
- Çıkarılan içeriği tara, önemli bulguları not et
- Çelişkili bilgileri işaretle
- Her bulguya kaynak URL'sini eşle

### Adım 5: Sentez ve Doğrulama

Toplanan bilgileri sentezle:
- Benzer bulguları grupla
- Çelişkileri çöz: ek arama yap veya her iki görüşü de sun
- Güvenilirlik kontrolü: resmi kaynaklar, birincil kaynaklar öncelikli
- İstatistik/tarih/iddiaları doğrula

### Adım 6: Rapor Yazımı

Türkçe Markdown raporu üret. Rapor yapısı `references/report-template.md` dosyasındaki şablonu takip et.

Rapor şu bölümleri içermelidir:
1. Başlık ve özet (3-5 cümle)
2. Yöntem (hangi kaynaklar, kaç adım)
3. Ana bulgular (alt başlıklar halinde)
4. Tablo veya liste özetleri (uygun olduğunda)
5. Çıkarımlar ve öneriler
6. Tüm kaynak linkleri (numaralı liste)

### Adım 7: Kaydet ve Teslim Et

Raporu uygun wiki dizinine kaydet:
- Hakan profili: `/Users/cenktk/Desktop/Hermes_Agent /Hakan Wiki/`
- Hayri profili: `/Users/cenktk/Desktop/Hermes_Agent /Analizler/Hayri/`
- Genel: çalışma dizininde `arastirma-<konu>-<tarih>.md`

`terminal` ile dosyayı yaz ve yolunu raporla.

## Kalite Kuralları

- Her iddia bir kaynak linkiyle desteklenmeli
- Kaynaklar numaralandırılmalı ve rapor sonunda listelenmeli
- Türkçe yaz; teknik terimleri orijinal haliyle parantez içi ekle
- En az 8 farklı kaynak kullan
-Öznel yorumu minimumda tut, kanıta dayalı yaz
- Tarih ve istatistikleri kaynaklarından doğrula

## Sınırlar

- Dış API kullanma: Google Search API, OpenAI, Gemini, Serper vb. YOK
- Sadece web_search, web_extract, terminal araçları
- Provider: zai (GLM glm-4.7 veya glm-5.2)
- Maksimum 30 kaynak (API tasarrufu için)
- Her web_extract çağrısında maksimum 5 URL

## Kaynaklar

- Rapor şablonu: `references/report-template.md`
- Örnek sorgu kalıpları: `references/query-patterns.md`

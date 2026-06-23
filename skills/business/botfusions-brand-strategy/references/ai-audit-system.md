# AI Hazırlık Denetimi — Audit Sistemi

**Tarih:** 22 Haziran 2026
**Framework:** Anthropic Enterprise AI Adoption (SMB'ye uyarlanmış)

## Senaryo

GEO içeriği door-opener → müşteri "AI hazırlığımız nasıl?" → audit → pilot → managed services.

## Dosyalar

### 1. Excel v2 (9 sayfa)
**Dosya:** `Botfusions_AI_Denetim_Soru_Cercevesi_v2.xlsx`
**Orijinal:** `Botfusions_AI_Denetim_Soru_Cercevesi_ORIGINAL.xlsx`

#### Sayfa Yapısı
| # | Sayfa | İçerik |
|---|---|---|
| 1 | Üst Yönetim | 13 soru — stratejik anlayış, AI vizyonu, rakip analizi |
| 2 | Orta Kademe | 10 soru — süreç, kaynak, karar süreci |
| 3 | Veri & Güvenlik | Veri formatı, API erişimi, KVKK |
| 4 | Web & GEO | AI aramada görünürlük, ChatGPT'de sorgulama |
| 5 | Sektörel | Klinik/fabrika/hukuk/muhasebe/e-ticaret özel soruları |
| 6 | Değerlendirme Matrisi | Öncelik × Kolaylık × ROI + AI uygunluğu |
| 7 | **AI Hazırlık Skoru** (YENİ) | 10 kriter × 5 seviye, Level 1-3 otomatik hesaplama |
| 8 | **Pilot Uygunluk** (YENİ) | 7 Anthropic kriteri (LLM uyumu, ölçülebilirlik, ROI, düşük risk) |
| 9 | **Metrik Sütunu** (YENİ) | Saat/ay tasarruf, TL/ay, ölçüm yöntemi, AI uygunluğu |

#### Excel v1 → v2 Farkı
v1 (orijinal) eksiklikleri:
- AI hazırlık seviyesi ölçülmüyor (Level 1-3 yok)
- Veri altyapısı yüzeysel
- Başarı metrikleri tanımlanmamış (sadece öncelik 1-5)
- Güvenlik/KVKK derinliği yok
- Pilot seçim kriterleri yok

v2 bu 5 eksikliği kapatarak "işinizde sorun var" anketinden → "AI çözer mi, hazır mısınız, ne kazandırır" denetim aracına dönüşüyor.

### 2. Google Form (Apps Script)
**Dosya:** `Botfusions_AI_Denetim_Google_Form.js`

#### Kurulum
1. `script.google.com` → New Project
2. JS dosyasının içeriğini yapıştır
3. Run → `createAuditForm()`
4. Google izinleri (Forms yetkisi ver)
5. Logger'da form linki çıkar

#### Form İçeriği
15 bölüm, 50+ soru:
- Şirket bilgileri, stratejik anlayış, kaynak & bütçe
- Veri & güvenlik, insan kaynağı, süreç analizi
- İletişim & araçlar, web & GEO
- AI Hazırlık Skoru (8 kriter × 1-5)
- Rakip & sonuç, iletişim tercihi

Cevaplar otomatik Google Sheets'e düşer.

## Anthropic 4-Aşama Framework'ü (SMB Adaptasyonu)

| Anthropic Aşaması | Enterprise'da | SMB'de (Botfusions) |
|---|---|---|
| **1. Strateji** | C-suite uyum, yönetişim kurulu | CEO karar verici = kendisi, 4-6 hafta |
| **2. İş Değeri** | Fortune 500 bütçeleri | 15-30K TL audit → pilot teklifi |
| **3. Üretim** | AWS+Bedrock, LLMOps | No-code/low-code, Hermes benzeri agent |
| **4. Dağıtım** | 13+ aylık dönüşüm | 4-6 hafta pilot → managed |

### Anthropic'in Seviyeleri
- **Seviye 1:** Basit sohbet (chatbot) — zaten geçtik
- **Seviye 2:** RAG + araç entegrasyonu — zaten var
- **Seviye 3:** Agent tabanlı, multi-tool, memory, self-healing — **BURADAYIZ**

Botfusions'in teknik olgunluğu = Level 3. Bu, satılabilir "proof of work."

## Fiyatlandırma

| Hizmet | Fiyat | Cenk'in zamanı |
|---|---|---|
| Audit (tek sefer) | 15-30K TL | 2-3 saat |
| Pilot (4-6 hafta) | 50-150K TL | Orta seviye |
| Managed (aylık) | 10-30K TL/ay | Düşük (operasyonel) |

## Botfusions'in Farklılaştırıcı Avantajları (vs Anthropic+AWS)

1. **Model tarafsızlığı** — tek sağlayıcıya bağlı değil
2. **Türkiye yerel** — dil, kültür, mevzuat bilgisi
3. **Gerçek çalışan demo** — botfusions.com + agent altyapısı
4. **GEO katmanı** — Anthropic'te yok, enterprise framework'lerde yok

## Zayıf Yanlar

- Kurumsal referans yok
- SLA altyapısı yok
- Team yok (solopreneur)

## Audit → Pilot Geçiş Mantığı

1. Müşteri audit'i bitirince doğal olarak "bunu yapalım" der
2. Audit'ten en yüksek ROI'li kullanım alanı seçilir
3. Pilot teklifi: tek kullanım alanı, 4-6 hafta, net sonuç
4. Pilot başarılı → managed services teklifi

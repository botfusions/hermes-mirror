Hermes Telegram access is restricted to TELEGRAM_ALLOWED_USERS=6030287709. Do not enable TELEGRAM_ALLOWED_USERS=*, TELEGRAM_ALLOW_ALL_USERS=true, or GATEWAY_ALLOW_ALL_USERS=true unless the user explicitly changes this security rule.
§
Workspace: /Users/cenktk/Desktop/Hermes_Agent (clean, NO trailing space). Merged 2026-06-22 from dual invisible folders. Obsidian vault + external/lemma + all wikis under one path. REST API :27124. All ~/.hermes/scripts/ paths fixed. Hermes v0.17.0. Skill bundles: /botfusions-ops, /geo-audit, /triyaj.
§
Agent routing: Ben=GPT-5.5/koordinasyon, Timuçin=GLM-5.2/kod, Düccane=Gemma-12B(LM Studio)/içerik, Hayri=GLM-4.7/araştırma, Güngör=GLM-5.2/triyaj, Hakan=Grok-4/X. Custom skill'ler İngilizce yazılır, çıktılar Türkçe olur. GLM-5.1 tamamen glm-5.2'ye yükseltildi (config auxiliary + script'ler); glm-4.7 yerinde kalır.
§
Lemma MCP primary (DB ~/.lemma/lemma.db). Composio CLI v0.2.31 (~/.composio/, browser auth). 2 Gmail ACTIVE: botfusionss + cenk.tokgoz. MCP transport fails all endpoints; use `composio execute` CLI. Skill: composio-gmail-cli.
§
Security boundaries: Güngör=Gmail/GitHub triage + limited local fixes, no external writes (send/delete/label Gmail, comment/approve/merge/push GitHub) without explicit Turkish approval. Orkun VPS=read-only Coolify health monitoring only, no SSH/intervention — deliberate.
§
When user pastes links/repos + "analiz", route to Hayri (hayri-analysis-router skill). Reports to /Users/cenktk/Desktop/Hermes_Agent/Analizler/Hayri/. Telegram on completion.
§
Botfusions: GEO pages = door-opener for AI Hazırlık Denetimi (audit) → pilot → managed services. Audit: Anthropic 4-stage adapted for Turkish SMB, Excel v2 (9 sheets) + Google Form (Apps Script). Strategy docs in Botfusions/Çözümler/ as "çözüm.md": Küçük Acı Büyük Para + Satın Alma Sinyali (Maps/yorum/DM signal vs cold leads). Files: Botfusions_AI_Denetim_*.{xlsx,js} + Botfusions/Çözümler/*.md.
§
GPT-5.5 compact: compression.threshold=0.37 (~100K/272K), codex_gpt55_autoraise=false. Telegram streaming off (display.platforms.telegram.streaming=false), rich final kept.
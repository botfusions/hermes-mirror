# Gmail Inbox Categorization Reference

Reference implementation for categorizing and reporting a Gmail inbox via Composio CLI.
Used by `composio-gmail-cli` skill's "Categorize & Report Inbox" protocol.

## Full Python Implementation

```python
import subprocess, json, sys
from email.utils import parsedate_to_datetime

# 1. Fetch
cmd = ['composio', 'execute', 'GMAIL_FETCH_EMAILS', '-d', '{ max_results: 60 }']
r = subprocess.run(cmd, capture_output=True, text=True, timeout=30,
    env={**dict(__import__('os').environ),
         'PATH': f"{__import__('os').path.expanduser('~/.composio')}:{__import__('os').environ.get('PATH','')}"})
raw = json.loads(r.stdout)

if not raw.get('successful'):
    print("HATA:", raw.get('error'))
    sys.exit(1)

# 2. Read from file if storedInFile
fpath = raw.get('outputFilePath')
if not fpath:
    print("outputFilePath yok")
    sys.exit(1)
with open(fpath) as f:
    d = json.load(f)
msgs = d.get('data', {}).get('messages', [])

# 3. Categorize
categories = {
    'fatura': [],
    'bildirim_github_bot': [],
    'bildirim_servis': [],
    'is': [],
    'kisisel': [],
    'pazarlama': [],
    'diger': []
}

for msg in msgs:
    headers = {h['name']: h['value'] for h in msg.get('payload', {}).get('headers', [])}
    frm = headers.get('From', '')
    subj = headers.get('Subject', '')
    date_str = headers.get('Date', '')
    snippet = msg.get('snippet', '')
    label_ids = msg.get('labelIds', [])

    try:
        dt = parsedate_to_datetime(date_str)
        date_fmt = dt.strftime('%d.%m.%Y %H:%M')
    except:
        date_fmt = date_str[:20]

    entry = {
        'from': frm,
        'subject': subj,
        'date': date_fmt,
        'snippet': snippet[:150],
        'unread': 'UNREAD' in label_ids
    }

    lower_from = frm.lower()
    lower_subj = subj.lower()
    lower_snippet = (snippet or '').lower()
    combined = f"{lower_from} {lower_subj} {lower_snippet}"

    # Priority order: check each category
    if any(k in lower_from for k in ['gemini-code-assist', 'chatgpt-codex', 'google-labs-jules', 'dependabot', 'renovate', 'gitguardian']):
        categories['bildirim_github_bot'].append(entry)
    elif any(k in combined for k in ['fatura', 'invoice', 'bill', 'payment', 'ödeme', 'dekont', 'hesap özeti', 'makbuz', 'extract', 'e-fatura']):
        categories['fatura'].append(entry)
    elif any(k in combined for k in ['pinterest', 'facebookmail', 'instagram', 'newsletter', 'bülten', 'kampanya', 'indirim', 'promotion', 'sponsorlu', 'your weekly', 'daily digest', 'marketing', 'unsubscribe', 'mailing list', 'trending', 'you might like', 'discover']):
        categories['pazarlama'].append(entry)
    elif any(k in lower_from for k in ['noreply@', 'notification', 'no-reply', 'github.com', 'jira', 'slack', 'trello', 'vercel', 'netlify', 'docker', 'aws', 'cloud', 'status', 'uptime', 'monitoring', 'deploy', 'security alert', 'otp', 'doğrulama', 'confirmation', 'onay', 'login', 'giriş']):
        categories['bildirim_servis'].append(entry)
    elif any(k in combined for k in ['toplantı', 'meeting', 'invite', 'proje', 'project', 'teklif', 'proposal', 'contract', 'sözleşme', 'müşteri', 'client', 'partner', 'işbirliği', 'kalkınma ajansı', 'development agency', 'başvuru', 'application', 'referans', 'görüşme', 'mülakat', 'interview']):
        categories['is'].append(entry)
    elif any(k in combined for k in ['merhaba', 'selam', 'aile', 'family', 'arkadaş', 'friend', 'teşekkür', 'thanks', 'kutlama', 'celebration', 'doğum günü', 'birthday', 'davetiye', '@hotmail.com', '@yahoo.com', '@icloud.com']):
        categories['kisisel'].append(entry)
    else:
        categories['diger'].append(entry)

# 4. Print report
total = sum(len(v) for v in categories.values())
unread = sum(1 for m in msgs if 'UNREAD' in m.get('labelIds', []))

print("=" * 72)
print(f"  HESAP@GMAIL.COM — GELEN KUTUSU ANALİZİ (son 60 mail)")
print(f"  Toplam: {len(msgs)} mail | Okunmamış: {unread}")
print("=" * 72)

cat_order = [
    ('fatura', '📄 FATURA / ÖDEME'),
    ('bildirim_github_bot', '🤖 GITHUB AI BOT BİLDİRİMLERİ'),
    ('bildirim_servis', '🔔 SERVİS / SİSTEM BİLDİRİMLERİ'),
    ('is', '💼 İŞ / PROFESYONEL'),
    ('kisisel', '👤 KİŞİSEL'),
    ('pazarlama', '📢 PAZARLAMA / BÜLTEN'),
    ('diger', '📦 DİĞER (SINIFLANDIRILMAMIŞ)'),
]

for cat_key, cat_label in cat_order:
    items = categories[cat_key]
    if items:
        print(f"\n  {cat_label} ({len(items)} mail)")
        print("  " + "-" * 66)
        for e in items:
            u = '🔴' if e['unread'] else ' '
            print(f"  [{u}] {e['date']} | {e['from'][:55]}")
            print(f"       {e['subject'][:75]}")
    else:
        print(f"\n  {cat_label} (—)")

print(f"\n{'=' * 72}")
```

## Known Domain Patterns (Cenk's Inbox)

| Gönderen | Kategori | Açıklama |
|---|---|---|
| gemini-code-assist[bot]@github.com | GitHub Bot | 3 bot per PR thread |
| chatgpt-codex-connector[bot]@github.com | GitHub Bot | 3 bot per PR thread |
| google-labs-jules[bot]@github.com | GitHub Bot | 3 bot per PR thread |
| notifications@vercel.com | Servis | Sign-in / deploy notifications |
| noreply@statuspage.io | Servis | Supabase incident reports |
| no-reply@accounts.google.com | Servis | Security alerts |
| messages-noreply@linkedin.com | Servis | LinkedIn connection/recruitment spam |
| pinterest-recommendations@*.pinterest.com | Pazarlama | 6+ subdomains |
| notification@*.facebookmail.com | Pazarlama | Facebook notifications |
| hello@news.railway.app | Diğer | Railway product news — may be relevant |
| robert@omnisocials.com | Diğer | Outbound sales |
| mark.johnson@hirey-growth.com | Diğer | Outbound sales |
| sudarshan@mail.smallest.ai | Diğer | AI tool outreach |

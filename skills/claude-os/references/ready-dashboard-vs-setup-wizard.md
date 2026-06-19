# Ready dashboard vs setup wizard

Use when Agentic OS opens as if it is a fresh install, but the user expects yesterday's saved/ready operator dashboard.

## Symptom

- `http://127.0.0.1:8081/` loads successfully, but the UI shows onboarding/setup instead of the existing dashboard.
- The user may say it is "starting from zero", "sıfırdan başlıyor", or "hazır olan olmalı".

## Root causes seen

1. **Stale wizard marker**: `~/.claude-os/show-wizard` remained from a setup/install run. The dashboard checks `/__just-installed`; if this marker exists, it can force the wizard even when data exists.
2. **Missing localStorage config**: Browser `localStorage` may not contain `claude-os-config` in a new browser/profile/incognito, even though `src/data/live-data.json` contains real aggregate state. The synchronous `useState` initializer for `showSetupModal` checks localStorage and opens the wizard if it's absent.
3. **React Query EMPTY-fallback race** (found 2026-06-18): `useLiveData()` (in `src/lib/use-live-data.ts`) returns an `EMPTY` constant with `isExample: true` before the fetch to `/__live-data` resolves. The synchronous `useState` initializer computes `hasLiveActivity = !isDemoData && totalAssistantMessages > 0` — but on first paint `ld` is still `EMPTY`, so `isDemoData` is `true` and `hasLiveActivity` is `false`. Combined with missing localStorage config, the wizard shows. The async effect that could close the modal only checked `localStorage.getItem("claude-os-config")`, not real activity, and `ld` was not in its dependency array — so even after real data arrived, the modal stayed open.

## Fix pattern

### Step 1 — Delete stale marker if present

```bash
rm -f "$HOME/.claude-os/show-wizard"
```

### Step 2 — Verify live data is real

Check nonzero `summary.totalAssistantMessages` and real activity in `src/data/live-data.json`:

```bash
python3 -c "import json; d=json.load(open('src/data/live-data.json')); print('assistant msgs:', d.get('summary',{}).get('totalAssistantMessages','MISSING')); print('isExample:', d.get('isExample','MISSING'))"
```

### Step 3 — Patch the modal effect (root cause #3)

In `src/routes/index.tsx`, the `checkConfigured` effect inside the `Home` component must close the modal when real activity is detected, not just when localStorage has config. Two changes:

**A. Add real-activity check inside the effect:**

```tsx
const realActivity =
  !(ld?.isExample === true) &&
  Number(ld?.summary?.totalAssistantMessages ?? 0) > 0;

// Close the modal when EITHER localStorage config OR real activity is present
if (configured || realActivity) {
  setShowSetupModal(false);
  // ... existing confetti/just-installed logic ...
}
```

**B. Add `ld` to the effect's dependency array** so it re-runs when `useLiveData()` resolves:

```tsx
}, [forceSetupModal, ld]);  // was: [forceSetupModal]
```

This ensures: first render shows wizard (EMPTY data, no localStorage) → fetch resolves → effect re-runs with real `ld` → `realActivity` is true → modal closes automatically.

### Step 4 — Rebuild and verify

Vite HMR picks up `.tsx` changes automatically in dev mode. For production:

```bash
cd "/Users/cenktk/Desktop/AGENTİC OS/agentic-os"
bun run build
```

### Step 5 — Browser verification

```javascript
// In browser console at http://127.0.0.1:8081
JSON.stringify({
  hasConfig: !!localStorage.getItem('claude-os-config'),
  hasRealActivity: true, // confirmed from live-data.json
  wizardVisible: !!document.querySelector('[class*="setup"]'),
  bodyText: document.body.innerText.substring(0, 200)
})
```

Operational dashboard should show:
- "Good evening/morning. Today at a glance."
- "Mission Control"
- "Your skills"
- "Your memory"
- "Scheduled tasks"

## Do not

- Do not tell the user to redo setup before checking the marker and live data.
- Do not treat missing browser localStorage as proof that the Agentic OS state is gone.
- Do not claim the system is fully ready until the actual URL has been opened or fetched and the ready dashboard state is verified.
- Do not assume the synchronous `useState` initializer alone can prevent the wizard — it runs before `useLiveData()` resolves and will always see `EMPTY`/`isExample: true` on first paint.

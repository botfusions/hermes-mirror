# Agentic OS setup modal: async live-data variant

Use this when Agentic OS has real `src/data/live-data.json` but the browser still shows the setup wizard on a fresh profile or cleared localStorage.

## Symptom

- `~/.claude-os/show-wizard` is absent.
- `src/data/live-data.json` exists and contains real activity (for example `summary.totalAssistantMessages > 0`).
- Browser localStorage lacks `claude-os-config`.
- The dashboard flashes or stays in setup/onboarding even though the operator state is already live.

## Cause

`useLiveData()` can initially return an `EMPTY` object with `isExample: true` while the React Query fetch to `/__live-data` is still in flight. If the setup modal's initial state is computed from that placeholder and the follow-up effect only checks localStorage, the modal can remain open after real data arrives.

## Fix pattern

In the home/dashboard route:

1. Keep the synchronous initializer conservative, but treat non-example live activity as configured.
2. In the setup/configuration effect, compute a real-activity gate after live data resolves:

```ts
const realActivity =
  !(ld?.isExample === true) &&
  Number(ld?.summary?.totalAssistantMessages ?? 0) > 0;

if (configured || realActivity) {
  setShowSetupModal(false);
}
```

3. Ensure the effect re-runs when live data changes, for example:

```ts
}, [forceSetupModal, ld]);
```

## Verification

- Navigate to `http://127.0.0.1:8081/`.
- Confirm operational dashboard content is visible (`Today at a glance`, Mission Control, memory/skills/tasks).
- In browser console, a fresh localStorage can have `claude-os-config` absent while the wizard remains hidden because real activity is present.

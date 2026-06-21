# Self-Healing Test Loop Pattern

## Context

Adapted from the Anti-gravity IDE's "Self-Healing" concept (AI tests code on Chrome, detects errors, auto-fixes) and the Agent Loops pattern (observe → think → act → observe → repeat). Applied to Hermes coding agent profiles as an opt-in capability.

## Anti-gravity FLOW Comparison

Anti-gravity's "Orchestration" phase includes self-healing: the AI runs the app on Chrome, finds errors, and fixes them automatically. In Hermes, the equivalent is: the agent runs the test command, reads stderr/exit code, patches the error, and re-tests.

| Anti-gravity | Hermes Equivalent |
|---|---|
| Chrome auto-test | `python3 script.py`, `curl -sI`, `npm run build` |
| Error detection | exit code ≠ 0, stderr, HTTP status ≠ 200 |
| Auto-fix | patch/write_file on the error source |
| Re-test | Re-run the same command |
| Escalation | Not in Anti-gravity → Hermes: BLOCKER after 3 iterations |

## Skill Template

Create a profile-local skill at `<profile>/skills/software-development/self-healing-test-loop/SKILL.md`:

```yaml
---
name: self-healing-test-loop
description: "Self-healing test döngüsü: kodu çalıştır, hatayı otomatik tespit et, düzelt ve yeniden test et. Agent loop pattern'i."
---
```

### Core Loop (max 3 iterations)

```
1. TEST ET (Observe): Run command, capture exit code + stderr
2. DEĞERLENDİR (Think): Exit 0 + expected output? → TEMİZ, done. Error? → step 3. Iteration 3? → step 5.
3. DÜZELT (Act): Analyze error, apply minimal patch (no scope creep)
4. YENİDEN TEST ET (Loop): Return to step 1, increment counter
5. BLOCKER (Escalate): Report to main session: error summary + tried fixes + recommendation
```

### Test Methods by Task Type

| Task Type | Test Command | Success Criteria |
|---|---|---|
| Python script | `python3 script.py` | exit 0 + expected stdout |
| Web page | `curl -sI URL` | HTTP 200/301 + correct title |
| HTML output | Browser snapshot/render | Content visible, no error |
| Build | `npm run build` / `uv run build` | exit 0, empty stderr |
| Lint | `ruff check .` / `eslint .` | exit 0, no warnings |
| HTTP API | `curl -s endpoint` | Expected JSON/status |

### SOUL.md Integration

Add to the profile's SOUL.md:

```markdown
## Self-Healing Test Döngüsü

- Görevde "self-healing ile yap", "test döngüsü kur" veya benzeri ifade varsa, `self-healing-test-loop` skill'ini yükle ve uygula.
- Varsayılan olarak tek seferlik test yeterlidir; döngü opt-in'dir.
- Döngü: çalıştır → hata varsa düzelt → yeniden test et (max 3 tur). 3'ten sonra BLOCKER raporu.

## Rapor Formatı
...
6. Self-healing döngüsü (varsa): iterasyon sayısı, son durum (TEMİZ/BLOCKER), düzeltilen hatalar
```

## Guardrails

1. **Maximum 3 iterations.** No infinite loops.
2. **Only error-source fixes.** No scope creep during fix cycle.
3. **Opt-in only.** Default behavior is single-pass test, not loop.
4. **Large files (30KB+):** GLM-5.2 timeout risk. Test in chunks or escalate.
5. **No external side effects.** Push/deploy/PR still blocked.

## Agent Loop Philosophy Connection

This pattern is the Timuçin-specific application of the general Agent Loops concept (translated from the "Agent Loops, Simplified" guide):

```
Gözlemle (test çalıştır) → Karar Ver (hata var mı) → Eyleme Geç (düzelt) → Sonucu İzle (yeniden test) → Tekrarla
```

The general loop is: Observe → Think → Act → Watch → Repeat. Self-healing constrains this to code testing with a hard 3-iteration cap and BLOCKER escalation.

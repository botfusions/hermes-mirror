---
name: notebooklm
description: Complete API for Google NotebookLM - full programmatic access including features not in the web UI. Create notebooks, add sources, generate all artifact types, download in multiple formats. Activates on explicit /notebooklm or intent like "create a podcast about X", "install notebooklm", "add notebooklm to cowork"
---

# NotebookLM Automation

Complete programmatic access to Google NotebookLM—including capabilities not exposed in the web UI. Create notebooks, add sources (URLs, YouTube, PDFs, audio, video, images), chat with content, generate all artifact types, and download results in multiple formats.

## Step 0: Local Setup

When triggered and `notebooklm` is not yet installed or authenticated, complete setup first.

### Pre-flight: Python Version

`notebooklm-py` requires Python 3.10+. On Cenk's Mac, the system Python is 3.9.6 — install Python 3.12 via Homebrew:

```bash
brew install python@3.12
```

### Install the CLI

```bash
PYTHON=$(command -v python3.12 2>/dev/null || command -v python3)
$PYTHON -c "import sys; assert sys.version_info >= (3,10); print(f'OK: {sys.version}')"
$PYTHON -m venv ~/.notebooklm-venv
source ~/.notebooklm-venv/bin/activate
pip install "notebooklm-py[browser]"
playwright install chromium
```

Symlink:
```bash
mkdir -p ~/bin
ln -sf ~/.notebooklm-venv/bin/notebooklm ~/bin/notebooklm
export PATH="$HOME/bin:$PATH"
```

### Authenticate

The built-in `notebooklm login` fails in non-interactive contexts. Use this custom login script instead:

```bash
cat > /tmp/nlm_login.py << 'PYEOF'
import json, os, time
from pathlib import Path
from playwright.sync_api import sync_playwright

STORAGE_PATH = Path.home() / ".notebooklm" / "storage_state.json"
PROFILE_PATH = Path.home() / ".notebooklm" / "browser_profile"
SIGNAL_FILE = Path("/tmp/nlm_save_signal")

SIGNAL_FILE.unlink(missing_ok=True)
STORAGE_PATH.parent.mkdir(parents=True, exist_ok=True)

print("Opening browser for Google login...")
print("Sign in to Google and navigate to notebooklm.google.com")

with sync_playwright() as p:
    browser = p.chromium.launch_persistent_context(
        user_data_dir=str(PROFILE_PATH),
        headless=False,
        args=["--disable-blink-features=AutomationControlled"],
    )
    page = browser.pages[0] if browser.pages else browser.new_page()
    page.goto("https://notebooklm.google.com/")

    print("Browser is open. Waiting for save signal...")
    while not SIGNAL_FILE.exists():
        time.sleep(1)

    print("Save signal received! Capturing session...")
    storage = browser.storage_state()
    with open(STORAGE_PATH, "w") as f:
        json.dump(storage, f)

    cookie_names = [c["name"] for c in storage.get("cookies", [])]
    print(f"Saved {len(cookie_names)} cookies: {cookie_names}")
    browser.close()

SIGNAL_FILE.unlink(missing_ok=True)
print(f"Authentication saved to: {STORAGE_PATH}")
PYEOF

source ~/.notebooklm-venv/bin/activate
python3 /tmp/nlm_login.py > /tmp/nlm_login_output.txt 2>&1 &
echo "Login started. Browser should open in a few seconds..."

# Wait for user to confirm they are on NotebookLM homepage, then:
touch /tmp/nlm_save_signal
sleep 8
cat /tmp/nlm_login_output.txt

# Verify
export PATH="$HOME/bin:$PATH"
notebooklm auth check
notebooklm list

# Cleanup
rm -f /tmp/nlm_login.py /tmp/nlm_login_output.txt /tmp/nlm_save_signal
```

## Autonomy Rules

**Run automatically (no confirmation):**
- `notebooklm status`, `notebooklm auth check`, `notebooklm list`
- `notebooklm source list`, `notebooklm artifact list`
- `notebooklm language list`, `notebooklm language get`, `notebooklm language set`
- `notebooklm artifact wait`, `notebooklm source wait`
- `notebooklm research status`, `notebooklm research wait`
- `notebooklm use <id>`, `notebooklm create`
- `notebooklm ask "..."` (without --save-as-note)
- `notebooklm history` (read-only)
- `notebooklm source add`

**Ask before running:**
- `notebooklm delete` — destructive
- `notebooklm generate *` — long-running
- `notebooklm download *` — writes to filesystem
- `notebooklm ask "..." --save-as-note`
- `notebooklm history --save`

## Quick Reference

| Task | Command |
|------|---------|
| List notebooks | `notebooklm list` |
| Create notebook | `notebooklm create "Title"` |
| Set context | `notebooklm use <notebook_id>` |
| Show context | `notebooklm status` |
| Add URL source | `notebooklm source add "https://..."` |
| Add file | `notebooklm source add ./file.pdf` |
| Add YouTube | `notebooklm source add "https://youtube.com/..."` |
| List sources | `notebooklm source list` |
| Chat | `notebooklm ask "question"` |
| Chat (specific sources) | `notebooklm ask "question" -s src_id1 -s src_id2` |
| Chat (with references) | `notebooklm ask "question" --json` |
| Chat (save answer as note) | `notebooklm ask "question" --save-as-note` |
| Show conversation history | `notebooklm history` |
| Save all history as note | `notebooklm history --save` |
| Web research (fast) | `notebooklm source add-research "query"` |
| Web research (deep) | `notebooklm source add-research "query" --mode deep --no-wait` |
| Generate podcast | `notebooklm generate audio "instructions"` |
| Generate video | `notebooklm generate video "instructions"` |
| Generate report | `notebooklm generate report --format briefing-doc` |
| Generate quiz | `notebooklm generate quiz` |
| Generate flashcards | `notebooklm generate flashcards` |
| Generate infographic | `notebooklm generate infographic` |
| Generate mind map | `notebooklm generate mind-map` |
| Generate slide deck | `notebooklm generate slide-deck` |
| Download audio | `notebooklm download audio ./output.mp3` |
| Download video | `notebooklm download video ./output.mp4` |
| Download report | `notebooklm download report ./report.md` |
| Download quiz | `notebooklm download quiz quiz.json` |
| Download flashcards | `notebooklm download flashcards cards.json` |
| List languages | `notebooklm language list` |
| Set language | `notebooklm language set zh_Hans` |

## Generation Types

| Type | Command | Options | Download |
|------|---------|---------|----------|
| Podcast | `generate audio` | `--format [deep-dive\|brief\|critique\|debate]`, `--length [short\|default\|long]` | .mp3 |
| Video | `generate video` | `--format [explainer\|brief]`, `--style [auto\|classic\|whiteboard\|kawaii\|anime\|watercolor\|retro-print\|heritage\|paper-craft]` | .mp4 |
| Slide Deck | `generate slide-deck` | `--format [detailed\|presenter]`, `--length [default\|short]` | .pdf / .pptx |
| Infographic | `generate infographic` | `--orientation [landscape\|portrait\|square]`, `--detail [concise\|standard\|detailed]` | .png |
| Report | `generate report` | `--format [briefing-doc\|study-guide\|blog-post\|custom]`, `--append "extra instructions"` | .md |
| Mind Map | `generate mind-map` | (sync, instant) | .json |
| Quiz | `generate quiz` | `--difficulty [easy\|medium\|hard]`, `--quantity [fewer\|standard\|more]` | .json/.md/.html |
| Flashcards | `generate flashcards` | `--difficulty [easy\|medium\|hard]`, `--quantity [fewer\|standard\|more]` | .json/.md/.html |

## Common Workflows

### Research to Podcast
1. `notebooklm create "Research: [topic]"`
2. `notebooklm source add` for each URL/document
3. Wait for sources: `notebooklm source list --json` until all status=READY
4. `notebooklm generate audio "Focus on [specific angle]"`
5. `notebooklm artifact list` for status
6. `notebooklm download audio ./podcast.mp3` when complete

### Document Analysis
1. `notebooklm create "Analysis: [project]"`
2. `notebooklm source add ./doc.pdf`
3. `notebooklm ask "Summarize the key points"`
4. Continue chatting as needed

## Error Handling

| Error | Cause | Action |
|-------|-------|--------|
| Auth/cookie error | Session expired | Re-run the login script |
| "No notebook context" | Context not set | Run `notebooklm use <id>` |
| Rate limiting | Google throttle | Wait 5-10 min, retry |
| Download fails | Generation incomplete | Check `artifact list` for status |

## Known Limitations

- Audio, video, quiz, flashcard, infographic, and slide deck generation may fail due to Google rate limits
- Generation times: audio 10-20 min, video 15-45 min, quiz/flashcards 5-15 min
- This is an unofficial API — Google can change things without warning

## Resources

- notebooklm-py CLI: [github.com/jgravelle/notebooklm-py](https://github.com/jgravelle/notebooklm-py)
- Claude Code NotebookLM Skills: [github.com/skyremote/claude-code-notebooklm-skills](https://github.com/skyremote/claude-code-notebooklm-skills)

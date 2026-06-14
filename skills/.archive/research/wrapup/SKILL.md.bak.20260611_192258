---
name: wrapup
description: End-of-session wrap-up — summarizes the session, saves key memories, and pushes a session log to the user's AI Brain NotebookLM notebook. Trigger on "/wrapup" or when user says "wrap up", "save this session", "end of session", "session summary".
---

# Session Wrap-Up

Run this at the end of every session to capture what happened and commit it to long-term memory.

## Step 0: Ensure AI Brain Notebook Exists

**Check for saved notebook ID:**
Look for a memory entry or file that stores the Brain notebook ID.

**If no notebook ID is saved:**
1. List existing notebooks: `notebooklm list --json`
2. Look for one titled "AI Brain" or similar ("Cenk's AI Brain")
3. If found: Use that notebook's ID
4. If NOT found: Tell the user "You don't have an AI Brain notebook yet. This is where I'll save a summary of every session. Want me to create it now?"
5. If user agrees: `notebooklm create "Cenk's AI Brain" --json`
6. Save the notebook ID to memory

**If notebook ID IS saved:** Verify with `notebooklm list --json`. If deleted, repeat creation flow.

## Step 1: Review the Session

Identify:
- **Decisions made** — what and why
- **Work completed** — built, fixed, configured, shipped
- **Key learnings** — surprising or non-obvious discoveries
- **Open threads** — unfinished or revisit-later items
- **User preferences revealed** — new feedback about how the user likes to work

## Step 2: Save Memories

Check existing memory and save/update as needed:
- **feedback** — corrections or confirmed approaches
- **project** — ongoing work, goals, deadlines
- **user** — new info about user's role, preferences, knowledge
- **reference** — external resources, tools, systems

Rules:
- Don't duplicate — update existing
- Don't save things derivable from code or git history
- Convert relative dates to absolute
- Include **Why:** and **How to apply:** for feedback/project

## Step 3: Write Session Summary

```markdown
# Session Summary — YYYY-MM-DD

## What We Did
- Key work completed

## Decisions Made
- Decisions and reasoning

## Key Learnings
- Insights or discoveries

## Open Threads
- To pick up next time

## Tools & Systems Touched
- Tools, repos, services involved
```

Save to `/tmp/session-summary-YYYY-MM-DD.md`.

## Step 4: Push to NotebookLM Brain

```bash
notebooklm source add /tmp/session-summary-YYYY-MM-DD.md --notebook <BRAIN_NOTEBOOK_ID>
```

If CLI not on PATH, use `~/.notebooklm-venv/bin/notebooklm`.
If auth fails, warn user and skip — memories still saved locally.

## Step 5: Confirm

Brief confirmation:
- How many memories saved/updated
- Session summary added to Brain notebook (or skipped if auth failed)
- Open threads to pick up next time

## Error Handling

- NotebookLM auth fails: save locally, skip notebook push, tell user
- Brain notebook deleted: re-create and update saved ID
- Nothing meaningful to save: just say so
- `notebooklm` CLI not found: try venv path, if fails tell user to install

## Prerequisites

Requires the `notebooklm` skill to be installed and authenticated first.

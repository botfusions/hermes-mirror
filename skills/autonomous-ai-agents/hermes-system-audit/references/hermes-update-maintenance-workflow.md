# Hermes Update & Maintenance Workflow

Captured during a real v0.16.0 → v0.17.0 update (612 commits, config v27 → v30).
Re-verify after each Hermes release — specific outputs change, the workflow shape does not.

## Pre-flight

```
hermes --version          # confirm current version + commit distance
hermes doctor             # identify issues BEFORE update (baseline)
```

If `--version` says "N commits behind — run 'hermes update'", proceed.

## Update sequence (strict order)

### 1. Pre-update snapshot

```
hermes backup --quick --label "pre-update-v<VERSION>"
```

Creates a restore point in `~/.hermes/state-snapshots/`.
Restore with: `/snapshot restore <snapshot-name>`

### 2. Update

```
hermes update
```

What happens during update:
- Pulls all commits from upstream
- Rebuilds Python venv packages
- Rebuilds web UI (vite build)
- Refreshes cua-driver (Computer Use) — may upgrade
- Syncs bundled skills to all profiles (keeps user-modified)
- Runs curator (may archive stale skills automatically)
- Migrates config format version
- Stops dashboard (backend changed) — restart needed after
- Restarts gateway

### 3. Doctor fix

```
hermes doctor --fix
```

Auto-fixes what it can:
- Config format migration
- Missing directory structure
- Seeds new config defaults

Manual issues remain (missing API keys, optional tool deps). These are reported
but NOT blockers.

### 4. Post-update snapshot

```
hermes backup --quick --label "post-update-v<NEW-VERSION>"
```

### 5. Post-update verification

```
hermes --version          # should say "Up to date"
hermes profile list       # all profiles intact
hermes cron list          # all cron jobs intact
```

Restart dashboard if needed:
```
hermes dashboard --port <port>
```

## Bounded execution rule

The user controls step execution. When they say "adım 1 bitir ve dur", execute
step 1 only, verify, report, STOP. Do NOT cascade to step 2. Present the result
and the next step name, then wait for "adım 2".

## Invisible-space folder merge (macOS)

### Problem

macOS allows folder names with trailing/leading spaces. Two folders can look
identical in Finder but be different:
- `Hermes_Agent` (clean)
- `Hermes_Agent ` (trailing space — invisible)

Different tools disagree on whether the clean path exists:
- `ls` via shell: may resolve or fail depending on quoting
- Python `os.listdir()`: returns exact names (reliable)
- `write_file`/`read_file`: may write to a different location than terminal `ls` sees

### Diagnosis (byte-level truth)

```bash
# List all matching dirs with null-terminated exact bytes
find /Users/cenktk/Desktop -maxdepth 1 -name "*Hermes*" -print0 | od -c

# Output shows exact bytes:
# "H e r m e s _ A g e n t  \0"     = clean (no trailing space)
# "H e r m e s _ A g e n t   \0"    = trailing space (0x20 before \0)
# "        \0"                       = name is only spaces
```

`stat -f "inode=%i" <path>` confirms whether a specific spelling exists.

### Merge workflow (zero data loss)

```bash
SPACE_DIR="/Users/cenktk/Desktop/Hermes_Agent "   # trailing space
CLEAN_DIR="/Users/cenktk/Desktop/Hermes_Agent"     # clean

# 1. Snapshot inventories for verification
( cd "$SPACE_DIR" && find . -type f ! -name '.DS_Store' | sort ) > /tmp/space_before.txt
( cd "$CLEAN_DIR" && find . -type f ! -name '.DS_Store' | sort ) > /tmp/clean_before.txt

# 2. Move unique items (instant, same filesystem)
for item in "file1" "dir1" "dir2"; do
  [ -e "$SPACE_DIR/$item" ] && [ ! -e "$CLEAN_DIR/$item" ] && mv "$SPACE_DIR/$item" "$CLEAN_DIR/$item"
done

# 3. rsync overlapping dirs (additive, NO --delete)
for d in "Analizler" "Wiki"; do
  rsync -a "$SPACE_DIR/$d/" "$CLEAN_DIR/$d/"
done

# 4. VERIFY: every original file now in target
missing=0
while IFS= read -r f; do
  [ ! -e "$CLEAN_DIR/$f" ] && { echo "MISSING: $f"; missing=$((missing+1)); }
done < /tmp/space_before.txt
echo "Missing: $missing"   # MUST be 0

# 5. Only after verification: remove source, rename target
rm -rf "$SPACE_DIR"
# If clean dir doesn't exist yet:
mv "$SPACE_DIR_WITH_DIFFERENT_NAME" "$CLEAN_DIR"
```

### Key insight

`find -print0 | od -c` is the ONLY reliable way to detect invisible characters in
filenames. `ls`, `du`, and even Python `os.listdir()` can mislead when the shell
or tool resolves paths ambiguously. Always verify at the byte level before any
destructive filesystem operation.

## Post-merge path migration (CRITICAL — do not skip)

After renaming/merging a workspace folder, references to the old path break across
FIVE surfaces. Fix ALL of them in this order:

### Surface 1: Shell scripts (`~/.hermes/scripts/*.sh`)
```bash
grep -rl "Hermes_Agent " ~/.hermes/scripts/*.sh
# Fix: sed -i '' 's|/old/path/|/new/path/|g' <file>
```

### Surface 2: Python scripts (`~/.hermes/scripts/*.py`)
Python pathlib uses a DIFFERENT pattern than string interpolation. The old path may
appear as a separate path component: `"Hermes_Agent "` (with space inside the string).
This is NOT caught by the same sed as shell scripts.
```bash
grep -rn "Hermes_Agent " ~/.hermes/scripts/*.py
# Fix: sed -i '' 's|"Hermes_Agent "|"Hermes_Agent"|g' <file>  # pathlib component fix
# AND: sed -i '' 's|/old/path/|/new/path/|g' <file>           # string interpolation fix
```

### Surface 3: Cron job workdirs
```bash
hermes cron list | grep "Workdir"   # check for old paths
# Fix: hermes cron edit <job_id> --workdir "/new/clean/path"
```

### Surface 4: AGENTS.md files
```bash
grep -rl "Hermes_Agent " ~/.hermes/profiles/*/AGENTS.md
# Fix: patch tool or sed
```

### Surface 5: Skill content
```bash
grep -rl "Hermes_Agent " ~/.hermes/skills/ 2>/dev/null
# Fix: patch tool or sed
```

### Verification
For EACH surface, after fixing:
```bash
grep -rl "old_pattern" <dir> | wc -l   # MUST be 0
```

Order matters: scripts → cron workdirs → AGENTS.md → skills. This way, running cron
jobs stop referencing the old path before you finish fixing the documentation.


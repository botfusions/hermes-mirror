# Invisible Whitespace in Folder Names — Diagnosis & Safe Merge

When tools disagree on whether a path exists, or show *different* contents for what
looks like the same folder, the usual culprit is a trailing/leading space (or other
invisible char) in the directory name. This is invisible in Finder, Obsidian, and
most terminal prompts, but breaks every path-based reference.

Recurring triggers: accidental rename, Obsidian vault operations, sync conflicts.

## Symptom signature

- `ls /path/MyFolder` → "No such file" in one tool, but another tool (write_file /
  read_file / search_files) successfully reads/writes files "in" it.
- User reports "two folders with the same name" or "my files are split."
- A `cd` into what you think is the folder changes to an unexpected directory.

## Diagnosis recipe (get GROUND TRUTH, not guesses)

### 1. Exact bytes of the real name (null-delimited)

`ls` and `cat -A` are NOT reliable — quoting/whitespace collapses. Use null-delimited
output piped to an octal/hex dump:

```bash
find /Users/.../Desktop -maxdepth 1 -name "*ermes*" -print0 | od -c
# 2e2f 4865 726d 6573 5f41 6765 6e74 2000  = ./Hermes_Agent <SPACE> \0
#                                                          ^^^^ trailing 0x20
```

Read the bytes literally. `\0` should fall IMMEDIATELY after the intended name. Any
char between the name and `\0` (space ` `, nbsp `\u00a0`, tab) is the corruption.

### 2. Inode as ground truth when shell is ambiguous

When two spellings both seem to resolve, inode settles it — two names = two inodes:

```bash
stat -f "name=[%N] inode=%i size=%z" "/path/Name"      # the "clean" spelling
stat -f "name=[%N] inode=%i size=%z" "/path/Name "     # the "trailing-space" spelling
```

A "No such file" on one spelling means only ONE real folder exists. Different inodes
on both = genuinely two folders.

### 3. Beware: terminal CWD ≠ file-tool resolution

THIS IS THE TRAP. The terminal tool's CWD and the `write_file`/`read_file`/`search_files`
tools can resolve invisible-name ambiguity to **different** folders. If
`execute_code`/`os.listdir()` on a "clean" path returns empty while `write_file`
reports success on the same path, they are looking at different directories. Always
confirm the exact bytes (step 1) and inode (step 2) before trusting any single tool.

## Safe merge recipe (zero data loss)

### 1. Snapshot inventories first

```bash
( cd "$SPACE1" && find . -type f ! -name '.DS_Store' | sort ) > /tmp/src_before.txt
( cd "$SPACE2" && find . -type f ! -name '.DS_Store' | sort ) > /tmp/dst_before.txt
```

### 2. Move unique items (instant — same filesystem = rename, no copy)

```bash
for item in "file1.md" "external" "Haberler"; do
  [ -e "$SRC/$item" ] && [ ! -e "$DST/$item" ] && mv "$SRC/$item" "$DST/$item"
done
```

### 3. Merge overlapping dirs additively (NEVER use --delete)

```bash
for d in "Analizler" "Wiki" "shared"; do
  rsync -a "$SRC/$d/" "$DST/$d/"   # trailing slash on source = contents
done
```

`--delete` would erase files that exist only in DST. Additive rsync keeps both.

### 4. VERIFY every source file landed in target BEFORE removing source

```bash
while IFS= read -r f; do
  [ -e "$DST/$f" ] || echo "MISSING: $f"
done < /tmp/src_before.txt
# only remove $SRC if count of MISSING lines == 0
```

### 5. Remove source, rename to clean name, confirm bytes

```bash
rm -rf "$SRC"
mv "$DST " "$DST"                 # strip the trailing space
find ... -maxdepth 1 -name "..." -print0 | od -c   # \0 must follow the intended name
```

## Pitfalls

- **Never trust `ls`/`cat -A` alone** for whitespace detection — always `od -c`/`xxd`
  on null-delimited output.
- **Never `rsync --delete` during a merge** — it destroys DST-only files.
- **Python `pathlib.stat()` vs `os.stat` naming:** `PosixPath` uses `is_dir()`, not
  `isdir()` (the latter is `os.path` API). Mixing them throws AttributeError mid-probe.
- **`.DS_Store` noise:** exclude it from inventory snapshots or counts are inflated.
- **Git repos inside the merge:** `mv` preserves them intact (inode-level rename);
  rsync `-a` preserves `.git` too. Verify `.git` exists post-merge for any repo.

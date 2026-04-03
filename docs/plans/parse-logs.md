# Plan: Log and Dump Parser (`tools/parse-logs.ps1`)

## Goal

Give developers and Agents a single script to extract actionable information from Homeworld Remastered's log and crash dump files, eliminating the need to manually open and search them.

---

## Log File Locations

All target files live in the HW install's runtime directory:

```
<Steam library>\steamapps\common\Homeworld Remastered\HomeworldRM\Bin\Release\
  Hw2.log                  — primary game/engine/Lua log (text)
  *ErrorLog.txt            — human-readable crash summary, paired with a dump (text)
  *MiniDump.dmp            — Windows MiniDump, paired with the ErrorLog above (binary)
  *.mdmp                   — additional MiniDump files (binary)
```

`*ErrorLog.txt` files are the most immediately useful crash artifacts — they contain readable context about the crash. The paired `*MiniDump.dmp` and any standalone `.mdmp` files are binary and require WinDbg/procdump for deep analysis (out of scope for v1).

Common Steam library roots to probe if not configured:
- `C:\Program Files (x86)\Steam\steamapps\common\Homeworld Remastered`
- Any path listed under `HKCU:\Software\Valve\Steam\SteamPath` + `\steamapps\common\Homeworld Remastered`

---

## Hw2.log Structure

The log is plain text, one event per line. Observed patterns:

```
[timestamp] CATEGORY: message
```

Categories relevant to RFF:
- `LUA ERROR` / `LUA:` — script errors and print() output from .lua, .ship, .wepn files
- `WARNING` — non-fatal engine issues
- `ERROR` — fatal or significant errors
- `MOD:` — mod loading/unloading events
- Lines containing `RFF` or `requiem` — mod-specific output

---

## Script Design

### Parameters

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `-HWPath` | string | auto-detect | Override the HW install path |
| `-Errors` | switch | off | Show only ERROR and LUA ERROR lines |
| `-Lua` | switch | off | Show only Lua-related lines |
| `-Mod` | switch | off | Show only mod loading events |
| `-Tail` | switch | off | Live-tail the log (like `tail -f`) |
| `-Last` | int | 0 | Show only last N lines before filtering |
| `-Dumps` | switch | off | Summarize crash artifacts (*ErrorLog.txt, *.dmp, *.mdmp) instead of log |

With no filters, output the full log with lines color-coded by severity.

### Behavior

1. **Auto-detect path**: Check registry key first, then probe common paths. If not found, print a clear error with instructions to pass `-HWPath`.
2. **Parse Hw2.log**: Stream line by line; apply requested filters; emit with line numbers.
3. **Dump summary** (`-Dumps`): Group crash artifacts by incident (matching stem name, e.g. `2026-03-30T14-22-11`). For each incident, print the timestamp and dump the full content of the paired `*ErrorLog.txt` if present — that file is readable text and contains the most useful crash context. List any accompanying `.dmp` / `.mdmp` binaries by name and size. (Deep binary analysis requires WinDbg/procdump and is out of scope for v1.)
4. **Exit code**: Exit 0 if no errors found, 1 if any ERROR/LUA ERROR lines were present (makes CI integration possible).

### Example Output

```
> ./tools/parse-logs.ps1 -Errors

HW path: C:\Program Files (x86)\Steam\steamapps\common\Homeworld Remastered
Log:     ...\Bin\Release\Hw2.log (last modified: 2026-03-30 14:22)

[00:01.342] LUA ERROR: src/ship/hgn_battlecruiser/hgn_battlecruiser.ship:47: attempt to call nil value

1 error(s) found.
```

---

## Implementation Notes

- Keep it a single `.ps1` file under `tools/` — no external dependencies.
- Use `Select-String` for log filtering; avoid loading the whole file into memory (logs can grow large).
- The `-Tail` mode should use a loop with `Get-Content -Wait` or `[System.IO.FileSystemWatcher]`.
- Add the script to `docs/tools.md` once implemented.

---

## Agent Usage Pattern

An Agent debugging a reported issue should:

1. Ask the user to run `./tools/parse-logs.ps1 -Errors` and paste the output.
2. If a Lua error is reported, cross-reference the file/line with the source in `src/`.
3. If a crash dump exists, run `./tools/parse-logs.ps1 -Dumps` for timestamp context.

This keeps the Agent from needing direct file-system access to the player's machine.

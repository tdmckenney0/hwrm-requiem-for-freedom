# Development Tools

All tools are in `tools/` and require **PowerShell 7+** (`pwsh`).

---

## `link-src.ps1` — Live Development Link

Creates a directory link at `<HW2 install>/DataRFF` pointing to this repo's `src/` directory. This lets you edit source files and test changes without recompiling the `.big` archive — just restart the game.

**Usage:**

```powershell
# Auto-detect Steam installation
./tools/link-src.ps1

# Specify a custom Homeworld path
./tools/link-src.ps1 -Hw2Path "D:\Steam\steamapps\common\Homeworld\HomeworldRM"
```

**How it works:**

1. Reads the Steam install path from the Windows registry (`HKLM:\SOFTWARE\WOW6432Node\Valve\Steam`)
2. Constructs `<steam>\steamapps\common\Homeworld\HomeworldRM`
3. Tries to create a **symlink** (Wine-compatible; requires admin or Developer Mode)
4. Falls back to a **junction** (no elevated privileges required on Windows)

The link is idempotent — re-running when the link already exists exits silently.

---

## `launch-rff.ps1` — Game Launcher

Launches Homeworld Remastered with RFF active at native monitor resolution.

**Usage:**

```powershell
./tools/launch-rff.ps1
./tools/launch-rff.ps1 -Hw2Path "D:\Steam\steamapps\common\Homeworld\HomeworldRM"
```

**What it does:**

1. Resolves the HW2 install path (registry or parameter)
2. Queries `Win32_VideoController` for the primary monitor's native resolution
3. Launches `HomeworldRM.exe` with:
   - `-moddatapath DataRFF` — loads the RFF data directory
   - `-overridebigfile` — RFF files override base-game `.big` archives
   - `-hardwarecursor` — uses OS cursor instead of software cursor
   - `-nomovies` — skips intro movies
   - `-w <W> -h <H>` — native resolution

---

## `ship-stats.ps1` — Balance Analysis

Extracts key numeric statistics from every `.ship` file and displays them as a table. Can diff against any git ref to see balance changes as percentage deltas.

**Usage:**

```powershell
# Show all ships, all key fields
./tools/ship-stats.ps1

# Show changes vs. origin/master
./tools/ship-stats.ps1 -GitRef origin/master

# Show only ships that changed
./tools/ship-stats.ps1 -GitRef origin/master -Changed

# Filter to battlecruiser ships only
./tools/ship-stats.ps1 -Ship battlecruiser

# Compare specific fields only
./tools/ship-stats.ps1 -Fields maxhealth,buildCost,buildTime

# All together
./tools/ship-stats.ps1 -GitRef origin/master -Ship destroyer -Changed
```

**Tracked fields (default):**

| Field | Description |
|-------|-------------|
| `maxhealth` | Hit points |
| `mainEngineMaxSpeed` | Forward top speed |
| `thrusterMaxSpeed` | Lateral top speed |
| `rotationMaxSpeed` | Turn rate |
| `buildCost` | RU cost |
| `buildTime` | Build time (seconds) |
| `prmSensorRange` | Primary sensor range |
| `secSensorRange` | Secondary sensor range |
| `thrusterAccelTime` | Lateral acceleration time |
| `thrusterBrakeTime` | Lateral deceleration time |
| `goalReachEpsilon` | Move goal tolerance |
| `slideMoveRange` | Max slide distance |

**Diff output format:**

Ships with changes are prefixed with `*`. Changed fields show:
```
<old_value> → <new_value> (+<pct>%)
```

**Example output:**
```
Ship                     maxhealth   buildCost   buildTime
----                     ---------   ---------   ---------
* hgn_battlecruiser      170000      4000 → 4500 (+12.5%)   280
  hgn_destroyer          60000       2500        180
```

---

## Workflow: Making a Balance Change

1. Edit the relevant `.ship`, `.wepn`, or `.subs` file
2. Run `./tools/launch-rff.ps1` to test in-game (no recompile needed thanks to the symlink)
3. When satisfied, commit
4. Use `./tools/ship-stats.ps1 -GitRef HEAD~1 -Changed` to review what changed before pushing

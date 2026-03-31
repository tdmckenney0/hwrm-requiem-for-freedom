# CLAUDE.md — Homeworld: Requiem for Freedom

## Project Summary

**Homeworld: Requiem for Freedom (RFF)** is a game mod for _Homeworld Remastered_. It creates larger, faster, competitive multiplayer/skirmish battles. Spiritual successor to _Slipstream: The Price of Freedom_.

- Steam Workshop ID: `2960369910`
- Compiled output: `RFF.big` (loaded from `DataRFF/` in the HW2 install)
- Source: all files under `src/`

## Temp directory

**IMPORTANT: Always use the repo-local `temp/` directory for all temporary files and artifacts. Never use the system temp directory (`%TEMP%`, `%TMP%`, `$TMPDIR`, `/tmp`, or any path outside this repo).**

- Correct: `temp/scratch.txt`, `temp/output.csv`, `./temp/working/`
- Wrong: `/tmp/scratch.txt`, `$env:TEMP\output.csv`, `~/scratch.txt`

The `temp/` directory is gitignored. Create subdirectories inside it freely. If you need a throwaway file, script output, intermediate data, or any artifact that should not be committed, it goes in `temp/`.

## Documentation

Full documentation is in `docs/`:

| File | Contents |
|------|---------|
| [docs/overview.md](docs/overview.md) | Project goals, faction table, repo layout |
| [docs/architecture.md](docs/architecture.md) | How the mod loads, layered design, key patterns |
| [docs/ship-definitions.md](docs/ship-definitions.md) | `.ship` file format, balance fields, full ship roster |
| [docs/weapon-definitions.md](docs/weapon-definitions.md) | `.wepn` file format, penetration/accuracy tables |
| [docs/attack-styles.md](docs/attack-styles.md) | Attack script naming, full index, how to add new styles |
| [docs/races.md](docs/races.md) | Per-faction AI scripts, starting fleets, AI globals |
| [docs/tools.md](docs/tools.md) | PowerShell dev tools with usage examples |
| [docs/maps.md](docs/maps.md) | Multiplayer map roster and level file structure |

## Repository Layout

```
src/
  ai/                  classdef.lua — ship class constants for AI
  art/fx/              Visual effect Lua scripts
  leveldata/           Multiplayer .level files
  scripts/
    attack/            100+ attack-style Lua scripts
    races/             Per-faction AI build/research/upgrade scripts
    startingfleets/    Starting fleet templates
  ship/<name>/         .ship files (stats, abilities, hardpoints)
  subsystem/<name>/    .subs files (turret/module stats)
  weapon/<name>/       .wepn files (damage, accuracy, penetration)
  sound/               Music and audio scripts
  ui/                  HUD/menu overrides
tools/
  link-src.ps1         Symlinks src/ into HW2 install for live editing
  launch-rff.ps1       Launches game with RFF active
  ship-stats.ps1       Balance comparison tool
```

## Reference Files (`refs/`)

The `refs/` directory contains read-only extracts from the base-game `.big` archives:

| Directory | Contents |
|-----------|----------|
| `refs/homeworldrm-big/` | Main game logic, scripts, and data |
| `refs/hw1ships-big/ship/` | HW1 ship definitions |
| `refs/hw2ships-big/ship/` | HW2 ship definitions |
| `refs/hwbackgrounds-big/background/` | Skybox files |
| `refs/english-big/` | English localization strings |

To override a base-game file, copy it from `refs/` to the same relative path under `src/`, then edit the copy. The path under `src/` mirrors the path relative to the ref root.

```powershell
# Override a HW1 ship (create dir if it doesn't exist)
mkdir src/ship/kus_interceptor
cp refs/hw1ships-big/ship/kus_interceptor/kus_interceptor.ship `
   src/ship/kus_interceptor/kus_interceptor.ship

# Override a script from the main game
cp refs/homeworldrm-big/effect/hyperspaceeffecttweaks.lua `
   src/effect/hyperspaceeffecttweaks.lua
```

Never edit files in `refs/` — they are source material only and are gitignored.

## Common Tasks

### Set Up Development Environment

```powershell
# Link src/ into the game (run once)
./tools/link-src.ps1

# Launch the game with RFF loaded
./tools/launch-rff.ps1
```

No compilation step — edits take effect on the next game launch.

### Balance a Ship

1. Edit `src/ship/<ship_name>/<ship_name>.ship`
2. Key fields: `maxhealth`, `buildCost`, `buildTime`, `thrusterMaxSpeed`, `mainEngineMaxSpeed`, `rotationMaxSpeed`
3. Test: `./tools/launch-rff.ps1`
4. Review changes: `./tools/ship-stats.ps1 -GitRef HEAD -Changed`

### Balance a Weapon

Edit `src/weapon/<weapon_name>/<weapon_name>.wepn`. Key changes:
- `AddWeaponResult` min/max damage values
- `setPenetration` armor multipliers
- `setAccuracy` per-class hit chance and damage multipliers
- Range and fire rate in `StartWeaponConfig`

### Add or Modify an Attack Style

- Scripts live in `src/scripts/attack/<style_name>.lua`
- Named `<maneuver>_<attacker>_vs_<target>` (e.g., `flyby_interceptor_vs_frigate`)
- Reference the style name in the ship's `addAbility(NewShipType, "CanAttack", ...)` call
- Update the index in `src/scripts/attack/README.md`

### Modify AI Build Behavior

- Per-faction logic: `src/scripts/races/<faction>/scripts/ai_build.lua`
- Functions: `DetermineDemandWithNoCounterInfo_<Race>()`, `DetermineSpecialDemand_<Race>()`
- Use `ShipDemandAdd()`, `ShipDemandSet()`, `NumSquadrons()`, `gameTime()`, etc.

### Add a Multiplayer Map

1. Create `src/leveldata/multiplayer/requiem_for_freedom/<Np_MapName>.level`
2. Convention: `<player_count>p_<MapName>.level`

## File Format Summary

| Extension | Purpose | Key API |
|-----------|---------|---------|
| `.ship` | Ship stats, abilities, hardpoints | `NewShipType = StartShipConfig()` |
| `.wepn` | Weapon damage, accuracy, penetration | `StartWeaponConfig(...)` |
| `.subs` | Turret/module stats | `StartSubSystemConfig(...)` |
| `.level` | Multiplayer map | Lua map definition |
| `.lua` | AI logic, attack styles, effects | Various HW2 APIs |

## Faction Prefixes

| Faction | Prefix | Notes |
|---------|--------|-------|
| Hiigaran | `HGN` | Balanced; defense field, torpedo frigates |
| Vaygr | `VGR` | Aggressive; lance fighter, heavy missile frigate |
| Kushan | `KUS` | Classic HW1 style |
| Taiidan | `TAI` | Classic HW1 style |

## VS Code Setup

`.vscode/settings.json` maps `.ship`, `.wepn`, `.subs`, `.level`, `.events`, `.fda`, `.wf` to Lua syntax highlighting. Lua diagnostics are disabled (custom HW2 Lua API).

## Prerequisites

- Homeworld Remastered (Steam)
- PowerShell 7+ for tooling
- VS Code recommended

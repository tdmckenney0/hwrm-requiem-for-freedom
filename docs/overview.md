# Homeworld: Requiem for Freedom — Project Overview

**Requiem for Freedom (RFF)** is a multiplayer-focused game mod for _Homeworld Remastered_. It is the spiritual successor to _Slipstream: The Price of Freedom_, designed to create larger, faster, and more epic space battles optimized for skirmish and competitive multiplayer.

## Goals

- **Faster battles** — ships accelerate and engage more quickly than the base game
- **Larger scale** — supports up to 6-player maps with bigger fleet sizes
- **Competitive balance** — all four factions start from carefully tuned fleets; no campaign asymmetry
- **Arena gameplay** — focused on deathmatch/skirmish rather than story missions

## Distribution

The mod is distributed via Steam Workshop (ID `2960369910`) and compiled into a `.big` archive (`RFF.big`) that the game engine loads directly.

## Playable Factions

| Faction   | Prefix | Style                          |
|-----------|--------|--------------------------------|
| Hiigaran  | `HGN`  | Balanced, defensive-capable    |
| Vaygr     | `VGR`  | Fast, aggressive                |
| Kushan    | `KUS`  | Classic HW1 style              |
| Taiidan   | `TAI`  | Classic HW1 style              |

## Ship Class Hierarchy

From smallest to largest:

1. **Fighter** — scouts, interceptors, bombers, lance fighters
2. **Corvette** — assault, pulsar, laser, missile, command corvettes
3. **Frigate** — assault, ion cannon, torpedo, defense field, marine, infiltrator, heavy missile frigates
4. **Small Capital Ship** — destroyers
5. **Big Capital Ship** — battle cruisers, heavy battle cruisers
6. **Mothership** — carriers (builder ships in skirmish)
7. **Platform** — stationary gun/missile/ion turrets

## Repository Layout

```
hwrm-requiem-for-freedom/
├── src/              # All mod source files (loaded as DataRFF by the game)
│   ├── ai/           # AI class definitions
│   ├── art/fx/       # Visual effects (Lua)
│   ├── badges/       # Player badge images
│   ├── leveldata/    # Multiplayer map definitions
│   ├── scripts/      # Game logic (attack styles, AI, starting fleets, races)
│   ├── ship/         # Ship stat definitions (.ship)
│   ├── sound/        # Music and audio scripts
│   ├── subsystem/    # Turret/module definitions (.subs)
│   ├── ui/           # User interface overrides
│   └── weapon/       # Weapon definitions (.wepn)
├── artwork/          # Logo and marketing images
├── docs/             # This documentation
├── refs/             # Reference materials (gitignored)
├── temp/             # Scratch space (gitignored)
└── tools/            # PowerShell development scripts
```

## Key Files

| File | Purpose |
|------|---------|
| `src/config.txt` | Steam Workshop metadata (title, tags, workshop ID) |
| `src/ai/default/classdef.lua` | Ship classification table used by AI |
| `src/scripts/startingfleets/` | Starting fleet loadouts for each race |
| `src/scripts/attack/` | 100+ attack behavior scripts |
| `src/scripts/races/` | Per-faction AI build/research/upgrade logic |
| `tools/link-src.ps1` | Symlinks `src/` into the game for live editing |
| `tools/launch-rff.ps1` | Launches the game with RFF active |
| `tools/ship-stats.ps1` | Balance comparison tool across ship files |

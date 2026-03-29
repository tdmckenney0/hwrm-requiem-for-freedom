# Architecture

## How the Game Loads the Mod

Homeworld Remastered loads mod data from a directory named `DataRFF` inside the game's installation folder. The game engine reads Lua scripts, `.ship`, `.wepn`, `.subs`, and other custom file types at startup, overriding base-game definitions with any files present in `DataRFF`.

For development, `tools/link-src.ps1` creates a symlink/junction from `<HW2 install>/DataRFF` → `repo/src/`, so edits to source files take effect on the next game launch without any compilation step.

For distribution, the source tree is compiled into `RFF.big` (a proprietary archive) by the Homeworld Workshop Tool, then uploaded to Steam Workshop.

## Source Tree Structure

```
src/
├── ai/
│   └── default/
│       └── classdef.lua          # Maps ship types to AI class constants
├── art/
│   └── fx/                       # Custom particle/visual effect scripts (.fda, .lua)
├── badges/                       # Player emblem .tga images
├── leveldata/
│   └── multiplayer/
│       └── requiem_for_freedom/  # Five multiplayer .level files
├── scripts/
│   ├── attack/                   # Attack-style Lua scripts (~100 files)
│   ├── races/
│   │   ├── hiigaran/scripts/     # HGN AI logic
│   │   ├── vaygr/scripts/        # VGR AI logic
│   │   ├── kushan/scripts/       # KUS AI logic
│   │   └── taiidan/scripts/      # TAI AI logic
│   └── startingfleets/           # Starting fleet Lua definitions
├── ship/
│   └── <ship_name>/
│       └── <ship_name>.ship      # Ship stats file
├── sound/
│   ├── music/
│   │   ├── battle/               # In-combat music
│   │   └── staging/              # Pre-battle/menu music
│   └── soundscripts/             # Audio event trigger definitions
├── subsystem/
│   └── <subsystem_name>/
│       └── <subsystem_name>.subs # Turret/module stats
├── ui/
│   └── newui/                    # UI layout and background overrides
└── weapon/
    └── <weapon_name>/
        └── <weapon_name>.wepn    # Weapon stats file
```

## Layered Design

```
┌─────────────────────────────────────────────────────┐
│  AI Decision Layer  (scripts/races/*, scripts/attack/)│
│  Reads ship counts, resources, enemy strength;       │
│  decides what to build, research, and how to fight.  │
├─────────────────────────────────────────────────────┤
│  Balance / Configuration Layer                        │
│  .ship  — health, speed, cost, sensor ranges         │
│  .wepn  — damage, accuracy, penetration, fire rate   │
│  .subs  — turret health, build cost, weapon bindings │
├─────────────────────────────────────────────────────┤
│  Map / Environment Layer                              │
│  .level — player starts, asteroid fields, bounds     │
│  art/fx/ — weapon impact visuals, engine effects     │
├─────────────────────────────────────────────────────┤
│  Presentation Layer                                   │
│  ui/    — HUD and menu overrides                     │
│  sound/ — music and SFX triggers                     │
│  badges/— player emblems                             │
└─────────────────────────────────────────────────────┘
```

## Key Patterns

### Race Parallelism

Each of the four factions has a mirror directory structure under `scripts/races/`:

```
hiigaran/scripts/
  ai_build.lua        # What ships to build and when
  ai_subsystems.lua   # Subsystem upgrade priorities
  ai_upgrades.lua     # Research priorities
  def_build.lua       # Defensive building preferences
  def_research.lua    # Defensive research priorities
  deathmatch/props/gbx.lua  # Deathmatch-specific config
```

This symmetry makes cross-faction balance comparisons straightforward.

### Declarative Configuration

Ship, weapon, and subsystem files are almost entirely data declarations. The HW2 engine exposes a small Lua API (`NewShipType`, `StartWeaponConfig`, etc.) and RFF populates it with tuned values. Minimal procedural logic lives in these files.

### Attack Style Dispatch

When a ship engages a target, the engine calls the appropriate attack script based on the attacker's class and the target's class (e.g., `flyby_interceptor_vs_frigate.lua`). Scripts define probability-weighted action sequences — rolls, barrel rolls, evasive jinks, approach angles — so combat feels dynamic even though the behavior is data-driven.

### Starting Fleet Templates

`scripts/startingfleets/` contains one Lua file per race/variant (e.g., `hiigaran00.lua`). Each file calls engine APIs to spawn the player's initial ships and configures their subsystems. This is what players get when a skirmish game begins.

### Subsystem Composition

```
Ship (.ship)
  └── Hardpoint → Subsystem (.subs)
                    └── WeaponConfig → Weapon (.wepn)
```

A ship defines named hardpoints. Each hardpoint can hold one subsystem (e.g., an ion beam turret). The subsystem file binds a weapon to that mount. This three-level chain makes it easy to swap weapons onto turrets independently.

## File Format Quick Reference

| Extension | Engine API Entry Point | Purpose |
|-----------|------------------------|---------|
| `.ship` | `NewShipType = StartShipConfig()` | Ship statistics |
| `.wepn` | `StartWeaponConfig(...)` | Weapon behavior and damage |
| `.subs` | `StartSubSystemConfig(...)` | Turret/module statistics |
| `.level` | Lua map definition | Multiplayer level |
| `.lua` | Various | AI logic, attack styles, effects |
| `.fda` | Visual effect definition | Particle systems |
| `.events` | Animation event triggers | Ship animation hooks |

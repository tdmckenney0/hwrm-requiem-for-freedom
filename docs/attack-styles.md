# Attack Styles

Attack style scripts live in `src/scripts/attack/`. Each file is a Lua script that defines a named attack pattern. The HW2 engine selects the appropriate script based on the attacking ship's class and the target's class (e.g., a Hiigaran interceptor attacking a frigate will use `flyby_interceptor_vs_frigate`).

## Script Structure

```lua
-- Common preamble: retrieve the ship's attack parameters
local params = getAttackParams( ... )

-- Main attack sequence: probability-weighted list of actions
-- Each entry: { weight, "ActionName", param1, param2, ... }
local actions = {
    { 30, "BreakFormation" },
    { 50, "FlyByAttack", range, speed },
    { 20, "BarrelRoll", duration },
}

-- Evasion behavior when taking fire
local evasiveActions = {
    { 70, "Jink", intensity },
    { 30, "Immelmann" },
}
```

## Naming Convention

Scripts follow a `<maneuver>_<attacker>_vs_<target>` pattern:

| Prefix | Meaning |
|--------|---------|
| `flyby` | Fast attack run; ship makes a pass and breaks off |
| `flyround` | Orbiting / circling attack around target |
| `dogfight` | Close-range maneuvering combat |
| `strafe` | Sustained strafing run |
| `frontal` | Head-on approach and fire |
| `broadside` | Side-on attack (capital ships) |
| `movetotargetandshoot` | Advance then fire (capital ships) |
| `topattack` | Attack from above (subsystem targeting) |
| `swarmer` | Swarm attack patterns |

Vaygr-specific scripts are prefixed with `v` (e.g., `vcorvette_vs_capship_ar`, `vinterceptor_vs_fighter`).

## Full Script Index

The full list of available attack styles is maintained in [`src/scripts/attack/README.md`](../src/scripts/attack/README.md). Key styles:

### Fighter Scripts
- `dogfight` — standard fighter vs fighter
- `fighter_vs_fighter`, `fighter_vs_frigate`, `fighter_vs_capship`, `fighter_vs_mothership`
- `flyby_interceptor_vs_capship`, `flyby_interceptor_vs_fighter`, `flyby_interceptor_vs_frigate`, `flyby_interceptor_vs_mothership`
- `flyby_interceptor_vs_munition` — intercept missiles
- `flyby_interceptor_vs_resourcelarge`
- `vinterceptor_vs_corvette`, `vinterceptor_vs_fighter`, `vinterceptor_vs_frigate`, `vinterceptor_vs_mothership`, `vinterceptor_vs_capship`

### Bomber Scripts
- `bomber_vs_capship`, `bomber_vs_corvette`, `bomber_vs_fighter`, `bomber_vs_frigate`, `bomber_vs_mothership`, `bomber_vs_smallcapship`
- `flyby_bomber_vs_fighter`, `flyby_bomber_vs_frigate`, `flyby_bomber_vs_mothership`, `flyby_bomber_vs_resourcelarge`
- `strafe_bomber_vs_capship`, `strafe_bomber_vs_smallcapship`
- `topattack_bomber_vs_subsystem`
- `vbomber_vs_capship`, `flyby_vbomber_vs_chimera`

### Corvette Scripts
- `flyby_corvette_vs_corvette`, `flyby_gunship_vs_corvette`, `flyby_gunship_vs_fighter`
- `flyby_heavyfighter_vs_frigate`, `flyby_heavyfighter_vs_mothership`
- `flyround_assaultcorvette_vs_capship`, `flyround_assaultcorvette_vs_frigate`, `flyround_assaultcorvette_vs_mothership`
- `flyround_corvette_vs_capship`, `flyround_corvette_vs_corvette`, `flyround_corvette_vs_fighter`, `flyround_corvette_vs_frigate`, `flyround_corvette_vs_mothership`
- `flyround_missilecorvette_vs_capship`, `flyround_missilecorvette_vs_corvette`, `flyround_missilecorvette_vs_frigate`, `flyround_missilecorvette_vs_mothership`
- `flyround_pulsarcorvette_vs_capship`, `flyround_pulsarcorvette_vs_corvette`, `flyround_pulsarcorvette_vs_fighter`, `flyround_pulsarcorvette_vs_frigate`, `flyround_pulsarcorvette_vs_mothership`
- `corvette_vs_corvette_ar`, `vcorvette_vs_capship_ar`, `vcorvette_vs_corvette_ar`, `vcorvette_vs_frigate_ar`, `vcorvette_vs_smallcapship_ar`
- `lancefighter_vs_corvette`, `lancefighter_vs_frigate`

### Frigate Scripts
- `frontal_frigate`, `movetotargetandshoot_frigate`, `movetotargetandshoot_frigate_vs_corvettes`, `movetotargetandshoot_frigate_vs_fighters`
- `movetotargetandshoot_torps_vs_corvettes`
- `movetotargetandshoot_vaygrassaultfrigate_vs_fighters`

### Capital Ship Scripts
- `flyround_destroyer`, `flyby_destroyer`
- `broadside`, `broadsidevssubsystem`
- `broadside_destroyer_vs_corvettes`
- `dogfight_capital`
- `dread_strafe`
- `movetotargetandshoot_cruiser_vs_frigate`
- `movetotargetandshoot_destroyer_vs_corvettes`
- `movetotargetandshoot_vgrdestroyer_vs_corvettes`
- `movetotargetandshoot_hw1destroyer_vs_corvettes`
- `circlestrafe`

### Support / Special Scripts
- `frontal_repaircorvette`, `frontal_repaircorvette_bigcap`, `frontal_repaircorvette_frigate`, etc.
- `frontal_repairfrigate_bigcap`, `frontal_repairfrigate_frigate`, etc.
- `flyround_commandvette`
- `flyround_minelayercorvette_vs_capship`, etc.
- `justshoot` — basic fire-and-hold (platforms, simple units)
- `justshootvgrplatform` — Vaygr platform variant
- `justshootkusdrone` — Kushan drone variant
- `kamikaze` — suicide run
- `swarmer`, `swarmer_vs_large`

### Subsystem Targeting
- `topattack_interceptor_vs_subsystem`
- `topattack_vinterceptor_vs_subsystem`
- `frontal_vs_subsystem`, `frontalvssubsystem`, `frontalvssubsystem_corvette`
- `movetotargetandshootvssubsystem`

## Adding a New Attack Style

1. Create `src/scripts/attack/<style_name>.lua`
2. Add the style name to the list in `src/scripts/attack/README.md`
3. Reference it in the appropriate ship's `addAbility(NewShipType, "CanAttack", ...)` call in the `.ship` file

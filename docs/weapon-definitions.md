# Weapon Definitions (.wepn)

Each weapon has its own subdirectory under `src/weapon/<weapon_name>/` containing a `<weapon_name>.wepn` file. Weapons are referenced from `.ship` and `.subs` files.

## File Structure

```lua
-- Main weapon config
StartWeaponConfig(
    NewWeaponType,
    "Gimble",       -- Mount type: "Gimble" (turret), "Aimed" (fixed), etc.
    "Bullet",       -- Projectile class
    "Plasma_Bomb",  -- Visual effect type
    "Normal",       -- Shot type
    2500,           -- Range
    1200,           -- Fire rate (ms between shots)
    0,              -- Burst pause (ms)
    0,              -- Burst count
    0,              -- Penetration type
    0,              -- Misc flags
    1,              -- Track: 1=yes
    1,              -- Guided: 1=yes
    0,              -- Shield damage
    0.1,            -- Accuracy base
    1.2,            -- Damage scale
    0.5,            -- Speed
    ...
)

-- What happens on hit
AddWeaponResult(NewWeaponType, "Hit", "DamageHealth", "Target", 150, 250, "")
--                                                              ^min ^max

-- Firing arc
setAngles(NewWeaponType, 25, 0, 0, 0, 0)

-- Armor penetration per armor type
setPenetration(NewWeaponType, 5, 0,
    {Unarmoured      = 1},
    {LightArmour     = 1},
    {MediumArmour    = 0.7},
    {HeavyArmour     = 0.3},
    {SubSystemArmour = 1},
    {TurretArmour    = 1},
    {PlanetKillerArmour = 0},
    {ResArmour       = 0.8}
)

-- Accuracy and damage multiplier per target class
setAccuracy(NewWeaponType, 0.3,
    {Fighter       = 1,   damage = 1},
    {Corvette      = 1,   damage = 1},
    {Frigate       = 1,   damage = 1},
    {SmallCapitalShip = 0, damage = 0.3},
    {BigCapitalShip   = 0, damage = 0.2},
    {SubSystem     = 0.3, damage = 1},
    {Munition      = 1,   damage = 2.5},
    {Resource      = 1,   damage = 1},
    {ResourceLarge = 1,   damage = 1}
)

setMiscValues(NewWeaponType, 0, 0)
```

## Key Parameters

### `StartWeaponConfig` Positional Arguments

| Position | Field | Description |
|----------|-------|-------------|
| 1 | Mount type | `Gimble` = rotating turret; `Aimed` = fixed barrel |
| 2 | Projectile class | `Bullet`, `Missile`, `Beam`, etc. |
| 3 | VFX type | Visual effect name for the projectile |
| 4 | Shot type | `Normal`, `Burst`, etc. |
| 5 | Range | Maximum effective range |
| 6 | Fire rate | Milliseconds between shots |

### `setPenetration`

Controls damage fraction dealt against each armor type. `1.0` = full damage; `0.3` = 30% damage. Weapons specialized for fighters have high `Unarmoured`/`LightArmour` penetration and low `HeavyArmour`. Capital ship weapons are the reverse.

### `setAccuracy`

Two values per target class:
- **Accuracy** (0–1): probability of hitting
- **damage**: damage multiplier on a hit

A weapon with `Fighter = 1, damage = 1` is deadly against fighters. `BigCapitalShip = 0, damage = 0.2` means it almost never hits capitals and does little damage when it does.

## Armor Types Reference

| Armor Type | Used By |
|------------|---------|
| `Unarmoured` | Fighters, scouts |
| `LightArmour` | Corvettes |
| `MediumArmour` | Frigates |
| `HeavyArmour` | Capital ships, battle cruisers |
| `SubSystemArmour` | Turrets, engines, modules |
| `TurretArmour` | Gun platforms |
| `ResArmour` | Resource controllers, harvesters |

## Target Classes Reference

| Class | Ships |
|-------|-------|
| `Fighter` | Scouts, interceptors, bombers, lance fighters |
| `Corvette` | All corvette types |
| `Frigate` | All frigate types |
| `SmallCapitalShip` | Destroyers |
| `BigCapitalShip` | Battle cruisers, heavy battle cruisers |
| `Mothership` | Carriers |
| `SubSystem` | Turrets, engines, modules (when targeted directly) |
| `Munition` | Missiles, mines |
| `Resource` | Asteroids and small resource objects |
| `ResourceLarge` | Large resource objects |

## Weapon Roster

### Hiigaran (HGN)

| File | Weapon | Used On |
|------|--------|---------|
| `hgn_autocannon` | Auto cannon (plasma bomb) | Assault corvette, platforms |
| `hgn_plasmaburst` | Plasma burst cannon | Battle cruiser turrets |
| `hgn_vulcan` | Vulcan (gatling) | Interceptors, corvettes |
| `hgn_battlecruisergatlinggunturret` | Gatling turret | Battle cruiser top/bottom hardpoints |
| `hgn_battlecruiserminelauncher` | Mine launcher | Battle cruiser turret option |
| `hgn_battlecruiseриoncannontopturret` | Ion cannon | Battle cruiser top hardpoint option |
| `hgn_nuclearmissile` | Nuclear missiles | Torpedo frigate |
| `hgn_kineticburstcannon` | Kinetic burst cannon | Battle cruiser innate weapons |
| `hgn_ioncannon` | Ion cannon | Ion cannon frigate |

### Vaygr (VGR)

| File | Weapon | Used On |
|------|--------|---------|
| `vgr_laser` | Laser | Laser corvette |
| `vgr_pulsecannonburst` | Pulse cannon burst | Battle cruiser |
| `vgr_vulsepulse` | Vulse pulse | Various |
| `vgr_plasmalance` | Plasma lance | Lance fighter |

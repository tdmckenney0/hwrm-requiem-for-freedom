# Ship Definitions (.ship)

Each ship has its own subdirectory under `src/ship/<ship_name>/` containing a `<ship_name>.ship` file. These are Lua scripts executed by the HW2 engine at startup.

## File Structure

```lua
NewShipType = StartShipConfig()

-- Identity
NewShipType.displayedName = "$1538"   -- Localization string ID
NewShipType.sobDescription = "$1539"

-- Combat stats
NewShipType.maxhealth = 170000
NewShipType.sideArmourDamage = 1.0    -- Damage multiplier from sides
NewShipType.rearArmourDamage = 1.0    -- Damage multiplier from rear

-- Movement
NewShipType.thrusterMaxSpeed = 100
NewShipType.mainEngineMaxSpeed = 120
NewShipType.rotationMaxSpeed = 6
NewShipType.thrusterAccelTime = 6     -- Seconds to reach max thruster speed
NewShipType.thrusterBrakeTime = 5
NewShipType.mainEngineAccelTime = 15
NewShipType.mainEngineBrakeTime = 14
NewShipType.rotationAccelTime = 5
NewShipType.rotationBrakeTime = 3

-- Economy
NewShipType.buildCost = 4000          -- RU cost
NewShipType.buildTime = 280           -- Seconds to build

-- Sensors
NewShipType.prmSensorRange = 7000     -- Primary (short) sensor range
NewShipType.secSensorRange = 8000     -- Secondary (long) sensor range

-- AI families (used for build/attack/avoidance logic)
NewShipType.BuildFamily = "Battlecruiser_Hgn"
NewShipType.AttackFamily = "BigCapitalShip"
NewShipType.ArmourFamily = "HeavyArmour"

-- Supply classification (economy weight)
setSupplyValue(NewShipType, "Capital", 1.0)

-- AI value weights (influences build priority)
NewShipType.frigateValue = 80
NewShipType.totalValue = 110

-- Abilities
addAbility(NewShipType, "CanAttack", ...)
addAbility(NewShipType, "CanBuildShips", ...)

-- Weapon hardpoints
StartShipHardPointConfig(NewShipType, "Weapon Top", "Hardpoint_IonBeam1", ...)

-- Visual / death
SpawnSalvageOnDeath(NewShipType, "Slv_Chunk_Lrg03", ...)
LoadModel(NewShipType, 1)
```

## Key Balance Fields

| Field | Description |
|-------|-------------|
| `maxhealth` | Hit points |
| `thrusterMaxSpeed` | Lateral/strafing top speed |
| `mainEngineMaxSpeed` | Forward top speed |
| `rotationMaxSpeed` | Turning speed (degrees/sec) |
| `thrusterAccelTime` | How quickly thruster speed is reached (higher = sluggish) |
| `mainEngineAccelTime` | Same for main engine |
| `buildCost` | RU cost to construct |
| `buildTime` | Seconds to build |
| `prmSensorRange` | Detection range for nearby units |
| `secSensorRange` | Detection range for distant units |
| `goalReachEpsilon` | How close the ship must get to consider a move goal reached |
| `slideMoveRange` | Maximum distance for slide maneuvers |

## Tactics Multipliers

```lua
setTacticsMults(NewShipType, "ENGINEACCEL", aggressive, evasive, neutral)
```

Modifies behavior per combat stance. `ENGINEACCEL`, `THRUSTERACCEL`, `ROTATION`, `ROTATIONACCEL`, `FIRERATE` are the available channels.

## Hardpoints and Weapons

`StartShipHardPointConfig` binds a hardpoint slot to an ordered list of possible subsystems/weapons. The first entry is the default; the rest are optional upgrades the player can install.

```lua
StartShipHardPointConfig(
    NewShipType,
    "Weapon Top",           -- Slot display name
    "Hardpoint_IonBeam1",   -- 3D model hardpoint name
    "Weapon",               -- Slot type
    "Generic",              -- Mount type (Generic = player-swappable, Innate = fixed)
    "Destroyable",          -- Whether the slot can be destroyed
    "",                     -- Default (empty = no default weapon)
    "hgn_battlecruisergatlinggunturrettop",   -- Option 1
    "hgn_battlecruiserminelaunchertop",       -- Option 2
    "Hgn_BattleCruiserIonBeamTurretTop"       -- Option 3
)
```

`StartShipWeaponConfig` adds a fixed weapon directly to the ship body (not a subsystem slot):

```lua
StartShipWeaponConfig(NewShipType, "Hgn_PulsarSide", "Weapon_pulsar", "Weapon_pulsar")
```

## Ship Roster

### Hiigaran (HGN)

| Ship | Role | Cost | HP |
|------|------|------|----|
| `hgn_scout` | Scouting | low | low |
| `hgn_interceptor` | Anti-fighter | low | low |
| `hgn_attackbomber` | Anti-capital | medium | low |
| `hgn_assaultcorvette` | Multipurpose | medium | medium |
| `hgn_pulsarcorvette` | Anti-capital | medium | medium |
| `hgn_assaultfrigate` | Frontline brawler | medium | high |
| `hgn_ioncannonfrigate` | Long-range anti-capital | high | high |
| `hgn_torpedofrigate` | Artillery | high | high |
| `hgn_defensefieldfrigate` | Support / defense | high | high |
| `hgn_marinefrigate` | Capture | high | high |
| `hgn_destroyer` | Destroyer | high | very high |
| `hgn_carrier` | Builder / mothership | very high | very high |
| `hgn_battlecruiser` | Capital ship | very high | 170 000 |
| `hgn_heavybattlecruiser` | Super capital | very high | very high |
| `hgn_resourcecontroller` | Economy | high | high |

### Vaygr (VGR)

| Ship | Role |
|------|------|
| `vgr_scout` | Scouting |
| `vgr_interceptor` | Anti-fighter |
| `vgr_lancefighter` | Anti-corvette |
| `vgr_bomber` | Anti-capital |
| `vgr_commandcorvette` | Command/support |
| `vgr_lasercorvette` | Anti-fighter |
| `vgr_missilecorvette` | Anti-capital |
| `vgr_assaultfrigate` | Brawler |
| `vgr_heavymissilefrigate` | Bombardment |
| `vgr_infiltratorfrigate` | Capture/EMP |
| `vgr_destroyer` | Destroyer |
| `vgr_carrier` | Builder |
| `vgr_battlecruiser` | Capital |
| `vgr_heavybattlecruiser` | Super capital |
| `vgr_resourcecontroller` | Economy |

### Kushan / Taiidan (KUS / TAI)

Scout variants only (primarily classic HW1-style units).

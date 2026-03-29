# Races / Factions

RFF has four playable factions. Each faction's data lives in two places:

- **Ship/weapon/subsystem definitions**: `src/ship/`, `src/weapon/`, `src/subsystem/` (prefixed with the faction code)
- **AI scripts**: `src/scripts/races/<faction>/scripts/`
- **Starting fleets**: `src/scripts/startingfleets/<faction>NN.lua`

## Script Structure Per Faction

```
src/scripts/races/<faction>/scripts/
├── ai_build.lua          # What ships to build and when
├── ai_subsystems.lua     # Subsystem upgrade priorities
├── ai_upgrades.lua       # Technology research priorities
├── def_build.lua         # Defensive construction behavior
├── def_research.lua      # Defensive research priorities
└── deathmatch/props/gbx.lua  # Deathmatch mode config
```

---

## Hiigaran (HGN)

**Prefix:** `HGN`
**Style:** Balanced. Strong defensive options (defense field frigate, pulsar corvette). Variety of attack patterns.

**Constants used in scripts:**

```lua
HGN_RESOURCECOLLECTOR
HGN_RESOURCECONTROLLER
HGN_SCOUT
HGN_INTERCEPTOR
HGN_ATTACKBOMBER
HGN_CARRIER
HGN_SHIPYARD
HGN_DESTROYER
HGN_BATTLECRUISER
HGN_TORPEDOFRIGATE
```

**AI Build Logic (`ai_build.lua`):**

- Early game: biases toward fighters/corvettes
- Mid game: unlocks frigates once military strength grows
- Late game: destroyers and battle cruisers when conditions allow
- Builds resource controllers when collector count exceeds 9
- Builds shipyard before battle cruiser if under attack pressure

**Key unique units:**
- `hgn_defensefieldfrigate` — emits a protective defense field for nearby ships
- `hgn_torpedofrigate` — long-range nuclear torpedo artillery
- `hgn_pulsarcorvette` — effective vs. capital ships
- `hgn_heavybattlecruiser` — super capital variant

---

## Vaygr (VGR)

**Prefix:** `VGR`
**Style:** Aggressive and fast. Strong missile/laser units. Plasma lance fighter for anti-corvette.

**Key constants:**

```lua
VGR_RESOURCECOLLECTOR
VGR_RESOURCECONTROLLER
VGR_SCOUT
VGR_INTERCEPTOR
VGR_LANCEFIGHTER
VGR_BOMBER
VGR_CARRIER
VGR_DESTROYER
VGR_BATTLECRUISER
```

**Key unique units:**
- `vgr_lancefighter` — specialized anti-corvette plasma lance
- `vgr_infiltratorfrigate` — EMP and capture operations
- `vgr_heavymissilefrigate` — heavy missile bombardment
- `vgr_commandcorvette` — command and squad-buffing role
- `vgr_heavybattlecruiser` — Vaygr super capital

**Vaygr attack scripts** are distinct variants prefixed with `v` (e.g., `vcorvette_vs_capship_ar`, `vinterceptor_vs_fighter`) reflecting their different flight characteristics.

---

## Kushan (KUS)

**Prefix:** `KUS`
**Style:** Classic HW1 faction. Primarily scout/fighter based in RFF.

Currently, Kushan participates with scout units and HW1-era attack scripts (`hw1fighter_vs_fighter`, `hw1fighter_vs_hw2fighter`).

---

## Taiidan (TAI)

**Prefix:** `TAI`
**Style:** Classic HW1 faction, mirror to Kushan.

Parallel structure to Kushan; primarily scout and fighter units in RFF's current scope.

---

## AI Build Script Patterns

### `DetermineDemandWithNoCounterInfo_<Race>()`

Called when the AI has no intelligence on the enemy. Sets demand by ship class using probability thresholds stored in `sg_randFavorShipType`:

```lua
function DetermineDemandWithNoCounterInfo_Hiigaran()
    if (sg_randFavorShipType < 55) then
        ShipDemandAddByClass(eFighter, 1)
    elseif (sg_randFavorShipType < 85) then
        ShipDemandAddByClass(eCorvette, 1)
    elseif (g_LOD < 2 and sg_randFavorShipType < 95) then
        ShipDemandAddByClass(eFrigate, 1)
    else
        ShipDemandAdd(kDestroyer, 1.0)
    end
end
```

### `DetermineSpecialDemand_<Race>()`

Override demand based on game state: time elapsed, enemy builder count, resource levels, military strength, research status. Typical patterns:

- Suppress capital ships early game
- Scale up builders (carriers) when enemy has many
- Adjust torpedo frigate demand based on research progress
- Suppress platforms when military is strong

### Useful AI Globals

| Variable | Meaning |
|----------|---------|
| `s_enemyIndex` | Current primary enemy |
| `s_selfTotalValue` | Own total fleet value |
| `s_militaryStrength` | Own military power estimate |
| `g_LOD` | Level of detail / match phase |
| `sg_randFavorShipType` | Random seed influencing ship preference |
| `sg_moreEnemies` | Number of enemies scalar |

### Useful AI Functions

| Function | Purpose |
|----------|---------|
| `ShipDemandAdd(type, weight)` | Add demand for specific ship |
| `ShipDemandAddByClass(class, weight)` | Add demand for ship class |
| `ShipDemandSet(type, value)` | Set exact demand for ship |
| `ShipDemandGet(type)` | Read current demand |
| `NumSquadrons(type)` | Count own active squadrons |
| `NumSquadronsQ(type)` | Count own queued squadrons |
| `numActiveOfClass(player, class)` | Count active ships of class for player |
| `IsResearchDone(tech)` | Check research completion |
| `GetRU()` | Current resource units |
| `UnderAttackThreat()` | Attack pressure estimate |
| `gameTime()` | Elapsed game time in seconds |

---

## Starting Fleets

Files in `src/scripts/startingfleets/` define what each player starts with.

| File | Faction | Notes |
|------|---------|-------|
| `hiigaran00.lua` | HGN | Standard |
| `hiigaran_carrier.lua` | HGN | Carrier-start variant |
| `vaygr00.lua` | VGR | Standard |
| `vaygr_carrier.lua` | VGR | Carrier-start variant |
| `kushan00.lua` | KUS | Standard |
| `taiidan00.lua` | TAI | Standard |

Each file calls engine APIs to spawn the flagship, support ships, resource collectors, and weapon platforms, then configures their subsystems.

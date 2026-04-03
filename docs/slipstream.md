# Slipstream: The Price of Freedom — Reference

**Slipstream: The Price of Freedom** (TPOF) is the direct design ancestor of RFF. It was a mod for _Homeworld 2 Classic_ (not HWR), created by the same author. Understanding TPOF is essential context for design decisions in RFF — many balance targets, attack script patterns, AI behaviors, and faction philosophies carry over.

Source code: https://github.com/tdmckenney0/slipstream-the-price-of-freedom
Local copy (when available): `refs/slipstream-the-price-of-freedom/`

---

## Design Philosophy

TPOF reimagined Homeworld 2 as a **fast-paced tactical arena** rather than a campaign game. Its core principles:

- **Ships are much faster and more durable than vanilla HW2.** Speeds are roughly 2–3× higher; health values are substantially larger. Combat is decisive but ships can take sustained punishment.
- **No traditional tech race.** Core technologies are pre-granted at match start, removing the early-game bottleneck and letting players focus on fleet composition and tactical decisions.
- **Modular loadout system.** Ships have named hardpoints that accept different weapons mid-match. Players configure their ships for specific engagement styles rather than having static weapon suites. (RFF does not carry this forward — hardpoints are fixed — but the underlying ship/hardpoint/weapon chain is the same.)
- **Constant AI pressure.** The CPU attacks frequently with smaller groups rather than massing a single decisive strike. This keeps games active and prevents turtling.
- **Irreplaceable super-units.** The SRI Dreadnaught (500k HP) is a high-stakes unit — losing it matters.

Inspirations cited: _Homeworld: Cataclysm_, _Halo_, _Earth 2150_.

---

## Factions

TPOF includes only **Hiigaran** and **Vaygr** as playable factions. There are no Kushan or Taiidan equivalents. Two non-playable factions appear as map/scenario actors: **Keeper** (KPR) and **Bentusi** (BEN). **SRI Corp** provides special high-tier units available to both sides.

| Faction | Prefix | Notes |
|---------|--------|-------|
| Hiigaran | `HGN_` | Balanced; defense-field capable; battlecruiser-focused |
| Vaygr | `VGR_` | Aggressive; lance fighters; missile-heavy |
| SRI Corp | `SRI_` | Non-playable special units (Dreadnaught, Sajuuk, CommandBase) |
| Keeper | `KPR_` | Non-playable scenario actor |
| Bentusi | `BEN_` | Non-playable scenario actor |

**Key difference from RFF:** RFF adds Kushan (`KUS`) and Taiidan (`TAI`) as fully playable HW1-style factions. TPOF had none.

---

## Ship Roster and Stats

### Hiigaran (`HGN_`)

| Ship | Class | Health | Speed | Cost (RU) | Build Time |
|------|-------|--------|-------|-----------|------------|
| Interceptor | Fighter | 400 | 780–845 | 800 | 60s |
| Assault Corvette | Corvette | — | — | — | — |
| Pulse Corvette | Corvette | — | — | — | — |
| Assault Frigate | Frigate | 16,000 | 364–390 | 800 | 50s |
| Ion Cannon Frigate | Frigate | — | — | — | — |
| Torpedo Frigate | Frigate | — | — | — | — |
| Destroyer | Small Cap | — | — | — | — |
| Battlecruiser | Capital | 250,000 | 130 | 5,000 | 280s |
| Heavy Battlecruiser | Capital | — | — | — | — |
| Resource Controller | Utility | — | — | — | — |

Battlecruiser carries 12 fighters / 75 corvettes. EMP shields standard on all capital ships (750–10,000 capacity, 20s recharge).

### Vaygr (`VGR_`)

| Ship | Class | Health | Speed | Cost (RU) | Build Time |
|------|-------|--------|-------|-----------|------------|
| Lance Fighter | Fighter | — | — | — | — |
| Interceptor | Fighter | 300 | 793–858 | 700 | 35s |
| Bomber | Fighter | 280 | 715–780 | 650 | 40s |
| Laser Corvette | Corvette | — | — | — | — |
| Missile Corvette | Corvette | — | — | — | — |
| Assault Frigate | Frigate | — | — | — | — |
| Heavy Missile Frigate | Frigate | — | — | — | — |
| Destroyer | Small Cap | 70,000 | 195 | 3,000 | 165s |
| Battlecruiser | Capital | — | — | — | — |
| Heavy Battlecruiser | Capital | 280,000 | 163 | 10,000 | — |
| Resource Controller | Utility | — | — | — | — |

### SRI Corp (Special Units)

| Ship | Health | Speed | Cost (RU) | Build Time | Notes |
|------|--------|-------|-----------|------------|-------|
| Sri_Dreadnaught | 500,000 | 69 | 1,500 | ~1s | Irreplaceable; losing one matters |
| Sri_Sajuuk | — | — | — | — | Ultra-tier |
| Sri_CommandBase | — | — | — | — | Base structure |

Armor multipliers on SRI units: 0.4–0.5× (significantly more resistant than standard ships, which take 1.2× from side/rear).

---

## Weapon Systems

### Loadout System (TPOF-Specific)

TPOF ships have named hardpoints accepting swappable weapons mid-match. This is the primary strategic customization axis — not research, not build order. Each ship has top and bottom turret hardpoints plus optional forward/booster slots. **RFF does not use this system** — hardpoints in RFF are fixed. But the `.ship` hardpoint fields (`StartShipHardPointConfig`) and the ship→subsystem→weapon chain are the same.

### Hiigaran Weapons

| Weapon | Role |
|--------|------|
| Gatling Gun Turret | Rapid-fire anti-fighter |
| Pulsar Turret | Mid-range energy platform |
| Ion Beam Turret | Heavy continuous damage, capital focus |
| Mine Launcher | Area denial |
| Plasma Burst Turret | Anti-frigate / anti-capital |
| Hull Defense Guns | Point defense |
| Nuclear Mine Launcher | Heavy area denial |

### Vaygr Weapons

| Weapon | Role | Notes |
|--------|------|-------|
| Pulse Cannon (Gimble) | Light fast-fire | 30 HP/hit, range 1800, accuracy: 0.12 vs fighters, 0.6 vs frigates |
| Laser / Rapid Laser | Energy beam | Gimble-mounted |
| Heavy Fusion Missile | Heavy homing | Capital engagement |
| Concussion Missile | Anti-fighter homing | |
| Autocannon | Ballistic multi-role | |
| Scattershot | Short-range area | |
| Booster | Tactical mobility | Front/rear hardpoint |

---

## Attack Scripts

TPOF has **34 attack scripts** (vs 141 in RFF). Naming convention and structure are the same: `<maneuver>_<attacker>_vs_<target>.lua`. Key patterns:

| Script | Behavior Summary |
|--------|-----------------|
| `dogfight_*.lua` | Aggressive close-range, random evasive actions. Formation break: Scatter. Min speed 75%. 700:100 inaction weighting. |
| `flyby_*.lua` | Strafing attack runs. 33+ variants for different matchups. |
| `strafe_*.lua` | Low-altitude passes. Break: ClimbAndPeelOff, max break 2000u, trigger at 500u. No explicit fire actions — positioning emphasized. |
| `topattack_*.lua` | Diving attacks from above. Break: StraightAndScatter (1300u). Trigger 500u, safe distance 1500u. 13:1 ratio stable firing vs evasion. |
| `dread_strafe.lua` | Dreadnaught-specific strafe behavior. |
| `dogfight_capital.lua` | Capital-scale dogfighting. |

These scripts are the direct predecessors to the attack scripts in `src/scripts/attack/`. When adding or tuning attack styles in RFF, TPOF's 34 scripts are the reference baseline.

---

## AI Architecture

### Build Logic (`cpubuild.lua`)

- `sg_shipDemand = 8` — constant construction pressure
- `sg_militaryToBuildPerCollector = 2` — 2 military per resource collector
- Priority order: Heavy Battlecruisers (demand 3.0–5.0) → Battlecruisers (1.5–2.5) → Destroyers (1.0) → Frigates (0.75–1.5) → Fighters/Corvettes (0.75)
- Heavy Battlecruiser triggered when: collectors ≥ 3 OR RUs > 500; additional 2.0× multiplier when RUs > 2000
- Early game: scouts and interceptors; mid game (self_totalvalue > 80): transition to frigates; late game: aggressive capital pursuit

### Military Tactics (`cpumilitary.lua`)

- Easy: 50% → 75% attack; initial attack at 10 min (vs 20 min vanilla)
- Medium/Hard: 100% attack, constant aggression
- Minimum group sizes: 3 squads (down from 5); value threshold 150 (down from 200)
- Hard difficulty wave interval: 20–40 seconds
- Capital ships attempt tactical hyperspace jumps to enemy positions (checked every 30s)

### Research (`cpuresearch.lua`)

**Hiigaran priority:** Battlecruiser Ion Weapons → Platform Ion Weapons → Destroyer Tech → Bomber/Torpedo improvements → special units (defense field frigates, ECM probes, gravity mines) once military pop > 10.

**Vaygr priority:** Hyperspace Gate Tech → Battlecruiser Ion Weapons → Destroyer Guns + Lance Beams → Plasma Bombs (highest mult 1.0) → Corvette/Frigate tech → special units (mine layers, command corvettes, infiltrators) once military pop > 10.

Research unlocks at: 2000 RU + 6 collectors, or 8000+ RU. Always prioritizes upgrades for units already built.

### Upgrades

Both factions use a 2-tier health + 2-tier speed upgrade system applied to all unit classes. No exotic or faction-asymmetric upgrade paths — the philosophy is uniform improvement across the board. **RFF inherits this structure** in `src/scripts/races/<faction>/scripts/ai_upgrades.lua`.

---

## Research and Restrictions

**Pre-granted at match start:** Core abilities (DestroyerTech, BattlecruiserIonWeapons, etc.) are given with `progress = 1` — no research queue needed.

**Restricted units:** Many vanilla HW2 units are disabled via `MPRestrict()`. Scouts, various frigate subtypes, and many upgrade paths are removed. This narrows the decision space to loadout configuration and fleet mix.

RFF takes a different approach — all four factions are playable and the unit roster is expanded rather than restricted.

---

## How TPOF Differs from Vanilla HW2

| Aspect | Vanilla HW2 | TPOF |
|--------|-------------|------|
| Ship speed | Baseline | 2–3× faster |
| Ship health | Baseline | Significantly higher |
| Tech progression | Full research tree | Core techs pre-granted |
| Unit customization | Fixed weapon suites | Modular hardpoint loadouts |
| Factions | HGN, VGR, KUS, TAI | HGN, VGR only |
| AI aggression | Large infrequent waves | Small frequent waves, constant pressure |
| Super-units | None | Irreplaceable Dreadnaught |
| Restricted units | All available | Many vanilla units removed |

---

## Relation to RFF

RFF carries forward the core TPOF design goals but adapts them for _Homeworld Remastered_ with a larger scope:

| TPOF Feature | RFF Treatment |
|--------------|---------------|
| Faster/more durable ships | Preserved and extended to all 4 factions |
| HGN + VGR only | KUS and TAI added as HW1-style factions |
| Modular loadout system | Not carried forward; hardpoints are fixed |
| Pre-granted research | Preserved in principle; research paths still exist |
| Constant AI pressure | Preserved in AI build/military scripts |
| Deathmatch focus | Preserved; skirmish-oriented maps |
| 34 attack scripts | Expanded to 141 attack scripts |

When making balance decisions — especially for HGN and VGR — check TPOF ship stats as the historical baseline alongside vanilla HWR values. TPOF stats represent "what felt right in HW2 Classic," which is a useful anchor even though HWR has different engine characteristics.

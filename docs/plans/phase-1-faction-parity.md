# Phase 1 Implementation Plan: KUS and TAI Faction Parity

## Key Finding

**The design is already done.** `src/ai/default/classdef.lua` contains the complete intended ship rosters for both factions, fully mapped to AI classes. The starting fleet files (`kushan00.lua`, `taiidan00.lua`) reference the full rosters. Every ship constant — `KUS_INTERCEPTOR`, `TAI_FIELDFRIGATE`, `KUS_HEAVYCRUISER`, etc. — is already in the AI system.

The only work is creating the missing asset files: `.ship`, `.wepn`, `.subs`, and AI scripts.

`classdef.lua` does **not** need to be modified.

---

## Full Ship Roster (from classdef.lua + fleet files)

### Kushan (KUS) — 20 missing ship files

| Ship | Class | AI Role | Notes |
|------|-------|---------|-------|
| `kus_interceptor` | Fighter | `eFighter`, `eAntiFighter`, `eGoodRepairAttackers` | Standard dogfighter |
| `kus_attackbomber` | Fighter | `eAntiFrigate`, `eSubSystemAttackers` | Anti-capital; commented out of `eFighter` — uses separate demand path |
| `kus_cloakedfighter` | Fighter | `eFighter`, `eAntiFighter` | Stealth fighter |
| `kus_defender` | Fighter | `eFighter`, `eAntiFighter` | Point defense fighter |
| `kus_lightcorvette` | Corvette | `eCorvette`, `eAntiFighter` | Fast harassment |
| `kus_heavycorvette` | Corvette | `eCorvette`, `eAntiCorvette` | Anti-corvette brawler |
| `kus_multiguncorvette` | Corvette | `eCorvette`, `eAntiFighter`, `eGoodRepairAttackers` | Rapid-fire anti-strike-craft |
| `kus_salvagecorvette` | Corvette | `eCorvette`, `eUselessShips` | Capture; AI suppressed |
| `kus_minelayercorvette` | Corvette | `eCorvette`, `eUselessShips` | Area denial; AI suppressed |
| `kus_repaircorvette` | Corvette | `eNonThreat` | Repair; AI non-threat |
| `kus_assaultfrigate` | Frigate | `eFrigate`, `eAntiCorvette`, `eAntiFrigate`, `eGoodRepairAttackers` | Frontline brawler |
| `kus_ioncannonfrigate` | Frigate | `eFrigate`, `eAntiFrigate`, `eSubSystemAttackers`, `eGoodRepairAttackers` | Anti-capital |
| `kus_dronefrigate` | Frigate | `eFrigate`, `eAntiFighter`, `eAntiCorvette` | Launches drone swarms |
| `kus_supportfrigate` | Frigate | `eUselessShips` | Repair frigate; AI suppressed |
| `kus_destroyer` | SmallCapitalShip | `eCapital`, `eAntiCorvette`, `eAntiFrigate`, `eGoodRepairAttackers`, `eDestroyer` | Standard destroyer |
| `kus_missiledestroyer` | SmallCapitalShip | `eCapital`, `eAntiFighter`, `eAntiCorvette`, `eGoodRepairAttackers`, `eDestroyer` | Missile variant |
| `kus_heavycruiser` | BigCapitalShip | `eCapital`, `eAntiFrigate`, `eGoodRepairAttackers`, `eBattleCruiser` | KUS super-capital |
| `kus_carrier` | Mothership | `eBuilder`, `eDropOff`, `eSalvageDropOff`, `eCapital`, `eNonThreat` | Production hub |
| `kus_mothership` | Mothership | `eMotherShip`, `eBuilder`, `eDropOff`, `eSalvageDropOff`, `eCapital` | Starting flagship |
| `kus_resourcecontroller` | Utility | `eRefinery`, `eDropOff`, `eNonThreat` | Resource refinery |

### Taiidan (TAI) — 20 missing ship files

| Ship | Class | AI Role | Notes |
|------|-------|---------|-------|
| `tai_interceptor` | Fighter | `eFighter`, `eAntiFighter`, `eGoodRepairAttackers` | Standard dogfighter |
| `tai_attackbomber` | Fighter | `eAntiFrigate` | Anti-capital; commented out of `eFighter` |
| `tai_defensefighter` | Fighter | `eFighter`, `eAntiFighter`, `eAntiFrigate` | EMP/disable fighter — unique TAI unit |
| `tai_defender` | Fighter | `eFighter`, `eAntiFighter` | Point defense |
| `tai_lightcorvette` | Corvette | `eCorvette`, `eAntiFighter` | Fast harassment |
| `tai_heavycorvette` | Corvette | `eCorvette`, `eAntiCorvette` | Anti-corvette brawler |
| `tai_multiguncorvette` | Corvette | `eCorvette`, `eAntiFighter`, `eGoodRepairAttackers` | Rapid-fire anti-strike-craft |
| `tai_salvagecorvette` | Corvette | `eCorvette`, `eUselessShips` | Capture; AI suppressed |
| `tai_minelayercorvette` | Corvette | `eCorvette`, `eUselessShips` | Area denial; AI suppressed |
| `tai_repaircorvette` | Corvette | `eNonThreat` | Repair; AI non-threat |
| `tai_assaultfrigate` | Frigate | `eFrigate`, `eAntiCorvette`, `eAntiFrigate`, `eGoodRepairAttackers` | Frontline brawler |
| `tai_ioncannonfrigate` | Frigate | `eFrigate`, `eAntiFrigate`, `eGoodRepairAttackers` | Anti-capital |
| `tai_fieldfrigate` | Frigate | `eFrigate`, `eShield` | TAI equivalent of HGN defense field frigate |
| `tai_supportfrigate` | Frigate | `eUselessShips` | Repair frigate; AI suppressed |
| `tai_destroyer` | SmallCapitalShip | `eCapital`, `eAntiCorvette`, `eAntiFrigate`, `eGoodRepairAttackers`, `eDestroyer` | Standard destroyer |
| `tai_missiledestroyer` | SmallCapitalShip | `eCapital`, `eAntiFighter`, `eAntiCorvette`, `eGoodRepairAttackers`, `eDestroyer` | Missile variant |
| `tai_heavycruiser` | BigCapitalShip | `eCapital`, `eAntiFrigate`, `eGoodRepairAttackers`, `eBattleCruiser` | TAI super-capital |
| `tai_carrier` | Mothership | `eBuilder`, `eDropOff`, `eSalvageDropOff`, `eCapital`, `eNonThreat` | Production hub |
| `tai_mothership` | Mothership | `eMotherShip`, `eBuilder`, `eDropOff`, `eSalvageDropOff`, `eCapital` | Starting flagship |
| `tai_resourcecontroller` | Utility | `eRefinery`, `eDropOff`, `eNonThreat` | Resource refinery |

---

## Ship Specifications

All KUS/TAI ships use HW1-doctrine values: cheaper and faster to build than HGN/VGR equivalents, lower individual health, but same weapon families. The `ArmourFamily` for all KUS/TAI ships is the `_hw1` variant (e.g. `"Unarmoured_hw1"`, `"LightArmour_hw1"`, etc.), matching the existing `kus_scout` pattern. `BuildFamily` uses the faction-specific HW1 family (e.g. `"Fighter_Kus"`, `"Corvette_Kus"`).

### Fighters

#### `kus_interceptor` / `tai_interceptor`
- **Template:** `hgn_interceptor` (standard interceptor pattern)
- **Health:** 75 (vs. HGN 90 — HW1 fighters are lighter)
- **Cost / Time:** 300 RU / 25s (vs. HGN 450 / 35s — cheaper, faster)
- **Speed:** 650 thruster/main (vs. HGN 600 — HW1 fighters are faster individually)
- **ArmourFamily:** `"Unarmoured_hw1"`
- **BuildFamily:** `"Fighter_Kus"` / `"Fighter_Tai"`
- **AttackFamily:** `"Fighter_hw1"`
- **Weapon:** `kus_massdrivers` / `tai_massdrivers` (new — see Weapons section)
- **Attack styles:** `Fighter_vs_Fighter` (engine built-in), `Flyby_Interceptor_vs_Fighter`, `Flyby_Interceptor_vs_Frigate`, `Fighter_vs_Corvette`, `Fighter_vs_CapShip`, `TopAttack_Interceptor_vs_Subsystem`, `Flyby_Interceptor_vs_Mothership`, `Flyby_Interceptor_vs_ResourceLarge`, `MoveToTargetAndShoot`
- **Note:** Same CanAttack ability block as `kus_scout` with upgraded attack styles

#### `kus_attackbomber` / `tai_attackbomber`
- **Template:** `hgn_attackbomber`
- **Health:** 90
- **Cost / Time:** 400 RU / 30s
- **Speed:** 500 thruster/main
- **ArmourFamily:** `"Unarmoured_hw1"`
- **BuildFamily:** `"Bomber_Kus"` / `"Bomber_Tai"`
- **AttackFamily:** `"Fighter_hw1"`
- **Weapon:** `kus_plasmabomb` (new — clone of `hgn_bomberplasmadriver` with HW1 tuning)
- **Attack styles:** `Flyby_Bomber_vs_Fighter`, `Flyby_Bomber_vs_Frigate`, `Flyby_Bomber_vs_Mothership`, `Strafe_Bomber_vs_CapShip`, `TopAttack_Bomber_vs_SubSystem`, `Flyby_Bomber_vs_ResourceLarge`
- **Note:** Commented out of `eFighter` in classdef — AI uses a direct demand path; the ship is still fully functional

#### `kus_cloakedfighter`
- **Template:** `hgn_interceptor` base, with `CustomCommand` for cloak ability
- **Health:** 60
- **Cost / Time:** 350 RU / 30s
- **Speed:** 700
- **ArmourFamily:** `"Unarmoured_hw1"`
- **Weapon:** `kus_massdrivers` (shared with interceptor)
- **Attack styles:** Same as `kus_interceptor`
- **Special ability:** `addAbility(NewShipType,"CloakAbility",...)` — cloaks the unit; engine built-in
- **Note:** `AddShipMultiplier` sensor distortion (same as `kus_scout`)

#### `tai_defensefighter`
- **Template:** `hgn_interceptor` base
- **Health:** 80
- **Cost / Time:** 400 RU / 30s
- **Speed:** 580
- **ArmourFamily:** `"Unarmoured_hw1"`
- **Weapon:** `tai_emppulse` (new — EMP disable weapon; short range, disables subsystems)
- **Attack styles:** `Fighter_vs_Fighter`, `Flyby_Interceptor_vs_Frigate`, `Fighter_vs_CapShip` — prioritizes frigate/capital targets
- **Note:** In `eAntiFrigate` classdef entry, meaning AI treats it as an anti-capital asset

#### `kus_defender` / `tai_defender`
- **Template:** Fighter base, defensive role
- **Health:** 80
- **Cost / Time:** 250 RU / 20s
- **Speed:** 550
- **ArmourFamily:** `"Unarmoured_hw1"`
- **Weapon:** `kus_massdrivers` / `tai_massdrivers`
- **Attack styles:** `Fighter_vs_Fighter`, `Flyby_Interceptor_vs_Fighter` — optimized vs. strike craft
- **Note:** Lowest cost fighter; primary anti-fighter screen

---

### Corvettes

All corvettes use `ArmourFamily = "LightArmour_hw1"`, `AttackFamily = "Corvette_hw1"`.

#### `kus_lightcorvette` / `tai_lightcorvette`
- **Template:** `hgn_assaultcorvette` (light variant)
- **Health:** 450
- **Cost / Time:** 400 RU / 30s
- **Speed:** 350
- **Weapon:** `kus_lightcorvettegun` (new — light rapid-fire gun)
- **Attack styles:** `Flyby_Corvette_vs_Corvette`, `AttackRunCorvetteVsCapShip`, `Fighter_vs_Fighter`

#### `kus_heavycorvette` / `tai_heavycorvette`
- **Template:** `hgn_assaultcorvette` (heavier variant)
- **Health:** 650
- **Cost / Time:** 550 RU / 40s
- **Speed:** 280
- **Weapon:** `kus_heavycorvettegun` (new — heavier autocannon)
- **Attack styles:** `AttackRunCorvetteVsCapShip`, `Flyby_Corvette_vs_Corvette`

#### `kus_multiguncorvette` / `tai_multiguncorvette`
- **Template:** `hgn_assaultcorvette` (anti-fighter specialist)
- **Health:** 550
- **Cost / Time:** 500 RU / 38s
- **Speed:** 300
- **Weapon:** `kus_multigunsturret` (new — high fire-rate flak gun; good accuracy vs. Fighter/Corvette, poor vs. Frigate+)
- **Attack styles:** `Flyby_Corvette_vs_Corvette`, `Fighter_vs_Fighter` (acts like a fast-firing turret)

#### `kus_salvagecorvette` / `tai_salvagecorvette`
- **Template:** HW1 salvage corvette pattern
- **Health:** 400
- **Cost / Time:** 450 RU / 35s
- **Speed:** 320
- **Weapon:** `kus_salvagebeam` (new — capture beam; `WeaponType = "Capture"`)
- **Attack styles:** `MoveToTargetAndShoot` (the salvage beam targets opponents)
- **Special ability:** `addAbility(NewShipType,"SalvageAbility",...)` — engine capture mechanic

#### `kus_minelayercorvette` / `tai_minelayercorvette`
- **Template:** `hgn_assaultcorvette` base; similar to existing `HGN_MINELAYERCORVETTE` pattern
- **Health:** 400
- **Cost / Time:** 500 RU / 40s
- **Weapon:** Mine launcher weapon (engine built-in mine ability)
- **Special ability:** `addAbility(NewShipType,"MinelayerAbility",...)` with mine deployment

#### `kus_repaircorvette` / `tai_repaircorvette`
- **Template:** Repair corvette pattern (HW1 style)
- **Health:** 500
- **Cost / Time:** 400 RU / 30s
- **Speed:** 320
- **Weapon:** `kus_repairbeam` (new — repair beam; non-damaging, targets allied ships)
- **Special ability:** `addAbility(NewShipType,"RepairAbility",...)` — engine repair mechanic

---

### Frigates

All frigates use `ArmourFamily = "MediumArmour_hw1"`.

#### `kus_assaultfrigate` / `tai_assaultfrigate`
- **Template:** `hgn_assaultfrigate`
- **Health:** 14,000 (vs. HGN 18,000 — lighter HW1 armor)
- **Cost / Time:** 600 RU / 45s
- **Speed:** 120
- **Weapons:** `kus_assaultfrigategun_front`, `kus_assaultfrigategun_left`, `kus_assaultfrigategun_right` (new — 3-turret pattern, clone of `vgr_pulsecannonassaultfrigate*` tuning)
- **Subsystems:** 3 gun hardpoints (front + 2 sides), no modular slots
- **Attack styles:** `Flyby.lua` (generic frontal approach), `MoveToTargetAndShoot`

#### `kus_ioncannonfrigate` / `tai_ioncannonfrigate`
- **Template:** `hgn_ioncannonfrigate`
- **Health:** 13,000
- **Cost / Time:** 600 RU / 40s
- **Speed:** 110
- **Weapon:** `kus_ionbeam` (new — HW1-style ion cannon; shorter range than HGN, faster fire cycle)
- **Subsystem:** `kus_ionbeam_subsystem` (1 forward hardpoint)
- **Attack styles:** `Flyby.lua`, `MoveToTargetAndShoot`

#### `kus_dronefrigate`
- **Template:** Frigate base with drone launcher
- **Health:** 12,000
- **Cost / Time:** 700 RU / 50s
- **Speed:** 100
- **Weapon:** `kus_dronelauncher` (new — fires drone fighters as projectiles/spawns)
- **Attack styles:** `MoveToTargetAndShoot` (drones self-manage after launch)
- **Note:** Unique to KUS. Drones attack nearby enemies autonomously after deployment. TAI does not have this unit — TAI has `tai_fieldfrigate` instead.

#### `tai_fieldfrigate`
- **Template:** `hgn_defensefieldfrigate`
- **Health:** 16,000
- **Cost / Time:** 700 RU / 50s
- **Speed:** 100
- **Weapon:** None offensive (or minimal point defense)
- **Special ability:** Defense field generator (`addAbility(NewShipType,"DefenseFieldAbility",...)`) — same engine ability as HGN defense field frigate
- **Note:** TAI's unique defensive unit, mirrors HGN defense field frigate. Listed in `eShield` in classdef.

#### `kus_supportfrigate` / `tai_supportfrigate`
- **Template:** Repair/support frigate
- **Health:** 15,000
- **Cost / Time:** 650 RU / 45s
- **Weapon:** `kus_repairbeam_frigate` (heavy repair beam, non-combat)
- **Special ability:** `addAbility(NewShipType,"RepairAbility",...)` — heals nearby ships
- **Note:** AI-suppressed (`eUselessShips`). Available to players but AI won't build it proactively.

---

### Capital Ships

All capitals use `ArmourFamily = "HeavyArmour_hw1"`.

#### `kus_destroyer` / `tai_destroyer`
- **Template:** `hgn_destroyer`
- **Health:** 60,000 (vs. HGN 80,000)
- **Cost / Time:** 1,600 RU / 130s
- **Speed:** 70
- **Weapon:** `kus_destroyercannon` (new — kinetic burst variant, clone of `hgn_kineticburstcannondestroyer`)
- **Subsystem:** `kus_destroyercannon_sub` (turret hardpoint)
- **Attack styles:** `Flyby_Destroyer`, `Flyround_Destroyer`

#### `kus_missiledestroyer` / `tai_missiledestroyer`
- **Template:** `hgn_destroyer` base with missile focus
- **Health:** 58,000
- **Cost / Time:** 1,700 RU / 140s
- **Speed:** 65
- **Weapon:** `kus_missilelauncher` (new — homing missiles, good vs. fighters/corvettes; clone of `vgr_heavyfusionmissilelauncherhbc` at smaller scale)
- **Subsystem:** `kus_missilelauncher_sub`
- **Attack styles:** `Flyby_Destroyer`, `Flyround_Destroyer`
- **Note:** In `eAntiFighter` and `eAntiCorvette` — the missile destroyer is the HW1 answer to strike-craft threats that the standard destroyer lacks

#### `kus_heavycruiser` / `tai_heavycruiser`
- **Template:** `hgn_battlecruiser` (lower health, less modular)
- **Health:** 130,000 (vs. HGN BC 170,000 — HW1 capitals are lighter but not completely outmatched)
- **Cost / Time:** 3,200 RU / 240s
- **Speed:** 50
- **Weapons:**
  - `kus_heavycruisercannon` (main forward kinetic cannon — new)
  - `kus_heavycruiserionbeam` (side ion turrets — new; clone of `hgn_ioncannon` for turret use)
- **Subsystems:** forward cannon hardpoint + 2 side ion turrets (no mine launcher, no plasma burst)
- **Attack styles:** `Dogfight_Capital`, `Dread_Strafe`
- **Note:** Less modular than HGN BC (3 weapon slots vs. HGN's 6+). Compensates with lower cost.

---

### Builders

#### `kus_mothership` / `tai_mothership`
- **Template:** HW1 mothership — large, slow, production hub
- **Health:** 250,000
- **Cost:** Starting unit (not buildable in skirmish)
- **Speed:** 20
- **Weapon:** Point defense guns only (`kus_mshulldefensegun`)
- **Subsystems:** Production module (builds all ship types), research module, hyperspace module
- **Note:** Serves as the starting flagship. Much larger profile than HGN carrier.

#### `kus_carrier` / `tai_carrier`
- **Template:** `hgn_carrier`
- **Health:** 70,000
- **Cost / Time:** 2,200 RU / 50s
- **Speed:** 60
- **Weapon:** Hull defense gun only
- **Subsystems:** Production module, fighter bay
- **Note:** KUS/TAI carriers are slightly cheaper than HGN (2,200 vs. 2,800) — reflects swarm doctrine; need more builders

#### `kus_resourcecontroller` / `tai_resourcecontroller`
- **Template:** `hgn_resourcecontroller`
- **Health:** 15,000
- **Cost / Time:** 700 RU / 40s
- **Weapon:** None (or minimal hull defense)
- **Note:** Clone of HGN equivalent with KUS/TAI model reference

---

## Weapons: New Files Required

All new weapons go in `src/weapon/<weapon_name>/<weapon_name>.wepn`. Use the closest HGN/VGR equivalent as a template, adjusting damage, range, and accuracy for HW1 doctrine (typically: higher fire rate, lower per-shot damage, same DPS).

| Weapon | Template | Key Adjustments |
|--------|----------|-----------------|
| `kus_massdrivers` | `hgn_autocannon` | Same stats; rename for KUS identity |
| `tai_massdrivers` | `hgn_autocannon` | Same as kus_massdrivers |
| `kus_plasmabomb` | `hgn_bomberplasmadriver` | Slightly lower per-shot, faster fire rate |
| `tai_plasmabomb` | `hgn_bomberplasmadriver` | Same as kus_plasmabomb |
| `tai_emppulse` | New — EMP type | Short range (2000), disables subsystems, 0 hull damage; `WeaponType = "EMP"` |
| `kus_lightcorvettegun` | `hgn_autocannon` | Scaled up for corvette; moderate damage, high ROF |
| `tai_lightcorvettegun` | Same as kus | Mirror |
| `kus_heavycorvettegun` | `vgr_autocannon` | Higher damage, lower ROF than light corvette |
| `tai_heavycorvettegun` | Same as kus | Mirror |
| `kus_multigunsturret` | `hgn_vulcanplasmaturret` | Very high ROF, lower per-shot; excellent vs. Fighter/Corvette, ~0 vs. Frigate |
| `tai_multigunsturret` | Same as kus | Mirror |
| `kus_salvagebeam` | Capture weapon type | `WeaponType = "Capture"` — no damage, forces capture state |
| `tai_salvagebeam` | Same as kus | Mirror |
| `kus_repairbeam` | Repair weapon type | `WeaponType = "Repair"` — negative damage (heals) allied ships |
| `tai_repairbeam` | Same as kus | Mirror |
| `kus_repairbeam_frigate` | Same as kus_repairbeam | Higher heal rate, longer range |
| `tai_repairbeam_frigate` | Same as kus | Mirror |
| `kus_assaultfrigategun_front` | `vgr_pulsecannonassaultfrigateleft` | Clone, renamed |
| `kus_assaultfrigategun_left` | `vgr_pulsecannonassaultfrigateleft` | Clone, renamed |
| `kus_assaultfrigategun_right` | `vgr_pulsecannonassaultfrigateright` | Clone, renamed |
| `tai_assaultfrigategun_front` | Same as kus | Mirror |
| `tai_assaultfrigategun_left` | Same as kus | Mirror |
| `tai_assaultfrigategun_right` | Same as kus | Mirror |
| `kus_ionbeam` | `hgn_ioncannon` | 80% range of HGN, 85% damage, 110% fire rate |
| `tai_ionbeam` | Same as kus_ionbeam | Mirror |
| `kus_dronelauncher` | New — launches drone fighters | Spawns `kus_defender` units as projectiles; check engine support before implementing |
| `kus_destroyercannon` | `hgn_kineticburstcannondestroyer` | 90% damage, same range |
| `tai_destroyercannon` | Same as kus | Mirror |
| `kus_missilelauncher` | `vgr_heavyfusionmissilelauncherhbc` scaled down | Medium damage, homing, good vs. Fighter/Corvette |
| `tai_missilelauncher` | Same as kus | Mirror |
| `kus_heavycruisercannon` | `hgn_plasmaburst` (destroyer variant) | Primary forward cannon |
| `tai_heavycruisercannon` | Same as kus | Mirror |
| `kus_heavycruiserionbeam` | `hgn_ioncannonturret` | Side turret ion beams |
| `tai_heavycruiserionbeam` | Same as kus | Mirror |
| `kus_mshulldefensegun` | `hgn_hulldefensegun` | Clone; mothership point defense |
| `tai_mshulldefensegun` | Same as kus | Mirror |

**Weapons that do NOT need new files** (reuse existing or engine built-ins):
- Mine launcher: use existing engine `MinelayerAbility` mechanics
- Defense field: `DefenseFieldAbility` is engine built-in (for `tai_fieldfrigate`)
- Cloak: `CloakAbility` is engine built-in (for `kus_cloakedfighter`)

---

## Subsystems: New Files Required

Only ships with turret hardpoints need `.subs` files. Simple single-hardpoint ships (fighters, corvettes) mount weapons directly via `StartShipWeaponConfig`.

| Subsystem file | Ship | Template |
|----------------|------|----------|
| `kus_assaultfrigategun_front.subs` | `kus_assaultfrigate` | `vgr_pulsecannonassaultfrigateleft.subs` |
| `kus_assaultfrigategun_side.subs` | `kus_assaultfrigate` (x2 sides) | `vgr_pulsecannonassaultfrigateleft.subs` |
| `tai_assaultfrigategun_front.subs` | `tai_assaultfrigate` | Mirror |
| `tai_assaultfrigategun_side.subs` | `tai_assaultfrigate` | Mirror |
| `kus_ionbeam_sub.subs` | `kus_ioncannonfrigate` | `hgn_kineticburstcannon.subs` |
| `tai_ionbeam_sub.subs` | `tai_ioncannonfrigate` | Mirror |
| `kus_destroyercannon_sub.subs` | `kus_destroyer` | `hgn_kineticburstcannondestroyer.subs` |
| `tai_destroyercannon_sub.subs` | `tai_destroyer` | Mirror |
| `kus_missilelauncher_sub.subs` | `kus_missiledestroyer` | `hgn_kineticburstcannondestroyer.subs` adapted |
| `tai_missilelauncher_sub.subs` | `tai_missiledestroyer` | Mirror |
| `kus_heavycruiser_cannon_sub.subs` | `kus_heavycruiser` | `hgn_plasmaburstcannon.subs` |
| `kus_heavycruiser_ionside_sub.subs` | `kus_heavycruiser` (x2) | `hgn_battlecruiserionbeamturret.subs` |
| `tai_heavycruiser_cannon_sub.subs` | `tai_heavycruiser` | Mirror |
| `tai_heavycruiser_ionside_sub.subs` | `tai_heavycruiser` | Mirror |

---

## Attack Styles: Existing Scripts to Reuse

The 34 attack scripts in `src/scripts/attack/` cover all archetypes KUS/TAI need. No new attack scripts are required. Assignment per ship class:

| Ship type | Reused scripts |
|-----------|----------------|
| Fighter (interceptor/defender/cloaked) | `Flyby_Interceptor_vs_Fighter`, `Flyby_Interceptor_vs_Frigate`, `Flyby_Interceptor_vs_CapShip`, `Flyby_Interceptor_vs_Mothership`, `Flyby_Interceptor_vs_ResourceLarge`, `TopAttack_Interceptor_vs_Subsystem` |
| Fighter (engine built-ins) | `Fighter_vs_Fighter`, `Fighter_vs_Corvette`, `Fighter_vs_Frigate`, `Fighter_vs_CapShip`, `MoveToTargetAndShoot` |
| Bomber | `Flyby_Bomber_vs_Fighter`, `Flyby_Bomber_vs_Frigate`, `Flyby_Bomber_vs_Mothership`, `Flyby_Bomber_vs_ResourceLarge`, `Strafe_Bomber_vs_CapShip`, `TopAttack_Bomber_vs_SubSystem` |
| Light/heavy/multigun corvette | `Flyby_Corvette_vs_Corvette`, `AttackRunCorvetteVsCapShip` |
| Frigate (assault/ion) | `Flyby` (generic), `MoveToTargetAndShoot` |
| Destroyer | `Flyby_Destroyer`, `Flyround_Destroyer` |
| Heavy cruiser | `Dogfight_Capital`, `Dread_Strafe` |
| Repair/salvage corvette | No combat attack styles needed |

---

## AI Scripts: New Files Required

Neither KUS nor TAI have AI scripts. Create the full directory structure:

```
src/scripts/races/kushan/scripts/
  ai_build.lua
  ai_subsystems.lua
  ai_upgrades.lua
  def_build.lua
  def_research.lua

src/scripts/races/taiidan/scripts/
  ai_build.lua
  ai_subsystems.lua
  ai_upgrades.lua
  def_build.lua
  def_research.lua
```

### `ai_build.lua` — KUS

Pattern: copy `hiigaran/scripts/ai_build.lua`, replace constants and demand biases.

```lua
kCollector    = KUS_RESOURCECOLLECTOR
kRefinery     = KUS_RESOURCECONTROLLER
kScout        = KUS_SCOUT
kInterceptor  = KUS_INTERCEPTOR
kBomber       = KUS_ATTACKBOMBER
kCarrier      = KUS_CARRIER
kDestroyer    = KUS_DESTROYER
kHeavyCruiser = KUS_HEAVYCRUISER

function DetermineDemandWithNoCounterInfo_Kushan()
    -- HW1 swarm bias: fighters much more likely than HW2 equivalents
    if (sg_randFavorShipType < 70) then       -- 70% fighters (vs HGN 55%)
        ShipDemandAddByClass(eFighter, 1)
    elseif (sg_randFavorShipType < 90) then   -- 20% corvettes (vs HGN 30%)
        ShipDemandAddByClass(eCorvette, 1)
    elseif (g_LOD < 2 and sg_randFavorShipType < 97) then
        ShipDemandAddByClass(eFrigate, 1)
    else
        ShipDemandAdd(kDestroyer, 1.0)
    end
end

function DetermineSpecialDemand_Kushan()
    -- Suppress capitals early
    if (gameTime() < 2*60) then
        ShipDemandSet(KUS_DESTROYER, 0)
        ShipDemandSet(KUS_MISSILEDESTROYER, 0)
        ShipDemandSet(KUS_HEAVYCRUISER, 0)
    end
    -- Resource controller when many collectors
    local numResourcers = NumSquadrons(kCollector) + NumSquadronsQ(kCollector)
    if (numResourcers > 9) then
        ShipDemandAdd(kRefinery, 0.5)
    end
    -- Carrier expansion vs. multiple enemies
    local numCarriers = numActiveOfClass(s_enemyIndex, eBuilder)
    if (s_selfTotalValue > 75) and (numCarriers > 2) then
        ShipDemandAddByClass(eBuilder, 8.5)
    end
    -- Suppress platforms when military is strong (KUS doesn't use platforms natively)
    if (s_militaryStrength > 25*sg_moreEnemies) then
        ShipDemandAddByClass(ePlatform, -2)
    end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Kushan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Kushan
```

### `ai_build.lua` — TAI

Identical structure to KUS but using `TAI_*` constants. Same demand biases (swarm doctrine is shared between the two HW1 factions).

### `ai_subsystems.lua` — KUS and TAI

Simple file: KUS/TAI ships have minimal modular subsystems (no research upgrades needed in Phase 1). Can be near-empty (just the required function stubs) until upgrade research is implemented.

### `ai_upgrades.lua`, `def_build.lua`, `def_research.lua` — KUS and TAI

Copy the HGN equivalents and replace constants. These govern tech research priorities and defensive placements. Phase 1 can use near-copies of HGN behavior; fine-tuning comes in Phase 3.

---

## File Creation Order

Dependencies flow from weapons → subsystems → ships → AI scripts. Create in this order:

1. **Weapons** (no dependencies): all `src/weapon/kus_*/` and `src/weapon/tai_*/` files
2. **Subsystems** (depend on weapons): all `src/subsystem/kus_*/` and `src/subsystem/tai_*/` files
3. **Fighter and corvette ship files** (depend on weapons; no subsystems): `kus_interceptor`, `kus_attackbomber`, `kus_cloakedfighter`, `kus_defender`, `kus_lightcorvette`, `kus_heavycorvette`, `kus_multiguncorvette`, `kus_salvagecorvette`, `kus_minelayercorvette`, `kus_repaircorvette` (and TAI mirrors)
4. **Frigate ship files** (depend on weapon + subsystem files): `kus_assaultfrigate`, `kus_ioncannonfrigate`, `kus_dronefrigate`, `kus_supportfrigate`, `tai_assaultfrigate`, `tai_ioncannonfrigate`, `tai_fieldfrigate`, `tai_supportfrigate`
5. **Capital ship files** (depend on weapon + subsystem files): `kus_destroyer`, `kus_missiledestroyer`, `kus_heavycruiser`, `tai_destroyer`, `tai_missiledestroyer`, `tai_heavycruiser`
6. **Builder ship files**: `kus_carrier`, `kus_mothership`, `tai_carrier`, `tai_mothership`
7. **Utility ship files**: `kus_resourcecontroller`, `tai_resourcecontroller`
8. **AI scripts** (depend on ship names being correct): all `src/scripts/races/kushan/scripts/` and `src/scripts/races/taiidan/scripts/` files

---

## Complete File List

### New weapon files (30 files)
```
src/weapon/kus_massdrivers/kus_massdrivers.wepn
src/weapon/tai_massdrivers/tai_massdrivers.wepn
src/weapon/kus_plasmabomb/kus_plasmabomb.wepn
src/weapon/tai_plasmabomb/tai_plasmabomb.wepn
src/weapon/tai_emppulse/tai_emppulse.wepn
src/weapon/kus_lightcorvettegun/kus_lightcorvettegun.wepn
src/weapon/tai_lightcorvettegun/tai_lightcorvettegun.wepn
src/weapon/kus_heavycorvettegun/kus_heavycorvettegun.wepn
src/weapon/tai_heavycorvettegun/tai_heavycorvettegun.wepn
src/weapon/kus_multigunsturret/kus_multigunsturret.wepn
src/weapon/tai_multigunsturret/tai_multigunsturret.wepn
src/weapon/kus_salvagebeam/kus_salvagebeam.wepn
src/weapon/tai_salvagebeam/tai_salvagebeam.wepn
src/weapon/kus_repairbeam/kus_repairbeam.wepn
src/weapon/tai_repairbeam/tai_repairbeam.wepn
src/weapon/kus_repairbeam_frigate/kus_repairbeam_frigate.wepn
src/weapon/tai_repairbeam_frigate/tai_repairbeam_frigate.wepn
src/weapon/kus_assaultfrigategun/kus_assaultfrigategun.wepn  (used for all 3 hardpoints)
src/weapon/tai_assaultfrigategun/tai_assaultfrigategun.wepn
src/weapon/kus_ionbeam/kus_ionbeam.wepn
src/weapon/tai_ionbeam/tai_ionbeam.wepn
src/weapon/kus_dronelauncher/kus_dronelauncher.wepn          (risk — see below)
src/weapon/kus_destroyercannon/kus_destroyercannon.wepn
src/weapon/tai_destroyercannon/tai_destroyercannon.wepn
src/weapon/kus_missilelauncher/kus_missilelauncher.wepn
src/weapon/tai_missilelauncher/tai_missilelauncher.wepn
src/weapon/kus_heavycruisercannon/kus_heavycruisercannon.wepn
src/weapon/tai_heavycruisercannon/tai_heavycruisercannon.wepn
src/weapon/kus_heavycruiserionbeam/kus_heavycruiserionbeam.wepn
src/weapon/tai_heavycruiserionbeam/tai_heavycruiserionbeam.wepn
src/weapon/kus_mshulldefensegun/kus_mshulldefensegun.wepn
src/weapon/tai_mshulldefensegun/tai_mshulldefensegun.wepn
```

### New subsystem files (14 files)
```
src/subsystem/kus_assaultfrigategun_front/kus_assaultfrigategun_front.subs
src/subsystem/kus_assaultfrigategun_side/kus_assaultfrigategun_side.subs
src/subsystem/tai_assaultfrigategun_front/tai_assaultfrigategun_front.subs
src/subsystem/tai_assaultfrigategun_side/tai_assaultfrigategun_side.subs
src/subsystem/kus_ionbeam_sub/kus_ionbeam_sub.subs
src/subsystem/tai_ionbeam_sub/tai_ionbeam_sub.subs
src/subsystem/kus_destroyercannon_sub/kus_destroyercannon_sub.subs
src/subsystem/tai_destroyercannon_sub/tai_destroyercannon_sub.subs
src/subsystem/kus_missilelauncher_sub/kus_missilelauncher_sub.subs
src/subsystem/tai_missilelauncher_sub/tai_missilelauncher_sub.subs
src/subsystem/kus_heavycruiser_cannon_sub/kus_heavycruiser_cannon_sub.subs
src/subsystem/kus_heavycruiser_ionside_sub/kus_heavycruiser_ionside_sub.subs
src/subsystem/tai_heavycruiser_cannon_sub/tai_heavycruiser_cannon_sub.subs
src/subsystem/tai_heavycruiser_ionside_sub/tai_heavycruiser_ionside_sub.subs
```

### New ship files (40 files)
```
src/ship/kus_interceptor/kus_interceptor.ship
src/ship/kus_attackbomber/kus_attackbomber.ship
src/ship/kus_cloakedfighter/kus_cloakedfighter.ship
src/ship/kus_defender/kus_defender.ship
src/ship/kus_lightcorvette/kus_lightcorvette.ship
src/ship/kus_heavycorvette/kus_heavycorvette.ship
src/ship/kus_multiguncorvette/kus_multiguncorvette.ship
src/ship/kus_salvagecorvette/kus_salvagecorvette.ship
src/ship/kus_minelayercorvette/kus_minelayercorvette.ship
src/ship/kus_repaircorvette/kus_repaircorvette.ship
src/ship/kus_assaultfrigate/kus_assaultfrigate.ship
src/ship/kus_ioncannonfrigate/kus_ioncannonfrigate.ship
src/ship/kus_dronefrigate/kus_dronefrigate.ship
src/ship/kus_supportfrigate/kus_supportfrigate.ship
src/ship/kus_destroyer/kus_destroyer.ship
src/ship/kus_missiledestroyer/kus_missiledestroyer.ship
src/ship/kus_heavycruiser/kus_heavycruiser.ship
src/ship/kus_carrier/kus_carrier.ship
src/ship/kus_mothership/kus_mothership.ship
src/ship/kus_resourcecontroller/kus_resourcecontroller.ship
src/ship/tai_interceptor/tai_interceptor.ship
src/ship/tai_attackbomber/tai_attackbomber.ship
src/ship/tai_defensefighter/tai_defensefighter.ship
src/ship/tai_defender/tai_defender.ship
src/ship/tai_lightcorvette/tai_lightcorvette.ship
src/ship/tai_heavycorvette/tai_heavycorvette.ship
src/ship/tai_multiguncorvette/tai_multiguncorvette.ship
src/ship/tai_salvagecorvette/tai_salvagecorvette.ship
src/ship/tai_minelayercorvette/tai_minelayercorvette.ship
src/ship/tai_repaircorvette/tai_repaircorvette.ship
src/ship/tai_assaultfrigate/tai_assaultfrigate.ship
src/ship/tai_ioncannonfrigate/tai_ioncannonfrigate.ship
src/ship/tai_fieldfrigate/tai_fieldfrigate.ship
src/ship/tai_supportfrigate/tai_supportfrigate.ship
src/ship/tai_destroyer/tai_destroyer.ship
src/ship/tai_missiledestroyer/tai_missiledestroyer.ship
src/ship/tai_heavycruiser/tai_heavycruiser.ship
src/ship/tai_carrier/tai_carrier.ship
src/ship/tai_mothership/tai_mothership.ship
src/ship/tai_resourcecontroller/tai_resourcecontroller.ship
```

### New AI script files (10 files)
```
src/scripts/races/kushan/scripts/ai_build.lua
src/scripts/races/kushan/scripts/ai_subsystems.lua
src/scripts/races/kushan/scripts/ai_upgrades.lua
src/scripts/races/kushan/scripts/def_build.lua
src/scripts/races/kushan/scripts/def_research.lua
src/scripts/races/taiidan/scripts/ai_build.lua
src/scripts/races/taiidan/scripts/ai_subsystems.lua
src/scripts/races/taiidan/scripts/ai_upgrades.lua
src/scripts/races/taiidan/scripts/def_build.lua
src/scripts/races/taiidan/scripts/def_research.lua
```

**Total new files: ~94**

---

## Risks and Pre-Implementation Tests

### High Risk

**`kus_dronefrigate` drone spawning mechanic**
Spawning live ship units as weapon projectiles is a non-trivial HWR modding technique. Before implementing this ship, verify the engine supports it in a skirmish mod context. If not supported, replace `kus_dronefrigate` with a simpler variant (e.g. a standard multi-weapon frigate or a rocket launcher frigate) to unblock the rest of Phase 1.

**`tai_defensefighter` EMP weapon**
The `WeaponType = "EMP"` entry that disables subsystems needs engine verification. If the EMP weapon type isn't exposed in HWR's modding API, replace with a standard fighter that does reduced damage to subsystems via low penetration values — same role, different mechanic.

### Medium Risk

**`kus_cloakedfighter` CloakAbility**
Cloak is a built-in HWR ability, but verify the `CloakAbility` token is accessible in the mod's `.ship` files (not restricted to campaign units). The `kus_scout` already has a custom speed burst ability, so ability registration works. Low risk but worth a quick test.

**Mothership (`kus_mothership` / `tai_mothership`) model**
The mothership uses HW1 era models from the base game. Confirm the model reference in `LoadModel()` points to an accessible HW1 mothership asset in HWR. The existing `kus_scout` successfully references HW1 art assets, so this should work.

### Low Risk

**Salvage corvette capture mechanics**
The `SalvageAbility` engine built-in should work, as capture mechanics already exist for `HGN_MARINEFRIGATE` and `VGR_INFILTRATORFRIGATE`. The salvage corvette just uses a corvette-class version.

**AI scripts for suppressed units**
Ships in `eUselessShips` (salvage corvette, minelayer, support frigate) don't need AI demand logic — they're available to players but the AI ignores them. The AI scripts don't need to reference these ships at all beyond the constants that classdef already handles.

# Requiem for Freedom — Enhancement Roadmap

## Vision

**Requiem for Freedom** began as a vanilla Homeworld skirmish mod. This roadmap charts its evolution into a proper entry in the **Slipstream** fanfiction universe, inheriting the spirit of _The Price of Freedom_ (TPOF) while leveraging everything Homeworld Remastered makes possible.

Two goals drive this plan:

1. **Recover TPOF's feel.** Fast, aggressive, decisive combat with distinct faction personalities. No faction should play like a reskinned version of another.
2. **Exploit HWR's full feature set.** The remaster adds a better renderer, richer FX system, classic-mode physics for HW1 factions, and higher-fidelity assets. None of it is currently used to its potential.

---

## State of the Mod

### What's working

- HGN and VGR are complete: full ship rosters, weapons, subsystems, AI scripts, and starting fleets.
- 141 attack styles cover most combat archetypes.
- 5 maps provide solid skirmish coverage (2–6 players).
- Live-edit workflow (no compilation step) makes iteration fast.

### What's missing

| Gap | Impact |
|-----|--------|
| KUS and TAI each have only 1 ship (scout) | Two factions are unplayable in practice |
| No lore or narrative anywhere in the mod | RFF has no identity; it could be any HW skirmish mod |
| HWR visual/FX features largely untouched | Looks and feels like an HW2 mod, not an HWR mod |
| TPOF's faction distinctiveness is diluted | HGN/VGR play too similarly at high level |
| No lore-flavored map names or ship callsigns | Maps are functional labels, not places in a universe |

---

## Phase 0 — Developer Tooling

_Infrastructure improvements that make all other phases easier._

### 0.1 Log and Dump Parser

Homeworld Remastered writes game logs and crash dumps to `<Steam install>\HomeworldRM\Bin\Release\`. The most important file is `Hw2.log`, which records engine output, Lua script errors, and mod loading events.

Currently there is no tooling to read these files — debugging requires manually opening them and scanning for relevant lines. A PowerShell script (`tools/parse-logs.ps1`) would:

- Auto-detect the HW install path from the registry or common Steam locations
- Read and filter `Hw2.log` for errors, warnings, and RFF-specific output
- Summarize crash dumps (`.dmp` files) with timestamp, type, and relevant context
- Accept flags to filter by severity (errors-only, Lua-only, etc.) or tail live output

**Primary value:** Agents can call this script to diagnose issues without needing file-system access to the player's machine during a session. See [docs/plans/parse-logs.md](plans/parse-logs.md) for the full implementation plan.

---

## Phase 1 — Faction Parity (KUS and TAI)

_The largest implementation block. KUS and TAI need full rosters._

### 2.1 Design Principles

TPOF's strength was that each faction felt like a distinct military doctrine, not just a palette swap. Kushan and Taiidan are HW1-era factions — their identity should lean into that contrast with the HW2 factions:

- **HGN / VGR (HW2 style):** Large, complex ships. Modular subsystems. Powerful individual units. Slower to mass, lethal in decisive engagements.
- **KUS / TAI (HW1 style):** Swarm-oriented. Cheaper, faster-building ships. Individual units are weaker but numbers compensate. Fighter and corvette emphasis. Classic HW1 formations and attack patterns.

This asymmetry is already hinted at in the existing attack scripts (`hw1fighter_vs_fighter`, `hw1fighter_vs_hw2fighter`). Build on it.

### 2.2 Kushan (KUS) Ship Roster

Target: a roster of ~12–14 ships that covers all class tiers. Suggested units based on Kushan's HW1 identity:

| Ship | Role | Class | Notes |
|------|------|-------|-------|
| `kus_scout` | Recon | Fighter | Already exists |
| `kus_interceptor` | Anti-fighter | Fighter | Standard dogfighter |
| `kus_heavyfighter` | Anti-corvette | Fighter | HW1-style heavy fighter; flanks corvettes |
| `kus_attackbomber` | Anti-capital strike | Fighter | Direct TPOF parallel to HGN bomber |
| `kus_defenseshipfighter` | Anti-missile / point defense | Fighter | Kushan unique: shoots down projectiles |
| `kus_lightcorvette` | Fast harassment | Corvette | HW1 light corvette analog |
| `kus_heavycorvette` | Anti-fighter brawler | Corvette | Replaces assault corvette role |
| `kus_multiguncorvette` | Anti-strike-craft | Corvette | Gatling platform vs. swarms |
| `kus_salvagebotcorvette` | Capture | Corvette | HW1 salvager; captures enemy ships |
| `kus_supportfrigate` | Repair/logistics | Frigate | Heals nearby fleet units |
| `kus_ionfrigate` | Anti-capital | Frigate | Classic Kushan ion cannon frigate |
| `kus_dreadnought` or `kus_heavycruiser` | Capital | Capital | HW1-era capital; less modular than HGN BC |
| `kus_carrier` | Builder/mothership | Mothership | Production hub |
| `kus_minecorvette` | Area denial | Corvette | Lays proximity mines; unique utility |

**Weapons needed:**
- `kus_massdrivers` — standard fighter gun
- `kus_heavyfightercannon` — heavy fighter primary
- `kus_ionbeam` — frigate ion cannon (HW1 style: narrower, shorter range than HGN)
- `kus_salvagebeam` — capture weapon
- `kus_minelaunch` — mine deployment

**Attack styles needed:** Most exist already (`hw1fighter_vs_fighter`, `flyby_heavyfighter_vs_frigate`, `frontal_lightcorvette`, `frontal_heavycorvette*`, `flyround_minelayercorvette_vs_*`) — audit which are implemented and which are stubs.

**AI scripts:** Create `src/scripts/races/kushan/scripts/ai_build.lua` with KUS constants and demand functions following the HGN pattern but biasing toward fighter/corvette swarms.

### 2.3 Taiidan (TAI) Ship Roster

Taiidan mirrors Kushan in class but with a different doctrinal flavor. In HW1 canon, Taiidan leaned toward heavier static defenses and defensive fighters. Suggested roster:

| Ship | Role | Class | Notes |
|------|------|-------|-------|
| `tai_scout` | Recon | Fighter | Already exists |
| `tai_interceptor` | Anti-fighter | Fighter | Standard |
| `tai_heavyfighter` | Anti-corvette | Fighter | Taiidan variant with heavier armor |
| `tai_attackbomber` | Anti-capital | Fighter | |
| `tai_defensefighter` | EMP / disable | Fighter | Taiidan unique: EMP disables enemy ship systems |
| `tai_lightcorvette` | Fast harassment | Corvette | |
| `tai_heavycorvette` | Brawler | Corvette | |
| `tai_repaircorvette` | Repair | Corvette | Forward repair unit |
| `tai_ionfrigate` | Anti-capital | Frigate | Taiidan ion; wider arc than Kushan |
| `tai_ionarrayfrigate` | Broadside anti-capital | Frigate | Multiple ion emitters; TPOF signature unit |
| `tai_destroyercruiser` | Capital brawler | Capital | Taiidan capital; heavy armor, slow |
| `tai_carrier` | Builder | Mothership | |
| `tai_gunplatform` | Static defense | Platform | HW1-style defensive gun |
| `tai_ionplatform` | Static anti-capital | Platform | Taiidan unique platform |

**Weapons needed:**
- `tai_massdrivers` — fighter gun (heavier than KUS)
- `tai_emppulse` — defense fighter EMP disable weapon
- `tai_ionbeam` — standard ion cannon
- `tai_ionarray` — ion array frigate: multiple hits per volley, lower individual damage

**Unique mechanic — Ion Array Frigate:** This is the TPOF-era signature. The `tai_ionarrayfrigate` fires a spray of ion pulses simultaneously across a wide arc. Use separate weapon definitions per emitter in the `.subs` file, positioned via hardpoints, and a broadside attack style (`broadsidevssubsystem` variant or new `broadside_ionarray`).

### 2.4 KUS / TAI Starting Fleets

Update `src/scripts/startingfleets/` for both factions. The standard fleet should include:

- 1 carrier (builder/flagship)
- 6 resource collectors
- 2–3 fighters of each type available at game start
- 2 corvettes
- 2 defensive platforms (TAI); 2 minecorvettes queued (KUS)

Carrier-only variants: carrier + 8 collectors only (competitive mode for experienced players who want to build from scratch).

### 2.5 AI Script Completeness

Both factions need complete `ai_build.lua`, `ai_subsystems.lua`, `ai_upgrades.lua`, `def_build.lua`, and `def_research.lua`. Use the HGN scripts as the template; the main difference is demand biases (KUS/TAI demand more fighters earlier, delay capital ships longer).

---

## Phase 3 — TPOF Feel Recovery

_Balance and combat tuning. Requires in-game testing._

### 3.1 Combat Speed

TPOF's hallmark was that fights resolved fast. Ships didn't cruise across a map — they slammed into each other. Changes to evaluate:

- **Fighter acceleration:** `thrusterMaxSpeed` and related fields. RFF already increases these vs. vanilla; audit whether they match TPOF's tempo.
- **Engagement ranges:** `setFireRange` in `.wepn` files. Closer engagement = faster, more decisive fights. Consider tightening ranges for fighters and corvettes.
- **Frigate aggressiveness:** `movetotargetandshoot_*` attack scripts. Frigates should close rather than hang at max range. Review `attackDistance` parameters.

### 3.2 Faction Distinctiveness

Current state: HGN and VGR both hit hard at range. Both win through individual unit quality. That's not TPOF — TPOF had factions that forced different strategies.

| Faction | Target Feel | Lever |
|---------|-------------|-------|
| HGN | Fortress doctrine. Wins by controlling space with defense fields and torpedo artillery. Needs time to set up; devastating when established. | Buff `hgn_defensefieldfrigate` field radius. Increase `hgn_torpedofrigate` range. Increase HGN platform durability. |
| VGR | Shock doctrine. Strikes before the enemy can react. Lance fighters shred corvettes. Infiltrator frigates neutralize capitals. | Buff `vgr_lancefighter` attack speed. Give `vgr_infiltratorfrigate` faster EMP cycle. Decrease VGR carrier build time (rapid production). |
| KUS | Swarm doctrine. Individual units die; the mass doesn't. 3 interceptors cost less than 1 HGN interceptor; build 3. | Lower `buildCost` and `buildTime` for KUS fighters/corvettes vs. HGN equivalents. Buff multigun corvette vs. swarms. |
| TAI | Attrition doctrine. Slow, armored, digs in. Repair corvettes keep the line. Ion array frigates punish anything that stands still. | Increase `maxhealth` on TAI frigates/capitals. Give `tai_repaircorvette` a faster repair rate. |

### 3.3 The HW1/HW2 Divide

TPOF's tension came from HW1 swarms vs. HW2 individual powerhouses. Preserve and amplify this:

- HW1 fighters (KUS/TAI) should be cheaper but individually weaker than HW2 fighters (HGN/VGR)
- KUS/TAI corvettes should outnumber HGN/VGR corvettes at equal RU spend
- HW2 capitals (HGN/VGR BCs) should be clearly stronger 1-on-1 than TAI's `destroyercruiser`
- The balancing question: does TAI's mass plus repair compensation for that power gap? Testing will answer this.

### 3.4 Starting Fleet Review

Starting fleets set the tone for the first 3 minutes, which determines whether RFF "feels" like TPOF. Review:

- Are starting fleet sizes appropriate for the intended tempo? TPOF opened with fleets large enough for an immediate skirmish.
- Does each faction's start reflect their doctrine? HGN should start with platforms. TAI should start with defensive coverage. KUS should have more fighters than anyone else.
- Carrier-only variants: ensure all 4 factions have a carrier-only start for competitive play.

---

## Phase 4 — HWR Feature Integration

_Leverage what HWR added over vanilla HW2._

### 4.1 Classic Physics Mode for HW1 Factions

Homeworld Remastered includes a "classic" gameplay mode that restores HW1 formation physics and movement. KUS and TAI can use HW1-style squadron movement where the whole formation moves as a unit, rather than HW2's individual-ship movement.

This is the single biggest differentiator available. HW1 swarm formations in HW1 physics vs. HW2 individual maneuvering creates fundamentally different combat dynamics. Investigate whether `src/scripts/attack/hw1fighter_vs_fighter.lua` and related scripts already leverage this, and extend to all KUS/TAI ships.

### 4.2 Visual FX

HWR's renderer supports more sophisticated particle effects and lighting. Current FX scripts in `src/art/fx/` are minimal. Opportunities:

- **Defense field** (`hgn_defensefieldfrigate`): add a visible energy sphere around protected ships
- **Ion cannons**: beam width and bloom improvement
- **Nuclear torpedo** (`hgn_torpedofrigate`): distinct launch FX and impact bloom
- **Lance fighter** (`vgr_lancefighter`): plasma trail on lance shots
- **TAI ion array**: each emitter should have its own beam FX

### 4.3 Map Environment Enhancement

HWR supports richer map environments than vanilla HW2. Current maps are asteroid fields with no environmental hazards. Enhancements to explore:

- **Dust clouds**: visibility-reducing zones that favor ambush tactics (KUS/TAI swarms benefit more than HGN/VGR precision units)
- **Nebulae**: sensor-range penalties in specific zones
- **Debris fields**: static obstacles that channel movement through corridors
- **Resource variety**: large asteroids (high RU, contested) vs. scattered small fields (lower RU, distributed)

### 4.4 Badge and UI

`src/badges/` has player emblem images. Each faction should have a distinct badge. Low priority but contributes to polish.

---

## Phase 5 — Map Expansion

_Target: 8–10 maps._

Current coverage: 2p, 3p, 4p, 5p, 6p (one each). Target additions:

| Priority | Players | Design Theme |
|----------|---------|--------------|
| High | 2p | Second 2-player map with asymmetric resource layout (tests eco vs. military builds) |
| High | 4p | 2v2 team map with a shared frontline — RFF has no team maps |
| Medium | 6p | 3v3 team variant |
| Low | 1p | Skirmish-only solo vs. AI (tests AI balance) |

Map design checklist for all new maps:
- Symmetric or rotationally symmetric starting positions
- At least one contested central resource cluster
- Total RU balanced for target fleet size at the intended game length
- Engagement range scaled to the player count (2p maps are tighter; 6p maps are wider)

---

## Phase 6 — Polish and Release

### 6.1 Balance Pass

After Phase 2 and 3 are playable, run systematic balance games:

- HGN vs. VGR (existing matchup — should already be close; re-verify after TPOF feel changes)
- KUS vs. TAI (new mirror matchup)
- HGN vs. KUS (HW2 quality vs. HW1 swarm)
- VGR vs. TAI (aggressive vs. attrition)
- 4-faction free-for-all

Use `tools/ship-stats.ps1` to diff cost/health/DPS ratios across all factions before each test session.

### 6.2 Attack Style Audit

The 141 attack scripts include stubs and legacy entries. Before release:

- Verify every ship's `addAbility(NewShipType, "CanAttack", ...)` call references an existing, non-stub script
- Ensure KUS/TAI new ships have appropriate styles (most can reuse existing HW1 variants)
- Document any new styles added in `src/scripts/attack/README.md`

### 6.3 Workshop Update

Update Steam Workshop:
- Updated preview image (if artwork changes)
- Changelog noting the scope of changes

---

## Implementation Order

| Phase | Dependency | Estimated Scope |
|-------|------------|-----------------|
| 1.2 — KUS roster | None — start here | Large |
| 1.3 — TAI roster | None — start here | Large |
| 1.4/1.5 — Fleets + AI | Phase 1.2/1.3 | Medium |
| 2 — TPOF feel | KUS/TAI playable | Medium (iterative) |
| 3.1 — HW1 physics | Phase 1 complete | Medium |
| 3.2/3.3 — FX + maps | Any order after Phase 1 | Medium |
| 4 — Map expansion | Any | Medium |
| 5 — Polish + release | All prior | Small (iterative) |

---

## Open Questions

These require design decisions before implementation can begin:

1. **TPOF reference material** — Are there specific ships, balance numbers, or faction traits from TPOF that should be directly ported? Access to TPOF source or documentation would sharpen the Phase 2 targets significantly.
2. **HW1 physics scope** — Classic mode in HWR may have limitations for modded factions. Needs a test to confirm KUS/TAI can use HW1 formation movement in a modded context before committing to it.
3. **KUS/TAI unique abilities** — The `tai_ionarrayfrigate` and `kus_defenseshipfighter` are novel mechanics that need HWR engine support verification. These are high-value units but may require engine experimentation before committing to them.

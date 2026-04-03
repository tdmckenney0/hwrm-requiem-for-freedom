# CLAUDE.md — refs/

## Purpose

Read-only reference material. Do not modify anything in this directory.

## Contents

| Directory | Source | Use |
|-----------|--------|-----|
| `slipstream-the-price-of-freedom/` | Predecessor mod (HW2 Classic) | Precedents for ship stats, attack scripts, game rules, and design philosophy |
| `homeworldrm-big/` | Decompiled `Homeworld2.big` (HWR) | Engine scripts, AI logic, game rules templates, attack styles, formation/flight scripts |
| `hw1ships-big/` | Decompiled `hw1ships.big` (HWR) | Vanilla KUS/TAI ship definitions and weapon references |
| `hw2ships-big/` | Decompiled `hw2ships.big` (HWR) | Vanilla HGN/VGR ship definitions and weapon references — primary balance baseline |
| `english-big/` | Decompiled `english.big` (HWR) | Localization strings (ship names, UI text) |
| `hwbackgrounds-big/` | Decompiled `hwbackgrounds.big` (HWR) | Background/skybox definitions |

## Common Uses

- **Vanilla ship stats**: `hw2ships-big/ship/<name>/` — compare RFF values against originals
- **Vanilla weapon stats**: `hw2ships-big/ship/<name>/` and weapon scripts inside
- **Engine API examples**: `homeworldrm-big/scripts/` — `armourandshields.lua`, `commandlayer.lua`, `races/`
- **Attack script patterns**: `homeworldrm-big/scripts/attack/`
- **Slipstream precedents**: `slipstream-the-price-of-freedom/src/` — RFF's direct design ancestor; see also `docs/slipstream.md` for a full summary of its ship stats, AI behavior, and design philosophy

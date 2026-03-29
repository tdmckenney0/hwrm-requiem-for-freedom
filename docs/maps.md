# Multiplayer Maps

Maps are located in `src/leveldata/multiplayer/requiem_for_freedom/`. Each map is a `.level` file containing a Lua-based map definition. All maps are designed for RFF's arena-style multiplayer.

## Map Roster

| File | Players | Name |
|------|---------|------|
| `2p_Orions_Bridge.level` | 2 | Orion's Bridge |
| `3p_Suckerpunch.level` | 3 | Suckerpunch |
| `4p_Gumball.level` | 4 | Gumball |
| `5p_Orbit.level` | 5 | Orbit |
| `6p_Middle_Ground.level` | 6 | Middle Ground |

## Level File Structure

Each `.level` file is a Lua script loaded by the HW2 engine. It defines:

- **Player starting positions** — 3D coordinates and headings for each player's carrier
- **Resource fields** — asteroid clusters and their RU density
- **Environmental hazards** — dust clouds, nebulae (affect sensor/damage)
- **Map boundaries** — the playable volume
- **Sensor distortion zones** — areas with reduced or enhanced detection

```lua
-- Example structure
LevelFile_Header()

-- Map dimensions
SetPlayVolume(...)

-- Player starting positions
AddStartPosition(player_index, x, y, z, heading)

-- Asteroid fields
AddAsteroid(x, y, z, size, RU_value, ...)

-- Environmental features
AddDustCloud(x, y, z, radius, ...)
```

## Design Philosophy

All RFF maps are designed for balanced, arena-style play:

- **Symmetric starts**: players begin equidistant from the center and from each other
- **Contested resources**: primary asteroid fields are placed in contested middle ground, forcing early engagement
- **Open combat zones**: minimal terrain obstruction keeps battles fluid and maneuverable
- **Appropriate scale**: map size scales with player count to keep engagement distances consistent

## Adding a New Map

1. Create `src/leveldata/multiplayer/requiem_for_freedom/<Np_MapName>.level`
2. Follow the naming convention `<player_count>p_<MapName>.level`
3. Use balanced symmetric starting positions
4. Test with `tools/launch-rff.ps1` (the symlink picks up new files automatically)

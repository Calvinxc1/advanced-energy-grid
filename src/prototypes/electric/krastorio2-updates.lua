-- Krastorio 2 integration, data-updates stage.
--
-- K2 raises the vanilla poles' reach and coverage in its own data-updates
-- (small 7.75, medium 9.75 and 4.5, big 32.25, substation 20.25 and 10). This
-- mod's tiers are built on the vanilla numbers, so under K2 the medium mk2
-- would add no coverage and the substation mk2 would reach less far than the
-- substation it upgrades. The mod's numbers carry instead: the vanilla poles
-- are set back to the first rung of each ladder. K2's recipes and unlocks for
-- them are kept.

local FIRST_RUNG = {
  ["small-electric-pole"] = { wire = 7.5, supply = 2.5 },
  ["medium-electric-pole"] = { wire = 11, supply = 3.5 },
  ["big-electric-pole"] = { wire = 32, supply = 2 },
  ["substation"] = { wire = 18, supply = 9 },
}

for pole_name, stats in pairs(FIRST_RUNG) do
  local pole = data.raw["electric-pole"][pole_name]
  if pole then
    pole.maximum_wire_distance = stats.wire
    pole.supply_area_distance = stats.supply
  end
end

-- K2's tech cards pass along this mod's chains: each of its technologies takes
-- the cards its prerequisites carry, repeated until nothing changes. Krastorio
-- 2 Spaced Out adds cards to Space Age technologies in its data-updates, so a
-- tier that follows one would otherwise research for less than the technology
-- it builds on. The basic card is left alone: Spaced Out removes it, and K2
-- places it itself.
local function is_carried_card(pack)
  return pack ~= "kr-basic-tech-card" and string.match(pack, "^kr%-.+%-tech%-card$") ~= nil
end

local function cards(technology)
  local found = {}
  for _, ingredient in pairs(technology.unit and technology.unit.ingredients or {}) do
    local pack = ingredient.name or ingredient[1]
    if is_carried_card(pack) then
      found[pack] = true
    end
  end
  return found
end

local changed = true
while changed do
  changed = false
  for technology_name, technology in pairs(data.raw.technology) do
    if string.sub(technology_name, 1, 4) == "aeg_" and technology.unit then
      local have = cards(technology)
      for _, prerequisite_name in pairs(technology.prerequisites or {}) do
        local prerequisite = data.raw.technology[prerequisite_name]
        for card in pairs(prerequisite and cards(prerequisite) or {}) do
          if not have[card] then
            have[card] = true
            table.insert(technology.unit.ingredients, { card, 1 })
            changed = true
          end
        end
      end
    end
  end
end

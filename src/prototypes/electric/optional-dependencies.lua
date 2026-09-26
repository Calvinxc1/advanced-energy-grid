-- Resolves everything that differs between loads: Space Age or the base game,
-- and the overhauls this mod adapts to (Krastorio 2, Space Exploration). The
-- presence flags are computed once here, and prototype files consume the
-- resolvers below rather than branching on `mods` themselves, so this file is
-- the single auditable answer to "what changes with which mods?".
--
-- Whole tiers are not handled here. The late tiers (big pole and substation
-- mk4, huge pole mk3 and mk4) exist whenever Space Age or an overhaul supplies
-- the materials for them; their entities and items live in
-- prototypes/electric/late-tiers/, and their recipes and technologies in one
-- directory per material source (space-age/, krastorio2/, space-exploration/).
--
-- This file is also required from settings.lua, where `data` does not exist,
-- so nothing here may touch data.raw.

local optional_dependencies = {}

optional_dependencies.has_space_age = mods["space-age"] ~= nil
optional_dependencies.has_power_overload = mods["PowerOverload"] ~= nil
-- Krastorio 2 Spaced Out requires Krastorio2 itself on Factorio 2.1, so one
-- check covers both.
optional_dependencies.has_krastorio2 = mods["Krastorio2"] ~= nil
optional_dependencies.has_space_exploration = mods["space-exploration"] ~= nil

-- Whether the late tiers exist, and whose materials build them. Space Age
-- wins where it is present (Krastorio 2 with Space Age, and Spaced Out), since
-- its recipes are the mod's own; Krastorio 2 comes next, so Space Exploration
-- with Krastorio 2 uses K2's materials, which SE re-tiers into its own
-- progression; Space Exploration alone uses SE's.
optional_dependencies.has_late_tiers = optional_dependencies.has_space_age
  or optional_dependencies.has_krastorio2
  or optional_dependencies.has_space_exploration

if optional_dependencies.has_space_age then
  optional_dependencies.late_tier_source = "space-age"
elseif optional_dependencies.has_krastorio2 then
  optional_dependencies.late_tier_source = "krastorio2"
elseif optional_dependencies.has_space_exploration then
  optional_dependencies.late_tier_source = "space-exploration"
end

-- Tiers an overhaul already supplies. Krastorio 2's superior substation has the
-- substation mk4's reach and coverage, so under K2 it is that tier: the ladder
-- runs substation, mk2, mk3, superior substation, and K2's own technology
-- unlocks it. Everything that names a tier goes through name().
local KRASTORIO2_TIERS = {
  ["aeg_substation-4"] = "kr-superior-substation",
  ["aeg_improved-local-energy-distribution-elite"] = "electric-energy-distribution-3",
}

function optional_dependencies.name(prototype_name)
  if optional_dependencies.has_krastorio2 then
    return KRASTORIO2_TIERS[prototype_name] or prototype_name
  end
  return prototype_name
end

-- Picks between a Space Age value and a base-game value. Used for technology
-- prerequisite lists and research units, which differ in gating rather than in
-- shape.
function optional_dependencies.select(space_age, fallback)
  if optional_dependencies.has_space_age then
    return space_age
  end

  return fallback
end

-- The science pack, and the technology that unlocks it, that gates the elite
-- tiers (medium pole mk4, substation mk3, huge pole mk2, and the late tiers
-- above them):
--
--   Space Age            electromagnetic science (Fulgora)
--   Space Exploration    energy science 1, SE's own electrical line, where its
--                        pylons and holmium cable sit
--   Krastorio 2          the matter tech card, where K2 puts imersium and the
--                        superior substation's materials
--   base game            space science, the base game's capstone
local ELITE_PACKS = {
  { "automation-science-pack", 1 },
  { "logistic-science-pack", 1 },
  { "chemical-science-pack", 1 },
  { "production-science-pack", 1 },
  { "utility-science-pack", 1 },
}

local function elite_gate()
  if optional_dependencies.has_space_age then
    return { "space-science-pack", "electromagnetic-science-pack" }
  elseif optional_dependencies.has_space_exploration then
    return { "space-science-pack", "se-rocket-science-pack", "se-energy-science-pack-1" }
  elseif optional_dependencies.has_krastorio2 then
    return { "kr-matter-tech-card" }
  end
  return { "space-science-pack" }
end

-- The research unit shared by every elite tier.
function optional_dependencies.electromagnetic_unit_ingredients()
  local ingredients = util.table.deepcopy(ELITE_PACKS)
  for _, pack in pairs(elite_gate()) do
    table.insert(ingredients, { pack, 1 })
  end
  return ingredients
end

-- The technology that gates an elite tier: the one that unlocks the last
-- pack in the elite research unit.
function optional_dependencies.electromagnetic_prerequisite()
  local gate = elite_gate()
  return gate[#gate]
end

return optional_dependencies

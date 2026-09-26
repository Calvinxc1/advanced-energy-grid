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

-- Tiers an overhaul already supplies. Everything that names a tier goes
-- through name().
--
--   * Krastorio 2's superior substation has the substation mk4's reach and
--     coverage, so under K2 it is that tier: the ladder runs substation, mk2,
--     mk3, superior substation, and K2's own technology unlocks it.
--   * Space Exploration's pylon has the huge pole mk4's reach, arrives just
--     after the mk3, and Power Overload gives it more capacity, so under SE it
--     is that tier and SE's own technology unlocks it. Only the huge-pole
--     ladder (which needs Power Overload) refers to it.
local KRASTORIO2_TIERS = {
  ["aeg_substation-4"] = "kr-superior-substation",
  ["aeg_improved-local-energy-distribution-elite"] = "electric-energy-distribution-3",
}

local SPACE_EXPLORATION_TIERS = {
  ["aeg_huge-electric-pole-4"] = "se-pylon",
  ["aeg_improved-distance-power-transmission-elite"] = "se-pylon",
}

function optional_dependencies.name(prototype_name)
  if optional_dependencies.has_krastorio2 and KRASTORIO2_TIERS[prototype_name] then
    return KRASTORIO2_TIERS[prototype_name]
  end
  if optional_dependencies.has_space_exploration and SPACE_EXPLORATION_TIERS[prototype_name] then
    return SPACE_EXPLORATION_TIERS[prototype_name]
  end
  return prototype_name
end

-- Whether this mod builds a tier itself, or an overhaul supplies it.
function optional_dependencies.builds(prototype_name)
  return optional_dependencies.name(prototype_name) == prototype_name
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

-- The research gates above utility science. Two stages:
--
--   elite  medium pole mk4, substation mk3, huge pole mk2
--   late   big pole mk4, huge pole mk3 (and, with a further pack, the mk4
--          substation and huge pole)
--
--                        elite                          late
--   Space Age            electromagnetic science        (same)
--   Space Exploration    holmium processing: space      energy science 1, SE's
--                        science and SE's first          own electrical line
--                        off-world electrical metal
--   SE with Krastorio 2  space science, the step after  energy science 1
--                        mk3, with K2's elite materials
--   Krastorio 2          lithium-sulfur battery and     matter tech card, where
--                        rare metals, K2's late          K2 puts imersium and
--                        pre-rocket content              the energy control unit
--   base game            space science                  (same)
--
-- Krastorio 2 separates them: its matter card comes after the singularity
-- lab, so gating the elite tier there would leave the whole rocket-to-matter
-- stretch without a pole upgrade. Under Space Exploration one gate would put
-- five or six tiers (and the pylon right after) on energy science 1 at once,
-- so the elite tier comes a step earlier there. Each gate is a set of technologies to follow
-- and a set of packs to add to the research unit.
local BASE_PACKS = {
  { "automation-science-pack", 1 },
  { "logistic-science-pack", 1 },
  { "chemical-science-pack", 1 },
  { "production-science-pack", 1 },
  { "utility-science-pack", 1 },
}

local function gate(stage)
  if optional_dependencies.has_space_age then
    return { technologies = { "electromagnetic-science-pack" },
             packs = { "space-science-pack", "electromagnetic-science-pack" } }
  elseif optional_dependencies.has_space_exploration then
    if stage == "elite" then
      local technology = optional_dependencies.has_krastorio2 and "space-science-pack" or "se-processing-holmium"
      return { technologies = { technology },
               packs = { "space-science-pack", "se-rocket-science-pack" } }
    end
    return { technologies = { "se-energy-science-pack-1" },
             packs = { "space-science-pack", "se-rocket-science-pack", "se-energy-science-pack-1" } }
  elseif optional_dependencies.has_krastorio2 then
    if stage == "elite" then
      return { technologies = { "kr-lithium-sulfur-battery", "kr-rare-metal-processing" }, packs = {} }
    end
    return { technologies = { "kr-matter-tech-card" }, packs = { "kr-matter-tech-card" } }
  end
  return { technologies = { "space-science-pack" }, packs = { "space-science-pack" } }
end

-- The research unit for a stage ("elite" or "late").
function optional_dependencies.unit_ingredients(stage)
  local ingredients = util.table.deepcopy(BASE_PACKS)
  for _, pack in pairs(gate(stage).packs) do
    table.insert(ingredients, { pack, 1 })
  end
  return ingredients
end

-- A technology's prerequisites: its own, followed by the stage's gate.
function optional_dependencies.prerequisites(stage, own)
  local prerequisites = util.table.deepcopy(own)
  for _, technology in pairs(gate(stage).technologies) do
    table.insert(prerequisites, technology)
  end
  return prerequisites
end

-- The pack that marks a technology as at or beyond the late gate, if the gate
-- adds one.
function optional_dependencies.late_gate_pack()
  local packs = gate("late").packs
  return packs[#packs]
end

return optional_dependencies

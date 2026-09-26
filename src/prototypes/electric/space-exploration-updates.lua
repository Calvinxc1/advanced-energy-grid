-- Space Exploration integration, data-updates stage. Loaded only with Power
-- Overload, whose huge pole the huge-pole ladder is built on.
--
-- SE's pylon is this mod's huge pole mk4 (optional_dependencies maps the tier
-- and its technology onto SE's): the same 64 reach as the mk4, more capacity
-- than the mk3 under Power Overload, and it arrives right after the mk3. So it
-- goes on top of the ladder:
--
--   * its recipe takes a huge pole mk3 alongside SE's own ingredients;
--   * SE's pylon technology follows this mod's huge pole mk3 technology, and
--     takes that tier's packs in prototypes/electric/technology-fixes.lua.
--
-- It keeps SE's reach, coverage, look and menu row. SE's blueprint converter
-- swaps ground and space poles within a menu row, so moving it would break
-- that. It is not the mk3's upgrade target: SE gives space-capable poles their
-- own collision mask, and Factorio requires an upgrade target to share its
-- source's.

local optional_dependencies = require("prototypes.electric.optional-dependencies")
local name = optional_dependencies.name

local pylon = name("aeg_huge-electric-pole-4")
local recipe = data.raw.recipe[pylon]
local technology = data.raw.technology[name("aeg_improved-distance-power-transmission-elite")]

if recipe and data.raw.item["aeg_huge-electric-pole-3"] then
  table.insert(recipe.ingredients, { type = "item", name = "aeg_huge-electric-pole-3", amount = 1 })
end

if technology and data.raw.technology["aeg_improved-distance-power-transmission-advanced"] then
  technology.prerequisites = technology.prerequisites or {}
  table.insert(technology.prerequisites, "aeg_improved-distance-power-transmission-advanced")
end

-- Without Krastorio 2 the huge pole mk2, an elite tier, takes holmium plate
-- like the other elite tiers (prototypes/electric/space-exploration.lua).
local huge_pole_mk2 = data.raw.recipe["aeg_huge-electric-pole-2"]
if huge_pole_mk2 and not optional_dependencies.has_krastorio2 then
  table.insert(huge_pole_mk2.ingredients, { type = "item", name = "se-holmium-plate", amount = 10 })
end

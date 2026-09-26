-- Krastorio 2 integration, data stage. Loaded from prototypes/electric.lua only
-- when K2 is present, after every tier exists.
--
-- K2's superior substation is this mod's substation mk4 (optional_dependencies
-- maps the tier and its technology onto K2's). K2 makes it a direct upgrade of
-- the vanilla substation, which would leave the mk2 and mk3 substations outside
-- the chain, so it moves to the top of the ladder instead:
--
--   * its recipe takes a substation mk3 where K2's takes a substation, keeping
--     the rest of K2's recipe;
--   * K2's technology for it follows this mod's substation mk3 technology;
--   * it carries the mk4's reach and coverage (24 and 12, K2's are 24.25 and
--     12), and sits in this mod's local distribution row.
--
-- The vanilla substation's own upgrade target is set back to the mk2 in
-- prototypes/electric/poles/entities.lua, which runs after K2's data stage.
-- K2 changes the vanilla poles' reach and coverage in its data-updates; they
-- are set back in prototypes/electric/krastorio2-updates.lua.

local name = require("prototypes.electric.optional-dependencies").name

local superior = name("aeg_substation-4")
local entity = data.raw["electric-pole"][superior]
local item = data.raw.item[superior]
local recipe = data.raw.recipe[superior]
local technology = data.raw.technology[name("aeg_improved-local-energy-distribution-elite")]

if entity then
  entity.maximum_wire_distance = 24
  entity.supply_area_distance = 12
  entity.fast_replaceable_group = "substation"
  entity.next_upgrade = nil
end

if item then
  item.subgroup = "aeg_local-distribution"
  item.order = "c[substation-4]"
end

if recipe then
  for _, ingredient in pairs(recipe.ingredients or {}) do
    if ingredient.name == "substation" then
      ingredient.name = "aeg_substation-3"
    end
  end
end

if technology then
  technology.prerequisites = technology.prerequisites or {}
  table.insert(technology.prerequisites, "aeg_improved-local-energy-distribution-advanced")
end

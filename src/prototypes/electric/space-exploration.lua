-- Space Exploration integration without Krastorio 2, data stage. (With K2,
-- prototypes/electric/krastorio2.lua supplies the tiers' materials, and SE
-- re-tiers them.)
--
-- The tiers are built from SE's own materials, one new one per rung, so the
-- ladder climbs through SE's progression rather than beside it:
--
--   mk2     concrete, as SE's own big pole and substation use
--   mk3     unchanged: SE makes production and utility science in space, so
--           this is already the step after the rocket
--   elite   holmium plate, SE's electrical metal and its first off-world
--           resource; the tier follows holmium processing (optional_dependencies)
--   late    holmium cable (prototypes/electric/space-exploration/)
--
-- Only the recipes change; each tier's reach and coverage stay the mod's. The
-- huge pole mk2 is an elite tier too, but it only exists with Power Overload,
-- so prototypes/electric/space-exploration-updates.lua sets it.

local function add(recipe_name, item_name, amount)
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    table.insert(recipe.ingredients, { type = "item", name = item_name, amount = amount })
  end
end

add("aeg_medium-electric-pole-2", "concrete", 2)
add("aeg_big-electric-pole-2", "concrete", 4)
add("aeg_substation-2", "concrete", 5)

add("aeg_medium-electric-pole-4", "se-holmium-plate", 2)
add("aeg_substation-3", "se-holmium-plate", 4)

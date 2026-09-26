-- Recipe and technology builders for the late tiers under an overhaul. Space
-- Age's late tiers (prototypes/electric/space-age/) predate these and spell
-- the same shapes out in full; the overhaul sources use these so each of their
-- files is only the part that differs, the materials and the gates.

local builders = {}

local TECHNOLOGY_ICONS = {
  big = "__advanced-energy-grid__/graphics/technology/big-electric-pole.png",
  substation = "__advanced-energy-grid__/graphics/technology/electric-substation.png",
  huge = "__advanced-energy-grid__/graphics/technology/huge-electric-pole.png",
}

local function item(name, amount)
  return { type = "item", name = name, amount = amount }
end
builders.item = item

-- A tier recipe, copied from the vanilla recipe of the same family so it keeps
-- the family's crafting time and category.
function builders.recipe(name, template, order, ingredients)
  local recipe = util.table.deepcopy(data.raw.recipe[template])
  recipe.name = name
  recipe.enabled = false
  recipe.order = order
  recipe.ingredients = ingredients
  recipe.results = { item(name, 1) }
  data:extend({ recipe })
end

-- A tier technology. `unit.ingredients` is this tier's own gate; the packs its
-- prerequisites need are added in data-updates, once the overhaul has settled
-- its costs (prototypes/electric/technology-fixes.lua).
function builders.technology(def)
  data:extend({
    {
      type = "technology",
      name = def.name,
      icon = TECHNOLOGY_ICONS[def.family],
      icon_size = 256,
      effects = { { type = "unlock-recipe", recipe = def.recipe } },
      prerequisites = def.prerequisites,
      unit = { count = def.count, ingredients = def.ingredients, time = def.time },
      order = def.order,
    },
  })
end

return builders

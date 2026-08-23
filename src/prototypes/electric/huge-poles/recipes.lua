data.raw.recipe["po-huge-electric-pole"].subgroup = "aeg_poles"
data.raw.recipe["po-huge-electric-pole"].order = "a[energy]-e[huge-electric-pole-1]"

local huge_electric_pole_mk2_recipe = util.table.deepcopy(data.raw.recipe["po-huge-electric-pole"])
huge_electric_pole_mk2_recipe.name = "aeg_huge-electric-pole-2"
huge_electric_pole_mk2_recipe.enabled = false
huge_electric_pole_mk2_recipe.order = "a[energy]-e[huge-electric-pole-2]"
huge_electric_pole_mk2_recipe.ingredients = {
  { type = "item", name = "po-huge-electric-pole", amount = 1 },
  { type = "item", name = "copper-plate", amount = 15 },
  { type = "item", name = "steel-plate", amount = 15 },
  { type = "item", name = "iron-stick", amount = 20 },
  { type = "item", name = "advanced-circuit", amount = 10 },
}
huge_electric_pole_mk2_recipe.results = {
  { type = "item", name = "aeg_huge-electric-pole-2", amount = 1 }
}

data:extend{huge_electric_pole_mk2_recipe}

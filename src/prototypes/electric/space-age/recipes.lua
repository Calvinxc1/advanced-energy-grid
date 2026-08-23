local big_electric_pole_mk4 = util.table.deepcopy(data.raw.recipe["big-electric-pole"])
big_electric_pole_mk4.name = "aeg_big-electric-pole-4"
big_electric_pole_mk4.enabled = false
big_electric_pole_mk4.order = "a[energy]-c[big-electric-pole-4]"
big_electric_pole_mk4.ingredients = {
  { type = "item", name = "aeg_big-electric-pole-3", amount = 1 },
  { type = "item", name = "steel-plate", amount = 3 },
  { type = "item", name = "copper-plate", amount = 3 },
  { type = "item", name = "processing-unit", amount = 2 },
  { type = "item", name = "superconductor", amount = 2 },
}
big_electric_pole_mk4.results = {
  { type = "item", name = "aeg_big-electric-pole-4", amount = 1 }
}
data:extend({big_electric_pole_mk4})

local substation_mk4 = util.table.deepcopy(data.raw.recipe["substation"])
substation_mk4.name = "aeg_substation-4"
substation_mk4.enabled = false
substation_mk4.order = "a[energy]-d[substation-4]"
substation_mk4.ingredients = {
  { type = "item", name = "aeg_substation-3", amount = 1 },
  { type = "item", name = "advanced-circuit", amount = 2 },
  { type = "item", name = "processing-unit", amount = 5 },
  { type = "item", name = "superconductor", amount = 10 },
  { type = "item", name = "quantum-processor", amount = 2 },
  { type = "item", name = "steel-plate", amount = 10 },
  { type = "item", name = "copper-plate", amount = 5 },
}
substation_mk4.results = {
  { type = "item", name = "aeg_substation-4", amount = 1 }
}
data:extend({substation_mk4})

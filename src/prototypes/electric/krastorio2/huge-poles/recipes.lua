-- Huge pole mk3 and mk4 under Krastorio 2; the material mapping is described
-- in prototypes/electric/krastorio2/recipes.lua. With Space Exploration too,
-- the mk4 is SE's pylon and the builders skip it.

local builders = require("prototypes.electric.late-tiers.builders")
local item = builders.item

builders.recipe("aeg_huge-electric-pole-3", "po-huge-electric-pole", "b[huge-electric-pole-3]", {
  item("aeg_huge-electric-pole-2", 1),
  item("copper-plate", 15),
  item("steel-plate", 15),
  item("iron-stick", 20),
  item("advanced-circuit", 10),
  item("processing-unit", 5),
  item("low-density-structure", 5),
  item("kr-energy-control-unit", 5),
})

builders.recipe("aeg_huge-electric-pole-4", "po-huge-electric-pole", "b[huge-electric-pole-4]", {
  item("aeg_huge-electric-pole-3", 1),
  item("copper-plate", 15),
  item("steel-plate", 15),
  item("iron-stick", 20),
  item("advanced-circuit", 10),
  item("processing-unit", 10),
  item("kr-imersium-beam", 2),
  item("kr-energy-control-unit", 10),
  item("kr-ai-core", 2),
})

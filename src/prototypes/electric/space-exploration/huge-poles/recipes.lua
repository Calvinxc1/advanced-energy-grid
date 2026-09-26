-- Huge pole mk3 and mk4 under Space Exploration; the material mapping is
-- described in prototypes/electric/space-exploration/recipes.lua.

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
  item("se-holmium-cable", 10),
})

builders.recipe("aeg_huge-electric-pole-4", "po-huge-electric-pole", "b[huge-electric-pole-4]", {
  item("aeg_huge-electric-pole-3", 1),
  item("copper-plate", 15),
  item("steel-plate", 15),
  item("iron-stick", 20),
  item("advanced-circuit", 10),
  item("processing-unit", 10),
  item("se-heavy-composite", 2),
  item("se-superconductive-cable", 10),
  item("se-quantum-processor", 2),
})

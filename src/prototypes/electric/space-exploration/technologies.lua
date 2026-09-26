local builders = require("prototypes.electric.late-tiers.builders")
local optional_dependencies = require("prototypes.electric.optional-dependencies")

builders.technology({
  name = "aeg_distance-power-transmission-elite",
  family = "big",
  recipe = "aeg_big-electric-pole-4",
  prerequisites = {
    "aeg_distance-power-transmission-advanced",
    "se-holmium-cable",
  },
  count = 150,
  ingredients = optional_dependencies.unit_ingredients("late"),
  time = 30,
  order = "c-e-c-6",
})

builders.technology({
  name = "aeg_improved-local-energy-distribution-elite",
  family = "substation",
  recipe = "aeg_substation-4",
  prerequisites = {
    "aeg_improved-local-energy-distribution-advanced",
    "se-superconductive-cable",
    "se-quantum-processor",
  },
  count = 200,
  ingredients = optional_dependencies.unit_ingredients("late"),
  time = 45,
  order = "c-e-b-7",
})

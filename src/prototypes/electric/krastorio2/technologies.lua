local builders = require("prototypes.electric.late-tiers.builders")
local optional_dependencies = require("prototypes.electric.optional-dependencies")

builders.technology({
  name = "aeg_distance-power-transmission-elite",
  family = "big",
  recipe = "aeg_big-electric-pole-4",
  prerequisites = {
    "aeg_distance-power-transmission-advanced",
    optional_dependencies.electromagnetic_prerequisite(),
    "kr-imersium-processing",
    "kr-energy-control-unit",
  },
  count = 150,
  ingredients = optional_dependencies.electromagnetic_unit_ingredients(),
  time = 30,
  order = "c-e-c-6",
})

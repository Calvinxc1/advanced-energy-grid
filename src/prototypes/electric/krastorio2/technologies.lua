local builders = require("prototypes.electric.late-tiers.builders")
local optional_dependencies = require("prototypes.electric.optional-dependencies")

builders.technology({
  name = "aeg_distance-power-transmission-elite",
  family = "big",
  recipe = "aeg_big-electric-pole-4",
  prerequisites = optional_dependencies.prerequisites("late", {
    "aeg_distance-power-transmission-advanced",
    "kr-imersium-processing",
  }),
  count = 150,
  ingredients = optional_dependencies.unit_ingredients("late"),
  time = 30,
  order = "c-e-c-6",
})

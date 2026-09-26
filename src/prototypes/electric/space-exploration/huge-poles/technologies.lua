local builders = require("prototypes.electric.late-tiers.builders")
local optional_dependencies = require("prototypes.electric.optional-dependencies")

builders.technology({
  name = "aeg_improved-distance-power-transmission-advanced",
  family = "huge",
  recipe = "aeg_huge-electric-pole-3",
  prerequisites = {
    "aeg_improved-distance-power-transmission-improved",
    "aeg_distance-power-transmission-elite",
  },
  count = 1000,
  ingredients = optional_dependencies.unit_ingredients("late"),
  time = 45,
  order = "c-e-c-a",
})


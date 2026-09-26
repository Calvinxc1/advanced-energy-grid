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
  ingredients = optional_dependencies.electromagnetic_unit_ingredients(),
  time = 45,
  order = "c-e-c-a",
})

builders.technology({
  name = "aeg_improved-distance-power-transmission-elite",
  family = "huge",
  recipe = "aeg_huge-electric-pole-4",
  prerequisites = {
    "aeg_improved-distance-power-transmission-advanced",
    "se-superconductive-cable",
    "se-quantum-processor",
    "se-heavy-composite",
  },
  count = 1500,
  ingredients = optional_dependencies.electromagnetic_unit_ingredients(),
  time = 45,
  order = "c-e-c-a",
})

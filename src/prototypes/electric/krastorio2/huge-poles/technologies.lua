local builders = require("prototypes.electric.late-tiers.builders")
local optional_dependencies = require("prototypes.electric.optional-dependencies")

builders.technology({
  name = "aeg_improved-distance-power-transmission-advanced",
  family = "huge",
  recipe = "aeg_huge-electric-pole-3",
  prerequisites = {
    "aeg_improved-distance-power-transmission-improved",
    "aeg_distance-power-transmission-elite",
    "kr-energy-control-unit",
  },
  count = 1000,
  ingredients = optional_dependencies.unit_ingredients("late"),
  time = 45,
  order = "c-e-c-a",
})

-- The Space Age mk4 follows cryogenic science alongside the substation mk4;
-- here that is the advanced tech card, which unlocks K2's superior substation.
local mk4_ingredients = optional_dependencies.unit_ingredients("late")
table.insert(mk4_ingredients, { "kr-advanced-tech-card", 1 })

builders.technology({
  name = "aeg_improved-distance-power-transmission-elite",
  family = "huge",
  recipe = "aeg_huge-electric-pole-4",
  prerequisites = {
    "aeg_improved-distance-power-transmission-advanced",
    "kr-advanced-tech-card",
    "kr-ai-core",
  },
  count = 1500,
  ingredients = mk4_ingredients,
  time = 45,
  order = "c-e-c-a",
})

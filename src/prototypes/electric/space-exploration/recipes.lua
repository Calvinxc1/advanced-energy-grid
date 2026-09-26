-- Late tiers under Space Exploration without Krastorio 2. (SE excludes Space
-- Age; with K2 present, prototypes/electric/krastorio2/ supplies them.) The
-- Space Age recipes map role for role onto SE's materials, at two levels:
--
--   elite tiers (Space Age: electromagnetic science), gated on energy science 1
--     superconductor                 -> holmium cable
--   cryogenic tiers (Space Age: cryogenic science), SE tier 3
--     superconductor                 -> superconductive cable
--     foundation (structure)         -> heavy composite
--     quantum processor              -> quantum processor

local builders = require("prototypes.electric.late-tiers.builders")
local item = builders.item

builders.recipe("aeg_big-electric-pole-4", "big-electric-pole", "a[big-electric-pole-4]", {
  item("aeg_big-electric-pole-3", 1),
  item("steel-plate", 3),
  item("copper-plate", 3),
  item("processing-unit", 2),
  item("se-holmium-cable", 4),
})

builders.recipe("aeg_substation-4", "substation", "c[substation-4]", {
  item("aeg_substation-3", 1),
  item("advanced-circuit", 2),
  item("processing-unit", 5),
  item("se-superconductive-cable", 10),
  item("se-quantum-processor", 2),
  item("steel-plate", 10),
  item("copper-plate", 5),
})

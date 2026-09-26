-- Late tiers under Space Exploration without Krastorio 2. (SE excludes Space
-- Age; with K2 present, prototypes/electric/krastorio2/ supplies them.) The
-- Space Age recipes map role for role onto SE's materials, at two levels:
--
--   big pole mk4 (Space Age: electromagnetic science), gated on energy
--   science 1 like the huge pole mk3
--     superconductor                 -> holmium cable
--   substation mk4 (Space Age: cryogenic science), gated on energy science 2
--     superconductor, quantum processor -> holmium solenoid
--   The substation mk4 sits beside SE's pylon substation, which is built on
--   the same solenoid; at SE tier 3 it would arrive after that far stronger
--   substation. (The huge pole mk4 is SE's pylon.)

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
  item("se-holmium-solenoid", 4),
  item("steel-plate", 10),
  item("copper-plate", 5),
})

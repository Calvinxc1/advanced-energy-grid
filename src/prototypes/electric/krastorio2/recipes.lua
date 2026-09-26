-- Late tiers under Krastorio 2 without Space Age (and under Space Exploration
-- with Krastorio 2, which re-tiers these materials into its own progression).
-- The Space Age recipes map role for role onto K2's materials:
--
--   superconductor (conductor)       -> rare metals on the big pole mk4,
--                                       energy control unit on the huge poles
--   foundation (structure)           -> imersium beam
--   quantum processor                -> AI core
--
-- The big pole mk4 is the first tier past the matter card, so it takes only
-- imersium; the energy control unit, K2's heaviest intermediate, waits for the
-- huge pole mk3.
--
-- The substation mk4 is K2's superior substation; prototypes/electric/krastorio2.lua
-- builds it from a substation mk3.

local builders = require("prototypes.electric.late-tiers.builders")
local item = builders.item

builders.recipe("aeg_big-electric-pole-4", "big-electric-pole", "a[big-electric-pole-4]", {
  item("aeg_big-electric-pole-3", 1),
  item("processing-unit", 2),
  item("kr-imersium-beam", 2),
  item("kr-rare-metals", 4),
})

local optional_dependencies = require("prototypes.electric.optional-dependencies")

require("prototypes.electric.categories")
require("prototypes.electric.poles")

-- The late tiers: big pole and substation mk4. Their recipes need materials
-- the base game does not have (superconductor and quantum processor under
-- Space Age, or an overhaul's equivalents), so without Space Age or an
-- overhaul the ladders top out at mk3 for those two and at mk4 for the small
-- and medium lines. The entities and items are shared; recipes and
-- technologies come from the source that supplies the materials.
if optional_dependencies.has_late_tiers then
  local source = "prototypes.electric." .. optional_dependencies.late_tier_source
  require("prototypes.electric.late-tiers.entities")
  require("prototypes.electric.late-tiers.items")
  require(source .. ".recipes")
  require(source .. ".technologies")
end

if optional_dependencies.has_krastorio2 then
  require("prototypes.electric.krastorio2")
end

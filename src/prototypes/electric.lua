local optional_dependencies = require("prototypes.electric.optional-dependencies")

require("prototypes.electric.categories")
require("prototypes.electric.poles")

-- Tiers that only exist under Space Age: the big-pole and substation mk4
-- tiers, whose recipes need superconductor and quantum processor. Everything
-- above is the base-game ladder, which tops out at mk3 for those two and at
-- mk4 for the small and medium lines.
if optional_dependencies.has_space_age then
  require("prototypes.electric.space-age")
end

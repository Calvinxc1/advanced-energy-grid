local optional_dependencies = require("prototypes.electric.optional-dependencies")

-- The huge-pole ladder is built on Power Overload's own huge pole, so it only
-- exists when that mod is loaded. This runs in data-updates so Power Overload's
-- prototypes are already in place to copy from.
if optional_dependencies.has_power_overload then
  require("prototypes.electric.huge-poles")

  -- mk3 and mk4 are late tiers: their recipes need Space Age's or an
  -- overhaul's materials, so the huge ladder stops at mk2 without them.
  if optional_dependencies.has_late_tiers then
    local source = "prototypes.electric." .. optional_dependencies.late_tier_source
    require("prototypes.electric.late-tiers.huge-poles.entities")
    require("prototypes.electric.late-tiers.huge-poles.items")
    require(source .. ".huge-poles.recipes")
    require(source .. ".huge-poles.technologies")
  end
end

if optional_dependencies.has_krastorio2 then
  require("prototypes.electric.krastorio2-updates")
end

-- After every recipe is final, so each technology can pick up the unlocks
-- its ingredients need.
require("prototypes.electric.technology-fixes")

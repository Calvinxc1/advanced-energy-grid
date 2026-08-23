local optional_dependencies = require("prototypes.electric.optional-dependencies")

-- The huge-pole ladder is built on Power Overload's own huge pole, so it only
-- exists when that mod is loaded. This runs in data-updates so Power Overload's
-- prototypes are already in place to copy from.
if optional_dependencies.has_power_overload then
  require("prototypes.electric.huge-poles")

  -- mk3 and mk4 need superconductor, foundation, and quantum processor, so the
  -- huge ladder stops at mk2 in a base-game load.
  if optional_dependencies.has_space_age then
    require("prototypes.electric.space-age.huge-poles")
  end
end

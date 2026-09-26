-- Late mk3 and mk4 tiers for the huge-pole ladder. They exist whenever Space
-- Age or an overhaul supplies materials for them (see
-- optional_dependencies.late_tier_source); the recipes and technologies come
-- from that source's directory. prototypes/electric/huge-poles/entities.lua
-- terminates the ladder at mk2; this file extends it.
--
-- Under Space Exploration the mk4 is SE's pylon, so no huge pole mk4 of this
-- mod's own is built there; prototypes/electric/space-exploration-updates.lua
-- fits the pylon onto the ladder. Factorio requires an upgrade target to share
-- its source's collision mask, and SE gives space-capable poles such as the
-- pylon their own, so the mk3 is the top of the upgrade chain there.

local optional_dependencies = require("prototypes.electric.optional-dependencies")
local builds_mk4 = optional_dependencies.builds("aeg_huge-electric-pole-4")

local huge_pole_mk3_entity = util.table.deepcopy(data.raw["electric-pole"]["po-huge-electric-pole"])
huge_pole_mk3_entity.name = "aeg_huge-electric-pole-3"
huge_pole_mk3_entity.minable.result = "aeg_huge-electric-pole-3"
huge_pole_mk3_entity.maximum_wire_distance = 56
huge_pole_mk3_entity.fast_replaceable_group = "huge-electric-pole"
huge_pole_mk3_entity.next_upgrade = builds_mk4 and "aeg_huge-electric-pole-4" or nil
data:extend{huge_pole_mk3_entity}

if builds_mk4 then
  local huge_pole_mk4_entity = util.table.deepcopy(data.raw["electric-pole"]["po-huge-electric-pole"])
  huge_pole_mk4_entity.name = "aeg_huge-electric-pole-4"
  huge_pole_mk4_entity.minable.result = "aeg_huge-electric-pole-4"
  huge_pole_mk4_entity.maximum_wire_distance = 64
  huge_pole_mk4_entity.fast_replaceable_group = "huge-electric-pole"
  huge_pole_mk4_entity.next_upgrade = nil
  data:extend{huge_pole_mk4_entity}
end

-- Re-point the base ladder's top tier now that a tier above it exists.
data.raw["electric-pole"]["aeg_huge-electric-pole-2"].next_upgrade = "aeg_huge-electric-pole-3"

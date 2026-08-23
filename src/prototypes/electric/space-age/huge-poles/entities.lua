-- Space Age mk3 and mk4 tiers for the huge-pole ladder. Their recipes need
-- superconductor, foundation, and quantum processor, so they cannot exist in a
-- base-game load. prototypes/electric/huge-poles/entities.lua terminates the
-- ladder at mk2; this file extends it.

local huge_pole_mk3_entity = util.table.deepcopy(data.raw["electric-pole"]["po-huge-electric-pole"])
huge_pole_mk3_entity.name = "aeg_huge-electric-pole-3"
huge_pole_mk3_entity.minable.result = "aeg_huge-electric-pole-3"
huge_pole_mk3_entity.maximum_wire_distance = 56
huge_pole_mk3_entity.fast_replaceable_group = "huge-electric-pole"
huge_pole_mk3_entity.next_upgrade = "aeg_huge-electric-pole-4"

local huge_pole_mk4_entity = util.table.deepcopy(data.raw["electric-pole"]["po-huge-electric-pole"])
huge_pole_mk4_entity.name = "aeg_huge-electric-pole-4"
huge_pole_mk4_entity.minable.result = "aeg_huge-electric-pole-4"
huge_pole_mk4_entity.maximum_wire_distance = 64
huge_pole_mk4_entity.fast_replaceable_group = "huge-electric-pole"
huge_pole_mk4_entity.next_upgrade = nil

data:extend{huge_pole_mk3_entity, huge_pole_mk4_entity}

-- Re-point the base ladder's top tier now that a tier above it exists.
data.raw["electric-pole"]["aeg_huge-electric-pole-2"].next_upgrade = "aeg_huge-electric-pole-3"

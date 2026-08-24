data.raw["electric-pole"]["po-huge-electric-pole"].maximum_wire_distance = 40
data.raw["electric-pole"]["po-huge-electric-pole"].fast_replaceable_group = "huge-electric-pole"
data.raw["electric-pole"]["po-huge-electric-pole"].next_upgrade = "aeg_huge-electric-pole-2"

local huge_pole_mk2_entity = util.table.deepcopy(data.raw["electric-pole"]["po-huge-electric-pole"])
huge_pole_mk2_entity.name = "aeg_huge-electric-pole-2"
huge_pole_mk2_entity.minable.result = "aeg_huge-electric-pole-2"
huge_pole_mk2_entity.maximum_wire_distance = 48
huge_pole_mk2_entity.fast_replaceable_group = "huge-electric-pole"
-- Terminates the base-game ladder. prototypes/electric/space-age/huge-poles/entities.lua
-- re-points this at mk3 when Space Age supplies the ingredients for one.
huge_pole_mk2_entity.next_upgrade = nil

data:extend{huge_pole_mk2_entity}

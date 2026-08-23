-- Space Age mk4 tiers for the big pole and substation ladders. Their recipes
-- need superconductor and quantum processor, so they cannot exist in a
-- base-game load. prototypes/electric/poles/entities.lua terminates both
-- ladders at mk3; this file extends them.

local big_electric_pole_mk4 = util.table.deepcopy(data.raw["electric-pole"]["big-electric-pole"])
big_electric_pole_mk4.maximum_wire_distance = 50
big_electric_pole_mk4.supply_area_distance = 2.5
big_electric_pole_mk4.name = "aeg_big-electric-pole-4"
big_electric_pole_mk4.minable.result =  "aeg_big-electric-pole-4"
big_electric_pole_mk4.fast_replaceable_group = "big-electric-pole"
big_electric_pole_mk4.next_upgrade = nil
data:extend({big_electric_pole_mk4})

local substation_mk4 = util.table.deepcopy(data.raw["electric-pole"]["substation"])
substation_mk4.maximum_wire_distance = 24
substation_mk4.supply_area_distance = 12
substation_mk4.name = "aeg_substation-4"
substation_mk4.minable.result =  "aeg_substation-4"
substation_mk4.fast_replaceable_group = "substation"
substation_mk4.next_upgrade = nil
data:extend({substation_mk4})

-- Re-point the base ladders' top tiers now that a tier above them exists.
data.raw["electric-pole"]["aeg_big-electric-pole-3"].next_upgrade = "aeg_big-electric-pole-4"
data.raw["electric-pole"]["aeg_substation-3"].next_upgrade = "aeg_substation-4"

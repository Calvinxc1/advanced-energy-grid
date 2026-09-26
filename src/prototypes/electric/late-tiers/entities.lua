-- Late mk4 tiers for the big pole and substation ladders. They exist whenever
-- Space Age or an overhaul supplies materials for them (see
-- optional_dependencies.late_tier_source); the recipes and technologies come
-- from that source's directory. prototypes/electric/poles/entities.lua
-- terminates both ladders at mk3; this file extends them.
--
-- Under Krastorio 2 the substation mk4 is K2's superior substation, so no
-- substation of this mod's own is built there; prototypes/electric/krastorio2.lua
-- fits the superior substation into the ladder.

local optional_dependencies = require("prototypes.electric.optional-dependencies")
local name = optional_dependencies.name

local big_electric_pole_mk4 = util.table.deepcopy(data.raw["electric-pole"]["big-electric-pole"])
big_electric_pole_mk4.maximum_wire_distance = 50
big_electric_pole_mk4.supply_area_distance = 2.5
big_electric_pole_mk4.name = "aeg_big-electric-pole-4"
big_electric_pole_mk4.minable.result =  "aeg_big-electric-pole-4"
big_electric_pole_mk4.fast_replaceable_group = "big-electric-pole"
big_electric_pole_mk4.next_upgrade = nil
data:extend({big_electric_pole_mk4})

if name("aeg_substation-4") == "aeg_substation-4" then
  local substation_mk4 = util.table.deepcopy(data.raw["electric-pole"]["substation"])
  substation_mk4.maximum_wire_distance = 24
  substation_mk4.supply_area_distance = 12
  substation_mk4.name = "aeg_substation-4"
  substation_mk4.minable.result =  "aeg_substation-4"
  substation_mk4.fast_replaceable_group = "substation"
  substation_mk4.next_upgrade = nil
  data:extend({substation_mk4})
end

-- Re-point the base ladders' top tiers now that a tier above them exists.
data.raw["electric-pole"]["aeg_big-electric-pole-3"].next_upgrade = "aeg_big-electric-pole-4"
data.raw["electric-pole"]["aeg_substation-3"].next_upgrade = name("aeg_substation-4")

local optional_dependencies = require("prototypes.electric.optional-dependencies")

local huge_pole_mk3_item = util.table.deepcopy(data.raw.item["po-huge-electric-pole"])
huge_pole_mk3_item.subgroup = "aeg_distance-transmission"
huge_pole_mk3_item.order = "b[huge-electric-pole-3]"
huge_pole_mk3_item.name = "aeg_huge-electric-pole-3"
huge_pole_mk3_item.place_result = "aeg_huge-electric-pole-3"

data:extend{huge_pole_mk3_item}

if optional_dependencies.builds("aeg_huge-electric-pole-4") then
  local huge_pole_mk4_item = util.table.deepcopy(data.raw.item["po-huge-electric-pole"])
  huge_pole_mk4_item.subgroup = "aeg_distance-transmission"
  huge_pole_mk4_item.order = "b[huge-electric-pole-4]"
  huge_pole_mk4_item.name = "aeg_huge-electric-pole-4"
  huge_pole_mk4_item.place_result = "aeg_huge-electric-pole-4"
  data:extend{huge_pole_mk4_item}
end

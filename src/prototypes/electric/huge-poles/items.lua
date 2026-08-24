data.raw.item["po-huge-electric-pole"].subgroup = "aeg_distance-transmission"
data.raw.item["po-huge-electric-pole"].order = "b[huge-electric-pole-1]"

local huge_pole_mk2_item = util.table.deepcopy(data.raw.item["po-huge-electric-pole"])
huge_pole_mk2_item.subgroup = "aeg_distance-transmission"
huge_pole_mk2_item.order = "b[huge-electric-pole-2]"
huge_pole_mk2_item.name = "aeg_huge-electric-pole-2"
huge_pole_mk2_item.place_result = "aeg_huge-electric-pole-2"

data:extend{huge_pole_mk2_item}

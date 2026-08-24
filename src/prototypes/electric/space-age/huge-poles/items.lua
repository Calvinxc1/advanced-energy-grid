local huge_pole_mk3_item = util.table.deepcopy(data.raw.item["po-huge-electric-pole"])
huge_pole_mk3_item.subgroup = "aeg_poles"
huge_pole_mk3_item.order = "a[energy]-e[huge-electric-pole-3]"
huge_pole_mk3_item.name = "aeg_huge-electric-pole-3"
huge_pole_mk3_item.place_result = "aeg_huge-electric-pole-3"

local huge_pole_mk4_item = util.table.deepcopy(data.raw.item["po-huge-electric-pole"])
huge_pole_mk4_item.subgroup = "aeg_poles"
huge_pole_mk4_item.order = "a[energy]-e[huge-electric-pole-4]"
huge_pole_mk4_item.name = "aeg_huge-electric-pole-4"
huge_pole_mk4_item.place_result = "aeg_huge-electric-pole-4"

data:extend{huge_pole_mk3_item, huge_pole_mk4_item}

local big_electric_pole_mk4 = util.table.deepcopy(data.raw.item["big-electric-pole"])
big_electric_pole_mk4.order = "a[energy]-c[big-electric-pole-4]"
big_electric_pole_mk4.subgroup = "aeg_poles"
big_electric_pole_mk4.name = "aeg_big-electric-pole-4"
big_electric_pole_mk4.place_result = "aeg_big-electric-pole-4"
data:extend({big_electric_pole_mk4})

local substation_mk4 = util.table.deepcopy(data.raw.item["substation"])
substation_mk4.order = "a[energy]-d[substation-4]"
substation_mk4.subgroup = "aeg_poles"
substation_mk4.name = "aeg_substation-4"
substation_mk4.place_result = "aeg_substation-4"
data:extend({substation_mk4})

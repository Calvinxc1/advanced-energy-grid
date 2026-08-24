data.raw.item["small-electric-pole"].order = "a[small-electric-pole-1]"
data.raw.item["small-electric-pole"].subgroup = "aeg_local-distribution"
data.raw.item["medium-electric-pole"].order = "b[medium-electric-pole-1]"
data.raw.item["medium-electric-pole"].subgroup = "aeg_local-distribution"
data.raw.item["big-electric-pole"].order = "a[big-electric-pole-1]"
data.raw.item["big-electric-pole"].subgroup = "aeg_distance-transmission"
data.raw.item["substation"].order = "c[substation-1]"
data.raw.item["substation"].subgroup = "aeg_local-distribution"

local small_electric_pole_mk2 = util.table.deepcopy(data.raw.item["small-electric-pole"])
small_electric_pole_mk2.order = "a[small-electric-pole-2]"
small_electric_pole_mk2.subgroup = "aeg_local-distribution"
small_electric_pole_mk2.name = "aeg_small-electric-pole-2"
small_electric_pole_mk2.place_result = "aeg_small-electric-pole-2"
data:extend({small_electric_pole_mk2})

local medium_electric_pole_mk2 = util.table.deepcopy(data.raw.item["medium-electric-pole"])
medium_electric_pole_mk2.order = "b[medium-electric-pole-2]"
medium_electric_pole_mk2.subgroup = "aeg_local-distribution"
medium_electric_pole_mk2.name = "aeg_medium-electric-pole-2"
medium_electric_pole_mk2.place_result = "aeg_medium-electric-pole-2"
data:extend({medium_electric_pole_mk2})

local medium_electric_pole_mk3 = util.table.deepcopy(data.raw.item["medium-electric-pole"])
medium_electric_pole_mk3.order = "b[medium-electric-pole-3]"
medium_electric_pole_mk3.subgroup = "aeg_local-distribution"
medium_electric_pole_mk3.name = "aeg_medium-electric-pole-3"
medium_electric_pole_mk3.place_result = "aeg_medium-electric-pole-3"
data:extend({medium_electric_pole_mk3})

local medium_electric_pole_mk4 = util.table.deepcopy(data.raw.item["medium-electric-pole"])
medium_electric_pole_mk4.order = "b[medium-electric-pole-4]"
medium_electric_pole_mk4.subgroup = "aeg_local-distribution"
medium_electric_pole_mk4.name = "aeg_medium-electric-pole-4"
medium_electric_pole_mk4.place_result = "aeg_medium-electric-pole-4"
data:extend({medium_electric_pole_mk4})

local big_electric_pole_mk2 = util.table.deepcopy(data.raw.item["big-electric-pole"])
big_electric_pole_mk2.order = "a[big-electric-pole-2]"
big_electric_pole_mk2.subgroup = "aeg_distance-transmission"
big_electric_pole_mk2.name = "aeg_big-electric-pole-2"
big_electric_pole_mk2.place_result = "aeg_big-electric-pole-2"
data:extend({big_electric_pole_mk2})

local big_electric_pole_mk3 = util.table.deepcopy(data.raw.item["big-electric-pole"])
big_electric_pole_mk3.order = "a[big-electric-pole-3]"
big_electric_pole_mk3.subgroup = "aeg_distance-transmission"
big_electric_pole_mk3.name = "aeg_big-electric-pole-3"
big_electric_pole_mk3.place_result = "aeg_big-electric-pole-3"
data:extend({big_electric_pole_mk3})


local substation_mk2 = util.table.deepcopy(data.raw.item["substation"])
substation_mk2.order = "c[substation-2]"
substation_mk2.subgroup = "aeg_local-distribution"
substation_mk2.name = "aeg_substation-2"
substation_mk2.place_result = "aeg_substation-2"
data:extend({substation_mk2})

local substation_mk3 = util.table.deepcopy(data.raw.item["substation"])
substation_mk3.order = "c[substation-3]"
substation_mk3.subgroup = "aeg_local-distribution"
substation_mk3.name = "aeg_substation-3"
substation_mk3.place_result = "aeg_substation-3"
data:extend({substation_mk3})


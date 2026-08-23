local big_pole_technology_icon = "__advanced-energy-grid__/graphics/technology/big-electric-pole.png"
local substation_technology_icon = "__advanced-energy-grid__/graphics/technology/electric-substation.png"

local function use_locale_and_icon(technology, icon)
    technology.localised_name = nil
    technology.localised_description = nil
    technology.hidden = false
    technology.enabled = true
    technology.icon = icon
    technology.icon_size = 256
    technology.icons = nil
    technology.upgrade = false
end

local big_pole_mk4 = util.table.deepcopy(data.raw.technology["electric-energy-distribution-1"])
big_pole_mk4.name = "aeg_distance-power-transmission-elite"
use_locale_and_icon(big_pole_mk4, big_pole_technology_icon)
big_pole_mk4.effects = {
    {type = "unlock-recipe", recipe = "aeg_big-electric-pole-4"},
}
big_pole_mk4.prerequisites = {
    "aeg_distance-power-transmission-advanced",
    "electromagnetic-science-pack",
}
big_pole_mk4.unit.count = 150
big_pole_mk4.unit.ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1},
    {"space-science-pack", 1},
    {"electromagnetic-science-pack", 1},
}
big_pole_mk4.unit.time = 30
big_pole_mk4.order = "c-e-c-6"
data:extend({big_pole_mk4})

local substation_mk4 = util.table.deepcopy(data.raw.technology["electric-energy-distribution-2"])
substation_mk4.name = "aeg_improved-local-energy-distribution-elite"
use_locale_and_icon(substation_mk4, substation_technology_icon)
substation_mk4.effects = {
    {type = "unlock-recipe", recipe = "aeg_substation-4"},
}
substation_mk4.prerequisites = {
    "aeg_improved-local-energy-distribution-advanced",
    "cryogenic-science-pack",
    "quantum-processor",
}
substation_mk4.unit.count = 200
substation_mk4.unit.ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"production-science-pack", 1},
    {"utility-science-pack", 1},
    {"space-science-pack", 1},
    {"electromagnetic-science-pack", 1},
    {"cryogenic-science-pack", 1},
}
substation_mk4.unit.time = 45
substation_mk4.order = "c-e-b-7"
data:extend({substation_mk4})

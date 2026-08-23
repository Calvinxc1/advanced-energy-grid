local huge_pole_technology_icon = "__advanced-energy-grid__/graphics/technology/huge-electric-pole.png"

local function use_huge_pole_icon(technology)
  technology.icon = huge_pole_technology_icon
  technology.icon_size = 256
  technology.icons = nil
  technology.hidden = false
  technology.enabled = true
end

local huge_pole_mk3_tech = util.table.deepcopy(data.raw["technology"]["po-electric-energy-distribution-3"])
huge_pole_mk3_tech.name = "aeg_improved-distance-power-transmission-advanced"
huge_pole_mk3_tech.localised_name = nil
huge_pole_mk3_tech.localised_description = nil
use_huge_pole_icon(huge_pole_mk3_tech)
huge_pole_mk3_tech.effects = {
  { type = "unlock-recipe", recipe = "aeg_huge-electric-pole-3" },
}
huge_pole_mk3_tech.prerequisites = {
  "aeg_improved-distance-power-transmission-improved",
  "aeg_distance-power-transmission-elite",
}
huge_pole_mk3_tech.unit = {
  count = 1000,
  ingredients = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "electromagnetic-science-pack", 1 },
  },
  time = 45,
}
huge_pole_mk3_tech.order = "c-e-c-a"
data:extend{huge_pole_mk3_tech}

local huge_pole_mk4_tech = util.table.deepcopy(data.raw["technology"]["po-electric-energy-distribution-3"])
huge_pole_mk4_tech.name = "aeg_improved-distance-power-transmission-elite"
huge_pole_mk4_tech.localised_name = nil
huge_pole_mk4_tech.localised_description = nil
use_huge_pole_icon(huge_pole_mk4_tech)
huge_pole_mk4_tech.effects = {
  { type = "unlock-recipe", recipe = "aeg_huge-electric-pole-4" },
}
huge_pole_mk4_tech.prerequisites = {
  "aeg_improved-distance-power-transmission-advanced",
  "cryogenic-science-pack",
  "foundation",
  "quantum-processor",
}
huge_pole_mk4_tech.unit = {
  count = 1500,
  ingredients = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 },
    { "space-science-pack", 1 },
    { "electromagnetic-science-pack", 1 },
    { "cryogenic-science-pack", 1 },
  },
  time = 45,
}
huge_pole_mk4_tech.order = "c-e-c-a"
data:extend{huge_pole_mk4_tech}

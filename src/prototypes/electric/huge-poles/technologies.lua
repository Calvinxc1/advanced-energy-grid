local optional_dependencies = require("prototypes.electric.optional-dependencies")

local huge_pole_technology_icon = "__advanced-energy-grid__/graphics/technology/huge-electric-pole.png"

local function use_huge_pole_icon(technology)
  technology.icon = huge_pole_technology_icon
  technology.icon_size = 256
  technology.icons = nil
  technology.hidden = false
  technology.enabled = true
end

local huge_pole_mk1_tech = data.raw["technology"]["po-electric-energy-distribution-3"]
huge_pole_mk1_tech.localised_name = {"technology-name.po-electric-energy-distribution-3"}
huge_pole_mk1_tech.localised_description = {"technology-description.po-electric-energy-distribution-3"}
use_huge_pole_icon(huge_pole_mk1_tech)
huge_pole_mk1_tech.prerequisites = {
  "production-science-pack",
  "utility-science-pack",
}
huge_pole_mk1_tech.unit = {
  count = 500,
  ingredients = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
    { "production-science-pack", 1 },
    { "utility-science-pack", 1 },
  },
  time = 45,
}

local huge_pole_mk2_tech = util.table.deepcopy(data.raw["technology"]["po-electric-energy-distribution-3"])
huge_pole_mk2_tech.name = "aeg_improved-distance-power-transmission-improved"
huge_pole_mk2_tech.localised_name = nil
huge_pole_mk2_tech.localised_description = nil
use_huge_pole_icon(huge_pole_mk2_tech)
huge_pole_mk2_tech.effects = {
  { type = "unlock-recipe", recipe = "aeg_huge-electric-pole-2" },
}
huge_pole_mk2_tech.prerequisites = {
  "po-electric-energy-distribution-3",
  "aeg_distance-power-transmission-advanced",
  optional_dependencies.electromagnetic_prerequisite(),
}
huge_pole_mk2_tech.unit = {
  count = 750,
  ingredients = optional_dependencies.electromagnetic_unit_ingredients(),
  time = 45,
}
huge_pole_mk2_tech.order = "c-e-c-a"
data:extend{huge_pole_mk2_tech}

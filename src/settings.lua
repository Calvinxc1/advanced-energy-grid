local optional_dependencies = require("prototypes.electric.optional-dependencies")

if optional_dependencies.has_power_overload then
  require("__PowerOverload__/registry")

  -- Each tier carries twice the power of the tier below it, starting from the
  -- mk1 pole's Power Overload default. Power Overload raises those defaults
  -- under Krastorio 2 (its own mod_pole_names table in shared.lua), so the
  -- tiers are scaled from the mk1 value for the load; otherwise a K2 big pole
  -- mk1 (2GW there) would carry more than this mod's mk3.
  local FIRST_RUNG_MW = {
    base = { small = 10, medium = 60, big = 300, substation = 125, huge = 3000 },
    krastorio2 = { small = 20, medium = 200, big = 2000, substation = 400, huge = 10000 },
  }
  local first_rung = FIRST_RUNG_MW[optional_dependencies.has_krastorio2 and "krastorio2" or "base"]

  local function power(family, tier)
    local megawatts = first_rung[family] * 2 ^ (tier - 1)
    if megawatts >= 1000 then
      return string.format("%gGW", megawatts / 1000)
    end
    return string.format("%gMW", megawatts)
  end

  -- Every pole this mod adds in the load. Registering a pole that was never
  -- created would leave an orphan startup setting in Power Overload's
  -- settings UI with nothing behind it, so the late tiers are appended only
  -- when they actually exist, under the name that tier has in this load.
  local aeg_poles = {
    {name = "aeg_small-electric-pole-2", family = "small", tier = 2},

    {name = "aeg_medium-electric-pole-2", family = "medium", tier = 2},
    {name = "aeg_medium-electric-pole-3", family = "medium", tier = 3},
    {name = "aeg_medium-electric-pole-4", family = "medium", tier = 4},

    {name = "aeg_big-electric-pole-2", family = "big", tier = 2},
    {name = "aeg_big-electric-pole-3", family = "big", tier = 3},

    {name = "aeg_substation-2", family = "substation", tier = 2},
    {name = "aeg_substation-3", family = "substation", tier = 3},

    {name = "aeg_huge-electric-pole-2", family = "huge", tier = 2},
  }

  if optional_dependencies.has_late_tiers then
    local late_poles = {
      {name = "aeg_big-electric-pole-4", family = "big", tier = 4},
      {name = optional_dependencies.name("aeg_substation-4"), family = "substation", tier = 4},
      {name = "aeg_huge-electric-pole-3", family = "huge", tier = 3},
      {name = "aeg_huge-electric-pole-4", family = "huge", tier = 4},
    }

    for _, pole in pairs(late_poles) do
      table.insert(aeg_poles, pole)
    end
  end

  for _, pole in pairs(aeg_poles) do
    PowerOverload.register_pole({name = pole.name, default = power(pole.family, pole.tier)})
  end
end

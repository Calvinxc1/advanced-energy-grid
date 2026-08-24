local optional_dependencies = require("prototypes.electric.optional-dependencies")

if optional_dependencies.has_power_overload then
  require("__PowerOverload__/registry")

  -- Every pole this mod adds in a base-game load. Registering a pole that was
  -- never created would leave an orphan startup setting in Power Overload's
  -- settings UI with nothing behind it, so the Space Age tiers are appended
  -- only when they actually exist.
  local aeg_poles = {
    {name = "aeg_small-electric-pole-2", default = "20MW"},

    {name = "aeg_medium-electric-pole-2", default = "120MW"},
    {name = "aeg_medium-electric-pole-3", default = "240MW"},
    {name = "aeg_medium-electric-pole-4", default = "480MW"},

    {name = "aeg_big-electric-pole-2", default = "600MW"},
    {name = "aeg_big-electric-pole-3", default = "1.2GW"},

    {name = "aeg_substation-2", default = "250MW"},
    {name = "aeg_substation-3", default = "500MW"},

    {name = "aeg_huge-electric-pole-2", default = "6GW"},
  }

  if optional_dependencies.has_space_age then
    local space_age_poles = {
      {name = "aeg_big-electric-pole-4", default = "2.4GW"},
      {name = "aeg_substation-4", default = "1GW"},
      {name = "aeg_huge-electric-pole-3", default = "12GW"},
      {name = "aeg_huge-electric-pole-4", default = "24GW"},
    }

    for _, pole in pairs(space_age_poles) do
      table.insert(aeg_poles, pole)
    end
  end

  for _, pole in pairs(aeg_poles) do
    PowerOverload.register_pole(pole)
  end
end

-- Poles Advanced Energy Grid registers with Power Overload in every load.
local expected_poles = {
  ["aeg_small-electric-pole-2"] = "20MW",

  ["aeg_medium-electric-pole-2"] = "120MW",
  ["aeg_medium-electric-pole-3"] = "240MW",
  ["aeg_medium-electric-pole-4"] = "480MW",

  ["aeg_big-electric-pole-2"] = "600MW",
  ["aeg_big-electric-pole-3"] = "1.2GW",

  ["aeg_substation-2"] = "250MW",
  ["aeg_substation-3"] = "500MW",

  ["aeg_huge-electric-pole-2"] = "6GW",
}

-- Tiers whose recipes need superconductor, foundation, or quantum processor.
-- They must be registered under Space Age and absent without it: a registration
-- with no prototype behind it is an orphan setting in Power Overload's UI.
local space_age_poles = {
  ["aeg_big-electric-pole-4"] = "2.4GW",
  ["aeg_substation-4"] = "1GW",
  ["aeg_huge-electric-pole-3"] = "12GW",
  ["aeg_huge-electric-pole-4"] = "24GW",
}

assert(
  PowerOverload and PowerOverload.get_registered_poles,
  "Power Overload registry API (PowerOverload.get_registered_poles) is not available"
)

local registered_poles = PowerOverload.get_registered_poles()

if mods["space-age"] then
  for pole_name, expected_default in pairs(space_age_poles) do
    expected_poles[pole_name] = expected_default
  end
else
  for pole_name in pairs(space_age_poles) do
    assert(
      registered_poles[pole_name] == nil,
      "Advanced Energy Grid registered the Space Age tier " .. pole_name
        .. " in a base-game load, where its prototype is never created"
    )
  end
end

for pole_name, expected_default in pairs(expected_poles) do
  local entry = registered_poles[pole_name]
  assert(entry, "Advanced Energy Grid did not register " .. pole_name .. " with Power Overload")
  assert(
    entry.default == expected_default,
    "Advanced Energy Grid registered " .. pole_name .. " with default "
      .. tostring(entry.default) .. ", expected " .. expected_default
  )
end

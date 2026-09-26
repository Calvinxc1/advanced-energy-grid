-- Poles Advanced Energy Grid registers with Power Overload in every load. Each
-- tier doubles the one below, starting from Power Overload's own mk1 default,
-- which Power Overload raises under Krastorio 2.
local krastorio2 = mods["Krastorio2"] ~= nil

local expected_poles
if krastorio2 then
  expected_poles = {
    ["aeg_small-electric-pole-2"] = "40MW",

    ["aeg_medium-electric-pole-2"] = "400MW",
    ["aeg_medium-electric-pole-3"] = "800MW",
    ["aeg_medium-electric-pole-4"] = "1.6GW",

    ["aeg_big-electric-pole-2"] = "4GW",
    ["aeg_big-electric-pole-3"] = "8GW",

    ["aeg_substation-2"] = "800MW",
    ["aeg_substation-3"] = "1.6GW",

    ["aeg_huge-electric-pole-2"] = "20GW",
  }
else
  expected_poles = {
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
end

-- The late tiers, whose recipes need Space Age's or an overhaul's materials.
-- They must be registered when one of those is loaded and absent otherwise: a
-- registration with no prototype behind it is an orphan setting in Power
-- Overload's UI. Under Krastorio 2 the substation mk4 is K2's superior
-- substation, so that is the name registered, and aeg_substation-4 is not.
local late_poles
if krastorio2 then
  late_poles = {
    ["aeg_big-electric-pole-4"] = "16GW",
    ["kr-superior-substation"] = "3.2GW",
    ["aeg_huge-electric-pole-3"] = "40GW",
    ["aeg_huge-electric-pole-4"] = "80GW",
  }
else
  late_poles = {
    ["aeg_big-electric-pole-4"] = "2.4GW",
    ["aeg_substation-4"] = "1GW",
    ["aeg_huge-electric-pole-3"] = "12GW",
    ["aeg_huge-electric-pole-4"] = "24GW",
  }
end

assert(
  PowerOverload and PowerOverload.get_registered_poles,
  "Power Overload registry API (PowerOverload.get_registered_poles) is not available"
)

local registered_poles = PowerOverload.get_registered_poles()

if mods["space-age"] or krastorio2 or mods["space-exploration"] then
  for pole_name, expected_default in pairs(late_poles) do
    expected_poles[pole_name] = expected_default
  end
else
  for pole_name in pairs(late_poles) do
    assert(
      registered_poles[pole_name] == nil,
      "Advanced Energy Grid registered the late tier " .. pole_name
        .. " in a load without Space Age or an overhaul, where its prototype is never created"
    )
  end
end

if krastorio2 then
  assert(
    registered_poles["aeg_substation-4"] == nil,
    "Advanced Energy Grid registered aeg_substation-4 under Krastorio 2, where K2's superior substation is that tier"
  )
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

-- Resolves everything that differs between a Space Age load and a base-game
-- load. The presence flags are computed once here, and prototype files consume
-- the resolvers below rather than branching on `mods` themselves, so this file
-- is the single auditable answer to "what changes without Space Age?".
--
-- Whole tiers that only exist under Space Age are not handled here; they live
-- in prototypes/electric/space-age/ and are required conditionally from
-- prototypes/electric.lua and prototypes/electric-updates.lua.

local optional_dependencies = {}

optional_dependencies.has_space_age = mods["space-age"] ~= nil
optional_dependencies.has_power_overload = mods["PowerOverload"] ~= nil

-- Picks between a Space Age value and a base-game value. Used for technology
-- prerequisite lists and research units, which differ in gating rather than in
-- shape.
function optional_dependencies.select(space_age, fallback)
  if optional_dependencies.has_space_age then
    return space_age
  end

  return fallback
end

-- The research unit shared by every tier that sits above utility science. Space
-- Age routes it through Vulcanus; the base game tops out at space science, so
-- the electromagnetic pack is simply absent rather than substituted.
function optional_dependencies.electromagnetic_unit_ingredients()
  return optional_dependencies.select(
    {
      { "automation-science-pack", 1 },
      { "logistic-science-pack", 1 },
      { "chemical-science-pack", 1 },
      { "production-science-pack", 1 },
      { "utility-science-pack", 1 },
      { "space-science-pack", 1 },
      { "electromagnetic-science-pack", 1 },
    },
    {
      { "automation-science-pack", 1 },
      { "logistic-science-pack", 1 },
      { "chemical-science-pack", 1 },
      { "production-science-pack", 1 },
      { "utility-science-pack", 1 },
      { "space-science-pack", 1 },
    }
  )
end

-- The prerequisite that gates an elite tier. Space Age gates on the
-- electromagnetic pack; without it the equivalent wall is space science, which
-- is the base game's own capstone.
function optional_dependencies.electromagnetic_prerequisite()
  return optional_dependencies.select("electromagnetic-science-pack", "space-science-pack")
end

return optional_dependencies

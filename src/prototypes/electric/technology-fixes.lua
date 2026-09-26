-- Technology corrections that depend on where other mods left their unlocks.
-- Runs in data-updates, after the overhauls this mod loads after have moved
-- theirs.

local optional_dependencies = require("prototypes.electric.optional-dependencies")

local function add_prerequisite(technology, prerequisite_name)
  technology.prerequisites = technology.prerequisites or {}
  for _, existing in pairs(technology.prerequisites) do
    if existing == prerequisite_name then
      return
    end
  end
  table.insert(technology.prerequisites, prerequisite_name)
end

local function unlocking_technology(recipe_name)
  for technology_name, technology in pairs(data.raw.technology) do
    for _, effect in pairs(technology.effects or {}) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
        return technology_name
      end
    end
  end
end

-- The small pole mk2 is made from electronic circuits, so its technology waits
-- on whichever technology unlocks them, unless it already does. In the base
-- game that one comes before logistic science anyway; Space Exploration moves
-- it off that path, and without this the mk2 could be researched before its
-- ingredient.
local function requires(technology, ancestor_name, visited)
  visited = visited or {}
  for _, prerequisite_name in pairs(technology.prerequisites or {}) do
    if prerequisite_name == ancestor_name then
      return true
    end
    local prerequisite = data.raw.technology[prerequisite_name]
    if prerequisite and not visited[prerequisite_name] then
      visited[prerequisite_name] = true
      if requires(prerequisite, ancestor_name, visited) then
        return true
      end
    end
  end
  return false
end

local small_pole_mk2 = data.raw.technology["aeg_improved-electric-poles"]
local circuits = unlocking_technology("electronic-circuit")
if small_pole_mk2 and circuits and not requires(small_pole_mk2, circuits) then
  add_prerequisite(small_pole_mk2, circuits)
end

-- Under an overhaul, a tier never researches for less than what it builds on:
-- it takes every pack its prerequisites need, as well as its own gate.
--
--   * Without Space Age, the elite and late tiers list only their own gate,
--     so all of them inherit. Space Exploration re-tiers Krastorio 2's
--     materials and sets its costs in its own data-updates, so this runs
--     after it.
--   * Under Krastorio 2 (with Space Age too), K2's technology for the
--     superior substation keeps K2's cost, but it now follows this mod's
--     substation mk3, so it inherits that tier's packs.
--
-- Numbered pack lines (SE's energy 1-4, material 1-4, ...) list only their
-- highest tier, as the overhaul's own technologies do.
local function ingredient_name(ingredient)
  return ingredient.name or ingredient[1]
end

local gated = {}

if not optional_dependencies.has_space_age
    and (optional_dependencies.has_krastorio2 or optional_dependencies.has_space_exploration) then
  local gate = optional_dependencies.electromagnetic_prerequisite()
  for technology_name, technology in pairs(data.raw.technology) do
    if string.sub(technology_name, 1, 4) == "aeg_" then
      for _, ingredient in pairs(technology.unit and technology.unit.ingredients or {}) do
        if ingredient_name(ingredient) == gate then
          table.insert(gated, technology)
          break
        end
      end
    end
  end
end

local superior_name = optional_dependencies.name("aeg_improved-local-energy-distribution-elite")
local superior = data.raw.technology[superior_name]
if superior and superior.unit and string.sub(superior_name, 1, 4) ~= "aeg_" then
  table.insert(gated, superior)
end

local function collapse(ingredients)
  local highest = {}
  for _, ingredient in pairs(ingredients) do
    local line, tier = string.match(ingredient_name(ingredient), "^(.-)%-(%d+)$")
    if line then
      highest[line] = math.max(highest[line] or 0, tonumber(tier))
    end
  end
  local collapsed = {}
  for _, ingredient in pairs(ingredients) do
    local line, tier = string.match(ingredient_name(ingredient), "^(.-)%-(%d+)$")
    if not line or tonumber(tier) == highest[line] then
      table.insert(collapsed, ingredient)
    end
  end
  return collapsed
end

-- Krastorio 2 with Space Age (not Spaced Out) splits its labs: K2's tech cards
-- go only in the singularity lab, which takes no planetary packs. A pack set no
-- lab accepts would make the technology unresearchable, so a technology whose
-- inherited set would be one keeps its own cost and only the prerequisite.
local function researchable(ingredients)
  for _, lab in pairs(data.raw.lab) do
    local accepts = {}
    for _, input in pairs(lab.inputs or {}) do
      accepts[input] = true
    end
    local all = true
    for _, ingredient in pairs(ingredients) do
      if not accepts[ingredient_name(ingredient)] then
        all = false
        break
      end
    end
    if all then
      return true
    end
  end
  return false
end

local own_cost = {}
for _, technology in pairs(gated) do
  own_cost[technology] = util.table.deepcopy(technology.unit.ingredients)
end

local changed = true
while changed do
  changed = false
  for _, technology in pairs(gated) do
    local seen = {}
    for _, ingredient in pairs(technology.unit.ingredients) do
      seen[ingredient_name(ingredient)] = true
    end
    for _, prerequisite_name in pairs(technology.prerequisites or {}) do
      local prerequisite = data.raw.technology[prerequisite_name]
      for _, ingredient in pairs(prerequisite and prerequisite.unit and prerequisite.unit.ingredients or {}) do
        local pack = ingredient_name(ingredient)
        if not seen[pack] then
          seen[pack] = true
          table.insert(technology.unit.ingredients, { pack, 1 })
          changed = true
        end
      end
    end
  end
end

for _, technology in pairs(gated) do
  local inherited = collapse(technology.unit.ingredients)
  if researchable(inherited) then
    technology.unit.ingredients = inherited
  else
    technology.unit.ingredients = own_cost[technology]
  end
end

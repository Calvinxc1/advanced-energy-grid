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

local function unlocks(technology_name)
  local recipes = {}
  for _, effect in pairs(data.raw.technology[technology_name].effects or {}) do
    if effect.type == "unlock-recipe" then
      table.insert(recipes, effect.recipe)
    end
  end
  return recipes
end

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

-- Every recipe that produces an item, and the technologies that unlock each
-- recipe. Hidden recipes are not a way to make anything: Space Age's
-- recycling recipes, for one, return a lithium-sulfur battery from anything
-- built with one, and recycling comes before electromagnetic science.
local producers, unlockers = {}, {}
for recipe_name, recipe in pairs(data.raw.recipe) do
  for _, result in pairs(not recipe.hidden and recipe.results or {}) do
    if result.name then
      producers[result.name] = producers[result.name] or {}
      table.insert(producers[result.name], recipe_name)
    end
  end
end
for technology_name, technology in pairs(data.raw.technology) do
  for _, effect in pairs(technology.effects or {}) do
    if effect.type == "unlock-recipe" then
      unlockers[effect.recipe] = unlockers[effect.recipe] or {}
      table.insert(unlockers[effect.recipe], technology_name)
    end
  end
end

-- The technology to wait on for an ingredient, or nil when the technology
-- already can make it: some recipe for it is enabled from the start or
-- unlocked by this technology or one it requires, or nothing crafts it at all
-- (a mined resource). Otherwise it is the technology unlocking the recipe
-- named after the item, as overhauls name their main recipe, provided that
-- technology does not itself come after this one.
local function missing_unlock(technology_name, item_name)
  local recipes = producers[item_name]
  if not recipes then
    return nil
  end
  local technology = data.raw.technology[technology_name]
  for _, recipe_name in pairs(recipes) do
    local recipe = data.raw.recipe[recipe_name]
    local unlocked_by = unlockers[recipe_name] or {}
    if #unlocked_by == 0 and recipe.enabled ~= false then
      return nil
    end
    for _, unlocker in pairs(unlocked_by) do
      if unlocker == technology_name or requires(technology, unlocker) then
        return nil
      end
    end
  end
  local main = unlockers[item_name] and unlockers[item_name][1]
  if main and not requires(data.raw.technology[main], technology_name) then
    return main
  end
  return nil
end

-- Each of this mod's technologies waits on whatever unlocks its recipes'
-- ingredients, unless it already does. The base game and Space Age need
-- nothing here; Space Exploration moves electronic circuits off the path to
-- logistic science, and Krastorio 2's rare metals, lithium-sulfur batteries
-- and electronic components come from its own technologies.
for technology_name, technology in pairs(data.raw.technology) do
  if string.sub(technology_name, 1, 4) == "aeg_" then
    for _, recipe_name in pairs(unlocks(technology_name)) do
      local recipe = data.raw.recipe[recipe_name]
      for _, ingredient in pairs(recipe and recipe.ingredients or {}) do
        local unlocker = missing_unlock(technology_name, ingredient.name)
        if unlocker then
          add_prerequisite(technology, unlocker)
        end
      end
    end
  end
end

-- Under an overhaul, a tier never researches for less than what it builds on:
-- it takes every pack its prerequisites need, as well as its own gate.
--
--   * Without Space Age, the late tiers list only their own gate, so all of
--     them inherit. Space Exploration re-tiers Krastorio 2's
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
  local gate = optional_dependencies.late_gate_pack()
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

-- Two subgroups, one per distribution role, so each occupies its own crafting
-- menu row. This matches how the mod already splits itself: the technology
-- branches are named aeg_local-energy-distribution-* and
-- aeg_distance-power-transmission-*, and the README describes the same two
-- paths. Vanilla puts every pole type and every pipe in a single
-- `energy-pipe-distribution` row, which the tiers this mod adds make
-- unreadable.
--
-- The `d-a-*` prefix is reserved for this mod. Vanilla's own subgroup sorts at
-- `d`, so these rows sit immediately after it, and Advanced Fluid
-- Infrastructure takes `d-b-*` for its own families in the same group. Keeping
-- each mod inside its own prefix means the two can never interleave.
--
-- Within a row, position is family then tier: small, medium, substation for
-- local distribution; big then huge for transmission.
data:extend({
  {
    type = "item-subgroup",
    name = "aeg_local-distribution",
    group = "logistics",
    order = "d-a-a",
  },
  {
    type = "item-subgroup",
    name = "aeg_distance-transmission",
    group = "logistics",
    order = "d-a-b",
  },
})

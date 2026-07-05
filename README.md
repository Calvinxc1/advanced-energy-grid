# Advanced Energy Grid

Advanced Energy Grid is a Factorio 2.0 + Space Age mod that owns expanded electric grid infrastructure split out from Advanced Power Infrastructure.

## Scope

This mod owns electric poles, substations, long-distance transmission, electric distribution/transmission technologies, recipes/items/entities for grid infrastructure, and optional Power Overload huge-pole integration.

Advanced Power Infrastructure keeps generation and storage content such as boilers, steam engines, turbines, heat exchangers, heat pipes, reactors, fusion, solar, accumulators, and power footprint benchmarks.

## Implemented

- MK2 small electric pole.
- MK2-MK4 medium electric poles.
- MK2-MK4 big electric poles.
- MK2-MK4 substations.
- Local distribution and distance transmission technology branches.
- Optional Power Overload huge electric pole MK2-MK4 integration.
- Optional Power Overload registration for AEG pole overload limits when the local Power Overload registry API is available.

## Validation

Use:

```bash
./scripts/validate.sh
```

The validator checks JSON, governance YAML when available, Lua syntax, the Factorio mods-folder symlink, and Factorio startup save creation when a Factorio binary is available.

## Future Work

- Investigate proportional Power Overload capacity scaling for AEG poles. The desired behavior is for AEG tiers to preserve their current ratios while deriving from the user's configured Power Overload Tier 1 pole capacities. This currently needs a Power Overload API change because external mods can register startup-setting defaults, but cannot read user-modified startup setting values during settings stage.

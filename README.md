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

The validator checks JSON, governance YAML when available, Lua syntax, the Factorio mods-folder symlink, and Factorio startup save creation when a Factorio binary is available. To require the Factorio load check, run:

```bash
AEG_REQUIRE_FACTORIO=1 ./scripts/validate.sh
```

Pull requests run the same required validation through Gitea Actions in `.gitea/workflows/ci.yml`. The runner must provide a Factorio executable through `FACTORIO_BIN`, `PATH`, or the default Steam install path used by `scripts/factorio-validate.sh`.

## Future Work

- Derive Power Overload capacity defaults from the user's configured Tier 1 pole capacities if Power Overload exposes that data to external mods. AEG currently uses proportional startup defaults based on Power Overload's built-in Tier 1 defaults.

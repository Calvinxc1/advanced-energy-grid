# Advanced Energy Grid

Advanced Energy Grid is a Factorio 2.1 + Space Age mod that makes electric distribution and long-distance transmission part of factory progression.

Vanilla electric poles cover most factory needs very early. This mod adds staged pole, substation, and transmission upgrades so compact early grids grow into deliberate local distribution and long-distance backbone networks.

## Requirements

- Factorio 2.1.
- Space Age.
- Optional Power Overload integration when Power Overload is installed.

## Features

- MK2 small electric pole for early local coverage.
- MK2-MK4 medium electric poles for expanding factory-block distribution.
- MK2-MK4 big electric poles for long-distance transmission.
- MK2-MK4 substations for dense local distribution.
- Split local distribution and distance transmission technology branches.
- Optional Power Overload huge electric pole MK2-MK4 progression.

## Progression Shape

Advanced Energy Grid splits electric infrastructure into local distribution and distance transmission paths:

- Small and medium poles improve early and midgame local factory coverage.
- Big poles expand long-distance transmission without replacing substations as the local coverage tool.
- Substations provide dense late-game factory coverage.
- Power Overload huge poles, when present, become the optional late-game backbone branch.

Advanced Power Infrastructure keeps generation and storage content such as boilers, steam engines, turbines, heat exchangers, heat pipes, reactors, fusion, solar, accumulators, and power footprint benchmarks.

Current pole behavior is documented in [docs/electric-grid-benchmark.md](docs/electric-grid-benchmark.md).

## Compatibility

Power Overload compatibility is currently partial. The published Power Overload release applies overload limits to its built-in Tier 1 poles and fuses. Advanced Energy Grid's higher-tier poles are not registered for overload limits until the upstream Power Overload registry API is available.

## Installation

Install the released mod through the Factorio mod portal when available. Release packages are also attached to repository releases as `{mod-name}_{version}.zip`.

For local development, keep the repository layout intact and run validation from the repository root:

```sh
./scripts/validate.sh
```

Semantic versioning policy is documented in [docs/semantic-versioning.md](docs/semantic-versioning.md).

Release packaging and automated deployment are documented in [docs/release-process.md](docs/release-process.md).

Contribution guidelines are documented in [CONTRIBUTING.md](CONTRIBUTING.md).

## Development Validation

The validator checks JSON, governance YAML when available, Lua syntax, the Factorio mods-folder symlink, and Factorio startup save creation when a Factorio 2.1 binary is available. To require the Factorio load check:

```sh
AEG_REQUIRE_FACTORIO=1 ./scripts/validate.sh
```

Pull requests run the same required validation through Gitea Actions in `.gitea/workflows/ci.yml`. The runner must provide a Factorio executable through `FACTORIO_BIN`, `PATH`, or the default Steam install path used by `scripts/factorio-validate.sh`.

## License

Advanced Energy Grid is released under the [MIT License](LICENSE).

## AI Disclosure

This mod is developed with substantial AI assistance. AI tools have contributed to code implementation, documentation, validation workflow setup, release automation, and generated artwork.

AI-assisted work in this repository is governed through the policy files under `.governance/`. Those policies are intentionally public and are intended to keep AI contributions reviewable, scoped to the task at hand, and aligned with the repository's validation and release process.

## Future Work

- Power Overload registry API integration is deferred until the upstream Power Overload interface is available.

# Advanced Energy Grid

Advanced Energy Grid is a Factorio 2.1 mod that makes electric distribution and long-distance transmission part of factory progression. Space Age is optional; with it, or with Krastorio 2 or Space Exploration, three of the ladders gain a further tier.

Vanilla electric poles cover most factory needs very early. This mod adds staged pole, substation, and transmission upgrades so compact early grids grow into deliberate local distribution and long-distance backbone networks.

## Requirements

- Factorio 2.1.
- Optional Space Age integration, which extends the big pole, substation, and huge pole ladders by one tier.
- Optional Krastorio 2 (including Krastorio 2 Spaced Out) and Space Exploration compatibility.
- Optional Power Overload integration when Power Overload 2.2.0 or newer is installed.

## Features

- MK2 small electric pole for early local coverage.
- MK2-MK4 medium electric poles for expanding factory-block distribution.
- MK2-MK3 big electric poles for long-distance transmission, extended to MK4 under Space Age or an overhaul.
- MK2-MK3 substations for dense local distribution, extended to MK4 under Space Age or an overhaul.
- Split local distribution and distance transmission technology branches.
- Optional Power Overload huge electric pole MK2 progression, extended to MK4 under Space Age or an overhaul.

### Late Tiers

The big pole MK4, substation MK4, and huge pole MK3-MK4 are the late tiers. Under Space Age their recipes call for superconductor, foundation, and quantum processor; under Krastorio 2 or Space Exploration they use that overhaul's materials instead. Without any of these, those tiers do not exist. Every other tier, including the medium pole MK4, is available on base Factorio. Research that would otherwise need electromagnetic science is gated on space science in the base game and energy science 1 under Space Exploration. Krastorio 2 splits that gate in two: the medium pole MK4, substation MK3, and huge pole MK2 follow lithium-sulfur batteries and rare metals, and the big pole MK4 and huge pole MK3-MK4 follow the matter tech card.

## Companion Mods

Advanced Energy Grid is one of three companion mods designed to be played together: this mod for poles, substations, and transmission; Advanced Fluid Infrastructure for pipes and pumps; and Advanced Power Infrastructure for boilers, turbines, reactors, and other generation and storage. Each mod loads and works fine on its own, but the staged progression is designed with all three installed together.

## Progression Shape

Advanced Energy Grid splits electric infrastructure into local distribution and distance transmission paths:

- Small and medium poles improve early and midgame local factory coverage.
- Big poles expand long-distance transmission without replacing substations as the local coverage tool.
- Substations provide dense late-game factory coverage.
- Power Overload huge poles, when present, become the optional late-game backbone branch.

Advanced Power Infrastructure keeps generation and storage content such as boilers, steam engines, turbines, heat exchangers, heat pipes, reactors, fusion, solar, accumulators, and power footprint benchmarks.

Current pole behavior is documented in [docs/electric-grid-benchmark.md](docs/electric-grid-benchmark.md).

## Compatibility

Advanced Energy Grid registers its upgraded electric poles with Power Overload 2.2.0 or newer so they receive configurable overload limits and tooltips. Power Overload remains optional; without it, the AEG pole progression still loads without overload behavior.

### Krastorio 2 and Space Exploration

The mod's reach and coverage numbers carry under an overhaul, while recipes and unlocks follow the overhaul where it has its own:

- Krastorio 2 raises the vanilla poles' reach and coverage; they are set back to the first rung of each ladder, so every tier above them is still an upgrade. K2's recipes for them are kept.
- Krastorio 2's superior substation is the substation MK4. Its recipe takes a substation MK3 in place of a substation, and its technology follows the substation MK3 technology.
- Under Krastorio 2 the mk2 and mk3 tiers are built from K2's own intermediates, one new material per rung: steel beams at mk2, then rare metals, electronic components, and lithium-sulfur batteries at mk3. The late tiers use imersium beams, then the energy control unit, then the AI core. Under Space Exploration they use holmium cable, superconductive cable, heavy composite, and quantum processor. With both, Krastorio 2's materials are used and Space Exploration re-tiers them.
- With Power Overload, which raises its own Tier 1 limits under Krastorio 2, each AEG tier keeps doubling the tier below, starting from the Krastorio 2 Tier 1 limit.

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

Advanced Energy Grid is released under the [GNU General Public License v3.0](LICENSE).

## AI Disclosure

This mod is developed with substantial AI assistance. AI tools have contributed to code implementation, documentation, validation workflow setup, release automation, and generated artwork.

AI-assisted work in this repository is governed through the policy files under `.governance/`. Those policies are intentionally public and are intended to keep AI contributions reviewable, scoped to the task at hand, and aligned with the repository's validation and release process.

## Future Work

- Derive Power Overload capacity defaults from the user's configured Tier 1 pole capacities if Power Overload exposes that data to external mods. AEG currently uses proportional startup defaults based on Power Overload's built-in Tier 1 defaults.

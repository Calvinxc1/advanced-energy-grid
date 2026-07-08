# Electric Grid Benchmark

This benchmark summarizes the electric grid tiers that define local coverage, wire reach, transmission scale, and optional Power Overload integration.

The design goal is to make electric distribution develop over time. Early poles should remain useful but limited, mid-tier poles should support ordinary factory blocks, and late-tier transmission should represent a real investment into long-distance backbone networks.

Assumptions:

- Wire reach is prototype `maximum_wire_distance`.
- Supply area is prototype `supply_area_distance`.
- Values are listed before quality modifiers.
- Advanced Energy Grid keeps vanilla poles available and connects them into upgrade chains.
- The base medium electric pole is adjusted to `11` wire reach by this mod.
- Power Overload huge poles appear only when Power Overload is installed.
- Power Overload overload limits currently apply only to its built-in Tier 1 pole and fuse definitions. Advanced Energy Grid tiers are not registered for overload limits until the upstream registry API is available.

| Pole | Branch | Requires | Wire Reach | Supply Area | Unlock | Primary Role | Power Overload Limit |
|---|---|---|---:|---:|---|---|---|
| Small Electric Pole | starter | base | `7.5` | `2.5` | start | burner-to-electric bootstrap and very compact coverage | Tier 1 limit when Power Overload is installed |
| Small Electric Pole MK2 | local distribution | AEG | `9` | `3.5` | Improved electric poles | early upgraded local coverage | not registered |
| Medium Electric Pole | local distribution | base, adjusted by AEG | `11` | `3.5` | Split energy distribution | first general-purpose distribution pole | Tier 1 limit when Power Overload is installed |
| Medium Electric Pole MK2 | local distribution | AEG | `13` | `4.5` | Local energy distribution 2 | larger midgame factory blocks | not registered |
| Medium Electric Pole MK3 | local distribution | AEG | `15` | `5.5` | Local energy distribution 3 | late surface factory blocks | not registered |
| Medium Electric Pole MK4 | local distribution | AEG | `17` | `6.5` | Local energy distribution 4 | Space Age local distribution | not registered |
| Big Electric Pole | distance transmission | base | `30` | `2` | Split energy distribution | early long-distance power lines | Tier 1 limit when Power Overload is installed |
| Big Electric Pole MK2 | distance transmission | AEG | `38` | `2` | Distance power transmission 2 | midgame transmission lines | not registered |
| Big Electric Pole MK3 | distance transmission | AEG | `44` | `2.25` | Distance power transmission 3 | late surface transmission | not registered |
| Big Electric Pole MK4 | distance transmission | AEG | `50` | `2.5` | Distance power transmission 4 | Space Age transmission | not registered |
| Substation | dense local distribution | base | `18` | `9` | Improved local energy distribution 1 | base dense coverage | Tier 1 limit when Power Overload is installed |
| Substation MK2 | dense local distribution | AEG | `20` | `10` | Improved local energy distribution 2 | improved dense coverage | not registered |
| Substation MK3 | dense local distribution | AEG | `22` | `11` | Improved local energy distribution 3 | late dense coverage | not registered |
| Substation MK4 | dense local distribution | AEG | `24` | `12` | Improved local energy distribution 4 | Space Age dense coverage | not registered |
| Huge Electric Pole | backbone transmission | Power Overload, adjusted by AEG | `40` | `0` | Improved distance power transmission 1 | first huge-pole backbone | Tier 1 limit from Power Overload |
| Huge Electric Pole MK2 | backbone transmission | AEG + Power Overload | `48` | `0` | Improved distance power transmission 2 | upgraded huge-pole backbone | not registered |
| Huge Electric Pole MK3 | backbone transmission | AEG + Power Overload | `56` | `0` | Improved distance power transmission 3 | late huge-pole backbone | not registered |
| Huge Electric Pole MK4 | backbone transmission | AEG + Power Overload | `64` | `0` | Improved distance power transmission 4 | final huge-pole backbone | not registered |

## Branch Reading

| Branch | Entry Point | Progression | Notes |
|---|---|---|---|
| Starter local coverage | Small Electric Pole | Small Electric Pole -> Small Electric Pole MK2 | Gives early factories more coverage before full electric distribution. |
| Local distribution | Medium Electric Pole | Medium Electric Pole -> MK2 -> MK3 -> MK4 | Main factory-block distribution path. |
| Distance transmission | Big Electric Pole | Big Electric Pole -> MK2 -> MK3 -> MK4 | Long-distance power movement without dense local coverage. |
| Dense local distribution | Substation | Substation -> MK2 -> MK3 -> MK4 | High-coverage local distribution for late factory blocks. |
| Backbone transmission | Huge Electric Pole | Huge Electric Pole -> MK2 -> MK3 -> MK4 | Optional Power Overload branch for very long-range transmission. |

## Compatibility Notes

- Space Age is required.
- Power Overload is optional.
- When Power Overload is installed, Advanced Energy Grid adds upgraded huge poles and adjusts the Tier 1 huge pole into the distance transmission branch.
- Power Overload compatibility is partial until the upstream pole registry API is available in a public Power Overload release.

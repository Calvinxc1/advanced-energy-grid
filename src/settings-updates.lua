if mods["PowerOverload"] then
  local ok = pcall(require, "__PowerOverload__/registry")

  if ok and PowerOverload and PowerOverload.register_pole then
    local poles = {
      { name = "aeg_small-electric-pole-2", default = "12MW" },
      { name = "aeg_medium-electric-pole-2", default = "72MW" },
      { name = "aeg_medium-electric-pole-3", default = "84MW" },
      { name = "aeg_medium-electric-pole-4", default = "96MW" },
      { name = "aeg_big-electric-pole-2", default = "360MW" },
      { name = "aeg_big-electric-pole-3", default = "420MW" },
      { name = "aeg_big-electric-pole-4", default = "480MW" },
      { name = "aeg_substation-2", default = "150MW" },
      { name = "aeg_substation-3", default = "175MW" },
      { name = "aeg_substation-4", default = "200MW" },
      { name = "aeg_huge-electric-pole-2", default = "3.6GW" },
      { name = "aeg_huge-electric-pole-3", default = "4.2GW" },
      { name = "aeg_huge-electric-pole-4", default = "4.8GW" },
    }

    for _, pole in pairs(poles) do
      pole.make_fuse = false
      PowerOverload.register_pole(pole)
    end
  else
    log("Advanced Energy Grid could not register Power Overload pole limits; installed Power Overload does not expose __PowerOverload__/registry")
  end
end

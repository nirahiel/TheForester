data:extend(
{
  {
    type = "simple-entity-with-owner",
    name = "sapling",
    icon = "__TheForester__/graphics/icons/sapling.png",
    picture = {
      filename = "__TheForester__/graphics/entities/sapling.png",
      priority = "extra-high",
      width = 32,
      height = 32,
      shift = {0, 0}
    },
    icon_size = 32,
    flags = {"placeable-player", "player-creation", "breaths-air"},
    minable =
    {
      mining_particle = "wooden-particle",
      mining_time = 0.10,
      result = "sapling",
      count = 1
    },
    emissions_per_second = -0.0001,
    max_health = 10,
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.4, -0.4}, {0.4, 0.4}},
    subgroup = "other",
    order = "sapling",
    vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 0.2 },
  }
})

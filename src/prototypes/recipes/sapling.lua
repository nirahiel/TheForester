-- Temporary recipe to turn seeds into saplings by crafting
data:extend(
  {
    {
      type = "recipe",
      name = "sapling-germination",
      ingredients = {{"tree-seed", 1}},
      result = "sapling",
      energy_required = 10
    }
  }
)

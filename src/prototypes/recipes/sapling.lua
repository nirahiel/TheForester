-- Temporary recipe to turn seeds into saplings by crafting
data:extend(
  {
    {
      type = "recipe",
      name = "sapling-germination",
      enabled = "false",
      category = "crafting-with-fluid",
      ingredients = {{"tree-seed", 1}, {type="fluid", name="fertilizer", amount=5}},
      result = "sapling",
      energy_required = 2
    }
  }
)

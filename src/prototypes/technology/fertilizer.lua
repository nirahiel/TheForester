data:extend(
  {
    {
    type = "technology",
    name = "fertilizer",
    icon_size = 128,
    icon = "__TheForester__/graphics/technology/fertilizer.png",
    prerequisites = {"oil-processing"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "fertilizer"
      },
      {
        type = "unlock-recipe",
        recipe = "sapling-germination"
      }
    },
    order = "b-f"
  },
  }
)

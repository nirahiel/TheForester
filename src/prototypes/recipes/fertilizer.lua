data:extend(
{
  {
    type = "recipe",
    name = "fertilizer",
    category = "oil-processing",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {type="fluid", name="water", amount=100},
      {type="fluid", name="crude-oil", amount=1}
    },
    results=
    {
      {type="fluid", name="fertilizer", amount=10}
    },
    icon = "__TheForester__/graphics/icons/fluid/fertilizer.png",
    icon_size = 32,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-b[fertilizer]"
  }
}
)

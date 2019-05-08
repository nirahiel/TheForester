require("lib.functions")

for key, value in pairs(data.raw.tree) do
  if starts_with(key, "tree-") then
    data.raw.tree[key].minable.result = nil
    data.raw.tree[key].minable.count = nil
    data.raw.tree[key].minable.results = {{name = "wood", amount = 4}, {name = "tree-seed", amount = 1}, {name = "tree-seed", amount = 1, probability = 0.25}}
  end
end

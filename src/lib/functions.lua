function starts_with(str, start)
  return str:sub(1, #start) == start
end

local function removeSaplingTimer(sapling)
  for key, data in pairs(global.saplingsLifecycle) do
    if data.sapling == sapling then
      global.saplingsLifecycle[key] = nil
      return
    end
  end
end

function growSapling(sapling)
  if not sapling.valid then
    removeSaplingTimer(sapling)
    return
  end
  local treePosition = sapling.position
  local surface = sapling.surface
  removeSaplingTimer(sapling)
  sapling.destroy{raise_destroy = true}
  surface.create_entity{
    position = treePosition,
    name = "tree-0" .. math.random(1, 9)
  }
end

local function starts_with(str, start)
  return str:sub(1, #start) == start
end

script.on_event({defines.events.on_tick},
   function (e)
      if e.tick % 60 == 0 then
        for key, data in pairs(global.saplingsLifecycle) do
          if not data.sapling.valid then
            global.saplingsLifecycle[key] = nil
            return
          end
          data.lifetime = data.lifetime - 1
          global.saplingsLifecycle[key] = data
          if data.lifetime <= 0 then
            local treePosition = data.sapling.position
            local surface = data.sapling.surface
            data.sapling.destroy({raise_destroy = true})
            global.saplingsLifecycle[key] = nil
            surface.create_entity({
              position = treePosition,
              name = "tree-0" .. math.random(1, 9)
            })
          end
        end
      end
   end
)

script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity},
  function (e)
    if e.created_entity.name == "sapling" then
      --game.connected_players[e.player_index].print("test")
      table.insert(global.saplingsLifecycle, {
        sapling = e.created_entity,
        lifetime = 30 * 60
      })
    end
  end
)

script.on_init(
  function()
    if global.saplingsLifecycle == nil then
      global.saplingsLifecycle = {}
    end
    --[[
    global.treeNames = {}
    for key, value in pairs(data.raw.tree) do
      if starts_with(key, "tree-") then
        data.raw.tree[key].minable.result = nil
        data.raw.tree[key].minable.count = nil
        data.raw.tree[key].minable.results = {{name = "wood", amount = 4}, {name = "tree-seed", amount = 1}, {name = "tree-seed", amount = 1, probability = 0.25}}
      end
    end
    ]]
  end
)

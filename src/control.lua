require("lib.functions")

local scheduler = require("lib.scheduler")
local configchange = require("configchange")

script.on_event({defines.events.on_tick},
  function (e)
    scheduler.on_tick(e.tick)
  end
)

script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity},
  function (e)
    if e.created_entity.name == "sapling" then
      local growth = 30 * 60 * 60 + game.tick --30 minutes * 60 secondes * 60 ticks / seconde
      table.insert(global.saplingsLifecycle, {
        sapling = e.created_entity,
        lifetime = growth
      })
      scheduler.schedule(growth, function(tick)
        growSapling(e.created_entity)
      end)
    end
  end
)

script.on_init(
  function()
    global.saplingsLifecycle = global.saplingsLifecycle or {}
  end
)

script.on_load(
  function()
    -- Restore scheduled operations
    for key, data in pairs(global.saplingsLifecycle) do
      scheduler.schedule(data.lifetime, function(tick)
        growSapling(data.sapling)
      end)
    end
  end
)

script.on_configuration_changed(
  function(e)
    if e.mod_changes.TheForester and e.mod_changes.TheForester.old_version then
      configchange.on_mod_version_changed(e.mod_changes.TheForester.old_version)
    end
  end
)

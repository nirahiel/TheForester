require("lib.functions")

local version = require("lib.version")
local scheduler = require("lib.scheduler")

local module = {}

local all_migrations = {}

local function add_migration(migration)
  all_migrations[#all_migrations + 1] = migration
end

function module.on_mod_version_changed(old_version)
  if old_version == nil then
    --Not doing any migration, the mod was just installed
    return
  end
  old_version = version.parse(old_version)
  for _, migration in ipairs(all_migrations) do
    if version.lowerThan(old_version, migration.version) then
      log("running world migration " .. migration.name)
      migration.task()
    end
  end
end

add_migration{
  name = "v1.1.0 - Update to new seed lifetime format",
  version = {1,1,0},
  task = function()
    for key, data in pairs(global.saplingsLifecycle) do
      if not data.sapling.valid then
        global.saplingsLifecycle[key] = nil
      else
        data.lifetime = data.lifetime * 60 + game.tick --conversion
        global.saplingsLifecycle[key] = data
        scheduler.schedule(data.lifetime, function(tick)
          growSapling(data.sapling)
        end)
      end
    end
  end
}


return module

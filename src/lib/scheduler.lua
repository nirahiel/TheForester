local dheap = require("lib.dheap")

local module = {}

local heap = dheap.new()

function module.on_tick(tick)
  local next_tick, task = heap:peek()
  while next_tick and next_tick <= tick do
    heap:pop()
    task(tick)
    next_tick, task = heap:peek()
  end
end

function module.schedule(tick, f)
  heap:insert(tick, f)
end

return module

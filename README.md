# water-waves-love2d
It is porting and implementation for love2d of water waves from this tutorial https://gamedevelopment.tutsplus.com/tutorials/make-a-splash-with-dynamic-2d-water-effects--gamedev-236

usage:
```Lua
local Water = require "water"

function love.load(arg)
  local color = { 0, 130, 200, 255 }
  water = Water(100, 150, 500, 400, color)
end

function love.update(dt)
  water:update(dt)
end

function love.mousemoved(x, y, dx, dy)
  local weight = 20
  if water:isTouched(x, y, dx, dy) then
    water:splash(x, weight * dy)
  end
end

function love.draw()
  water:draw()
end
```

![Alt Text](https://raw.githubusercontent.com/azoyan/water-waves-love2d/master/water-example.mp4)

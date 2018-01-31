# water-waves-love2d
It is porting and implementation for love2d of water waves from this tutorial https://gamedevelopment.tutsplus.com/tutorials/make-a-splash-with-dynamic-2d-water-effects--gamedev-236

Usage:
```Lua
local Water = require "water"

function love.load(arg)
  local x, y, width, height, color = 100, 150, 500, 400, { 0, 130, 200, 255 }
  water = Water(x, y, width, height, color)
end

function love.update(dt)
  water:update(dt)
end

function love.mousemoved(x, y, dx, dy)
  local weight = 20
  local speed  = weight * dy
  if water:isTouched(x, y, dx, dy) then
    water:splash(x, speed)
  end
end

function love.draw()
  water:draw()
end

```
![GIF](https://raw.githubusercontent.com/azoyan/water-waves-love2d/master/water-example.gif)

![Video](https://raw.githubusercontent.com/azoyan/water-waves-love2d/master/water-example.mp4)

Also you can create water with custom tension, dampening and spread parameters:
 ```Lua
 water = Water(x, y, width, height, color, tension,dampening, spread)
 ```
![GIF](https://raw.githubusercontent.com/azoyan/water-waves-love2d/master/customParameters.gif)

And reset to it:
```Lua
  water:resetTension(0.06)    -- reset to value 0.06
  water:resetDampening()      -- reset to default (0.025)
  water:reset(nil, nil, 0.22) -- reset tension and dampening to defaults and spread to 0.22
  water:reset()               -- reset tension, dampening and spread to defaults parameters
```


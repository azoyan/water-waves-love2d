local Water = require "water"

function love.load(arg)
  local width  = love.graphics.getWidth()
  local height = love.graphics.getHeight()
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

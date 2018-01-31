local Water = {}
Water.__index = Water

setmetatable(Water, {
  __tostring = function(t) return "water" end,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_new(...)
    return self
  end,
})

function Water:_new(x, y, width, height, color, tension, dampening, spread)
  self.x      = x
  self.y      = y
  self.width  = width
  self.height = height

  self.columns = {}
  self.columnsLength = self.width;

  self.color  = color or { 255, 255, 255, 255 }

	self.tension   = tension or 0.025
	self.dampening = dampening or 0.025
	self.spread    = spread or 0.3

  self.vertices = {}
  for i = 1, self.columnsLength do
    table.insert(self.columns, self:createWaterColumn())
  end
end

local function updateWaterColumn(self, index, Dampening, Tension)
  local waterColumn = self.columns[index]
  local x = waterColumn.targetHeight - waterColumn.height;
  waterColumn.speed  = waterColumn.speed + (self.tension * x - waterColumn.speed * self.dampening)
  waterColumn.height = waterColumn.height + waterColumn.speed
	end

  function Water:createWaterColumn()
    return { height = self.height, targetHeight = self.height, speed = 0 }
  end

function Water:resetTension(tension)
  self.tension = tension or 0.025
end

function Water:resetDampening(dampening)
  self.dampening = dampening or 0.025
end

function Water:resetSpread(spread)
  self.spread = spread or 0.3
end

function Water:reset(tension, dampening, spread)
  self:resetTension(tension)
  self:resetDampening(dampening)
  self:resetSpread(spread)
end

function Water:setSpread(spread)
  self.spread = spread or 0.3
end

function Water:splash(x, speed)
  if (x > self.x) and (x < (self.x + #self.columns)) then
	   self.columns[(x - self.x) % #self.columns].speed = -speed
  end
end

function Water:isTouched(x, y, dx, dy)
  return math.abs(y - self.y) < math.abs(dy) and ((x > self.x) and (x < (self.x + #self.columns)))
end

function Water:update(dt)
  for i = 1, self.columnsLength do
    updateWaterColumn(self, i, self.dampening, self.tension);
  end

  local lDeltas = {}
  local rDeltas = {}

-- do some passes where self.columns pull on their neighbours
  for j = 1, 9 do
    for i = 1, self.columnsLength do
      if i > 1 then
        lDeltas[i] = self.spread * (self.columns[i].height - self.columns[i - 1].height);
        self.columns[i - 1].speed = self.columns[i - 1].speed + lDeltas[i];
      end

      if i < self.columnsLength - 1 then
        rDeltas[i] = self.spread * (self.columns[i].height - self.columns[i + 1].height);
        self.columns[i + 1].speed = self.columns[i + 1].speed + rDeltas[i];
      end
    end

    for i = 1, self.columnsLength	do
      if (i > 1) then
        self.columns[i - 1].height = self.columns[i - 1].height + lDeltas[i];
      end
      if (i < self.columnsLength - 1) then
        self.columns[i + 1].height = self.columns[i + 1].height + rDeltas[i]
      end
    end
  end
end

function Water:draw()
  love.graphics.setColor(self.color)
  local bottom = self.y + self.height
  for i = 2, self.columnsLength do
    local p1 = { self.x + (i - 1), bottom - self.columns[i - 1].height }
    local p2 = { self.x + i,       bottom - self.columns[i].height }

    local p3 = { p2[1],    bottom }
    local p4 = { p1[1],    bottom }

    local vertices = {}
    vertices = { p1[1], p1[2], p3[1], p3[2], p2[1], p2[2]
               , p3[1], p3[2], p4[1], p4[2], p2[1], p2[2] }

    love.graphics.polygon('fill', vertices)
  end
end

return Water

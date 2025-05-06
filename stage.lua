-- The background floor for the game. Nothing should ever intersect this.
Stage = Moveable:extend()
function Stage:new()
    local window_w, window_h = love.graphics.getDimensions()
    self.size = {w = window_w, h = window_h/8}
    self.x = 0
    self.y = window_h - self.size.h
end

function Stage:draw()
    love.graphics.setColor(0, .6, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.size.w, self.size.h )
    love.graphics.setColor(1, 1, 1)
end

function Stage:move()
    --make immovable
    return false
end
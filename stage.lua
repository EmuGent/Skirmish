-- The background elements for the game.
Stage = Object:extend()
function Stage:new()
    local window_w, window_h = love.graphics.getDimensions()
    
    self.w = window_w
    self.h = window_h/8
    self.x = 0
    self.y = window_h - self.h
end

function Stage:draw()
    love.graphics.setColor(.6, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h )
    love.graphics.setColor(1, 1, 1)
end
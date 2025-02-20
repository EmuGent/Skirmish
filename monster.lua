
Monster = Moveable:extend()

function Monster:new()
    self.size = {w = 50, h = 50}
    local default = ConvertCoordinateToCorner(DefaultPostion.Monster2, self.size)
    self.y = default.y
    self.x = default.x
end

function Monster:update(dt)

end

function Monster:draw()
    love.graphics.rectangle("line", self.x, self.y, self.size.h, self.size.w )
end
Player = Object:extend()

function Player:new()
    self.size = {w = 50, h = 50}
    local default = ConvertCoordinateToCorner(DefaultPostion.Player, self.size)
    self.y = default.y
    self.x = default.x
    self.attacking = false
end

function Player:update(dt)
    --check if we're currently attacking
    if self.attacking == true then
        self.x = self.x + 500*dt
    end
    -- trigger jump sequence
    function love.keypressed(key, code, isrepeat)
        if key == "space" then
            self.attacking = true
        end
    end


end

function Player:draw()
    love.graphics.rectangle("line", self.x, self.y, self.size.h, self.size.w )
end
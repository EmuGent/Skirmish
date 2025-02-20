Player = Moveable:extend()

function Player:new()
    self.size = {w = 50, h = 50}
    local default = ConvertCoordinateToCorner(DefaultPostion.Player, self.size)
    self.y = default.y
    self.x = default.x
    self.attacking = false
    self.recall = false
    self.vel = 0
    self.mathDebug = false
    self.mathxStart = 0
    self.mathyStart = 0
    self.waittimer = 0
end

function Player:update(dt)
    --check if we're currently attacking
    if self.attacking == true then--and (self.x + self.size.w < Midpoint.x) then
        local newPos = {x = self.x + 500*dt, y = self.y, size = {w = 50, h = 50}}
        if not self.collisionCheck(newPos, SetStage) and not self.collisionCheck(newPos, Monster1) and self.recall == false then
            self.waittimer = 2
            self:move(newPos.x, newPos.y)
        else
            self.recall = true
            self.waittimer = self.waittimer - dt
            if self.waittimer < 0 then
                newPos = {x = self.x - 500*dt, y = self.y, size = {w = 50, h = 50}}
                if not self.collisionCheck(newPos, SetStage) and not self.collisionCheck(newPos, Monster1) and newPos.x > ConvertCoordinateToCorner(DefaultPostion.Player, self.size).x then
                self:move(newPos.x, newPos.y)
                else
                    self.attacking = false
                    self.recall = false
                end
            end
        end
    elseif self.attacking == true then
        self:jump(dt)
        if not self.mathDebug then
            self.mathxStart = self.x
            self.mathyStart = self.y
            self.mathDebug = true
        end
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
    love.graphics.print("Current Y: "..self.y, 400, 300)
    love.graphics.print("Current X: "..self.x, 400, 320)
    love.graphics.print("Jump y: "..self.mathyStart, 400, 340)
    love.graphics.print("Jump x: "..self.mathxStart, 400, 360)
end

function Player:jump(dt)
    
end

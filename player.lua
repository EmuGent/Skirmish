Player = Moveable:extend()

function Player:new()
    self.image = LoadImage("assets/Hero.png")
    self.size = {w = 50, h = 50}
    local default = ConvertCoordinateToCorner(DefaultPostion.Player, self.size)
    self.y = default.y
    self.x = default.x
    self.action = ""
    self.recall = false
    self.waittimer = 0
    self.healthMax = 10
    self.healthCurrent = self.healthMax
end

function Player:update(dt)
    --check the current action
    if self.action == "strike" then -- and (self.x + self.size.w < Midpoint.x) then
        local newPos = {x = self.x + 500*dt, y = self.y, size = {w = 50, h = 50}}
        if not self.collisionCheck(newPos, SetStage) and not self.collisionCheck(newPos, MonsterSelect:getMonster()) and self.recall == false then
            self.waittimer = 2
            self:move(newPos.x, newPos.y)
        else
            self.recall = true
            self.waittimer = self.waittimer - dt
            if self.waittimer < 0 then
                newPos = {x = self.x - 500*dt, y = self.y, size = {w = 50, h = 50}}
                if not self.collisionCheck(newPos, SetStage) and not self.collisionCheck(newPos, MonsterSelect:getMonster()) and newPos.x > ConvertCoordinateToCorner(DefaultPostion.Player, self.size).x then
                self:move(newPos.x, newPos.y)
                else
                    self.action = ""
                    self.recall = false
                end
            end
        end
    elseif self.action == "block" then
        if self.waittimer <= 0 then
            self.waittimer = 5
        end
        self.waittimer = self.waittimer-dt
        if self.waittimer <= 0 then self.action = "" end
    elseif self.action == "run" then
        self.x = self.x - 500*dt
        if self.x < -60 then
            love.event.quit(0)
        end
        --self.action = ""
    end
    
end

function Player:control(key)
    if key == "space" and self.action == "" then
            self.action = ActionSelect.actions[2].command
    end
end

function Player:draw()
    --draws the object
    if self.action == "block" then love.graphics.setColor(.6, .6, 1) 
    else love.graphics.setColor(.6, 1, 1) end
    if Hitboxes then
    love.graphics.rectangle("line", self.x, self.y, self.size.h, self.size.w )
    love.graphics.setColor(1, 1, 1)
    end
    local imgW, imgH  = self.image:getDimensions()
    love.graphics.draw(self.image, self.x, self.y, 0, self.size.w/imgW, self.size.h/imgH)
    --debug information, comment out later
    love.graphics.print("Current Y: "..self.y, 400, 300)
    love.graphics.print("Current X: "..self.x, 400, 320)
    love.graphics.print("Current Action: "..self.action, 400, 340)
end
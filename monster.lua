Monster = Moveable:extend()

function Monster:new(position)
    self.image = LoadImage("assets/Mush.png")
    self.size = {w = 50, h = 50}
    self.currentSlot = position
    local posTable = {
        [1] = DefaultPostion.Monster1,
        [2] = DefaultPostion.Monster2,
        [3] = DefaultPostion.Monster3,
        [4] = DefaultPostion.Monster4
    }
    self.defaultPos = ConvertCoordinateToCorner(posTable[position], self.size)
    self.y = self.defaultPos.y
    self.x = self.defaultPos.x
    self.healthMax = 5
    self.isAlive = false
    if self.isAlive then 
            self.healthCurrent = self.healthMax
    else
            self.healthCurrent = 0
    end
    self.intent = ""
    self.acting = false
    self:randomIntent()
    self.timer = 0
end

function Monster:update(dt)
    if not self.isAlive then return true end
    if self.acting == false then 
    self.acting = true
    self.timer = -1
    end
    if self.intent == "attack" then
    local newPos = {x = self.x - 500*dt, y = self.y, size = {w = 50, h = 50}}
        if not self.collisionCheck(newPos, SetStage) and not self.collisionCheck(newPos, MainPlayer) then
          self:move(newPos.x, newPos.y)
        else 
            if self.timer < 0 then
                self.timer = 2 + dt
                Timer:call(self)
            end
            self.timer = self.timer - dt
            if self.timer <= 0 then 
            MainPlayer:hit() 
            self.intent = "return"
            end
        end
    elseif self.intent == "return" then
        local newPos = {x = self.x + 500*dt, y = self.y, size = {w = 50, h = 50}}
        if not self.collisionCheck(newPos, SetStage) and self.x < self.defaultPos.x then
            self:move(newPos.x, newPos.y)
        else 
            self:move(self.defaultPos.x, self.defaultPos.y)
            self:randomIntent()
            return true
        end
    end
return false
end

function Monster:draw()
    if self.isAlive then
    local imgW, imgH  = self.image:getDimensions()
    love.graphics.draw(self.image, self.x, self.y, 0, self.size.w/imgW, self.size.h/imgH)
    if Hitboxes then
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("line", self.x, self.y, self.size.h, self.size.w )
    love.graphics.setColor(1, 1, 1)
    end
    end
end

function Monster:initialize()
    self.isAlive = true
    self.healthCurrent = self.healthMax
end

function Monster:hit()
    if self.healthCurrent > 0 then
    self.healthCurrent = self.healthCurrent-1
    if self.healthCurrent == 0 then
        self:die()
    end
end
end

function Monster:die()
    self.isAlive = false
    if not MonsterSelect:selectNew() then
                --love.event.quit(0)
    end
end 

function Monster:randomIntent()
    self.intent = "attack"
end
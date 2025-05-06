Monster = Moveable:extend()

function Monster:new(position)
    --Monster needs to load coordinates in accordance to the position the monster occupies.
    self.image = LoadImage("assets/Mush.png")
    self.size = {w = GlobalScale, h = GlobalScale}
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
    self.healthMax = 2
    self.isAlive = false
    if self.isAlive then 
            self.healthCurrent = self.healthMax
    else
            self.healthCurrent = 0
    end
    self.intent = ""
    self:randomIntent()
    self.timer = 0
end

function Monster:update(dt)
    --Checks if it is alive, if not return true.
    --When the monster update function returns true, it moves forward to the next monster in the lineup to act.
    if not self.isAlive then return true end
    --Checks intent, should be attack or return.
    if self.intent == "attack" then
        --moves forward to hit the player
    local newPos = {x = self.x - 500*dt, y = self.y, size = {w = 50, h = 50}}
        if not self.collisionCheck(newPos, SetStage) and not self.collisionCheck(newPos, MainPlayer) then
          self:move(newPos.x, newPos.y)
        else 
            --Calls a random number to scale the timer for some variability.
            if self.timer <= 0 then
                local timeScale = love.math.random(125)
                timeScale = timeScale/100+0.5
                Timer:call(self, timeScale)
                self.timer = 2*timeScale + dt
            end
            self.timer = self.timer - dt
            --attempt to hit the player at end of timer
            if self.timer <= 0 then 
            MainPlayer:hit() 
            self.intent = "return"
            end
        end
    elseif self.intent == "return" then
        --Returns monster to original position
        local newPos = {x = self.x + 500*dt, y = self.y, size = {w = GlobalScale, h = GlobalScale}}
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
    --Renders the mushroom if the monster is alive
    if self.isAlive then
    local imgW, imgH  = self.image:getDimensions()
    if self:collisionCheck(MainPlayer) then love.graphics.setColor(.4, .4, .4) end
    love.graphics.draw(self.image, self.x, self.y, 0, self.size.w/imgW, self.size.h/imgH)
    if Hitboxes then
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("line", self.x, self.y, self.size.h, self.size.w )
    end
    love.graphics.setColor(1, 1, 1)
    end
end

function Monster:initialize()
    --Alives the monster.
    self.isAlive = true
    self.healthCurrent = self.healthMax
end

function Monster:hit()
    --Deals damge to the monster, then checks if it should die.
    if self.healthCurrent > 0 then
    self.healthCurrent = self.healthCurrent-1
    if self.healthCurrent == 0 then
        self:die()
    end
end
end

function Monster:die()
    --Kills the monster, attempts to select a new one. If it fails, sets the global phase to win.
    self.isAlive = false
    if not MonsterSelect:selectNew() then
                GlobalPhase = "win"
    end
end 

function Monster:randomIntent()
    --Currently only sets intent to attack. Allows for implementing more flags for new monster actions.
    self.intent = "attack"
end
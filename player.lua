Player = Moveable:extend()
--Object library I'm using (classic.lua) uses this to extend the object

function Player:new()
    --The new function is called when an object instance is created.
    --I use the object to contain all variables that are inherent to the object so it's functions can use it.

    self.image = LoadImage("assets/Hero.png")
    self.size = {w = GlobalScale, h = GlobalScale}
    self.defaultPos = ConvertCoordinateToCorner(DefaultPostion.Player, self.size)
    self.y = self.defaultPos.y
    self.x = self.defaultPos.x
    self.action = ""
    self.recall = false
    self.waittimer = 0
    self.healthMax = 10
    self.healthCurrent = self.healthMax
    self.isVulnerable = true
end

function Player:update(dt)
    --Check the current action, act upon it.
    --Implemented both a player "action" flag and the GlobalPhase flag to determine what to do and where.
    if self.action == "strike" then
        GlobalPhase = "playerturn"
        --Handles moving the player and dealing damage to the monsters.
        local newPos = {x = self.x + 500*dt, y = self.y, size = self.size}
        if not self.collisionCheck(newPos, SetStage) and not self.collisionCheck(newPos, MonsterSelect:getMonster()) and self.recall == false then
            self.waittimer = 4
            self:move(newPos.x, newPos.y)
        else
            if self.recall == false then Timer:call(self) end
            self.recall = true
            self.waittimer = self.waittimer - dt
            if self.waittimer < 0 then
                newPos = {x = self.x - 500*dt, y = self.y, size = {w = 50, h = 50}}
                if not self.collisionCheck(newPos, SetStage) and newPos.x > ConvertCoordinateToCorner(DefaultPostion.Player, self.size).x then
                self:move(newPos.x, newPos.y)
                else
                    self:move(self.defaultPos.x, self.defaultPos.y)
                    self.action = ""
                    GlobalPhase = "monsterturn"
                    self.recall = false
                end
            end
        end
    elseif self.action == "block" then
        --Prevents the next damage and heals one hp.
        if GlobalPhase == "preturn" then GlobalPhase = "playerturn" end
        self.isVulnerable = false
        self:heal(1)
        if GlobalPhase == "playerturn" then 
            GlobalPhase = "monsterturn" 
            self.action = ""
        end
    elseif self.action == "select" then
    --run action is currently how to quit the game
    elseif self.action == "run" then
        self.x = self.x - 500*dt
        if self.x < -60 then
            love.event.quit(0)
        end
    end
    
end

function Player:control(key)
    --Controlls all the player direct control logic
    if key == "space" and self.action == "" and GlobalPhase == "preturn" then
            self.action = ActionSelect.actions[2].command
    end
    if key == "space" and self.action == "strike" and Timer:isReady() and GlobalPhase == "playerturn" then
        MonsterSelect:getMonster():hit()
    end
    if key == "space" and GlobalPhase == "monsterturn" and Timer:isReady() then
        self.isVulnerable = false
    end
end

function Player:draw()
    --draws the player object
    --if blocking, become blue
    if self.action == "block" or self.isVulnerable == false then love.graphics.setColor(.6, .6, 1) 
    else love.graphics.setColor(1, 1, 1) end
    --Debug render the square around the player
    --Would matter more if the sprite didn't have a white background
    if Hitboxes then
    love.graphics.rectangle("line", self.x, self.y, self.size.h, self.size.w )
    end
    --Render the player inside the player dimensions
    local imgW, imgH  = self.image:getDimensions()
    love.graphics.draw(self.image, self.x, self.y, 0, self.size.w/imgW, self.size.h/imgH)
    love.graphics.setColor(1, 1, 1)
    --Debug information
    if Debug then
    love.graphics.print("GlobalPhase: "..GlobalPhase, 400, 300)
    love.graphics.print("Current X: "..self.x, 400, 320)
    love.graphics.print("Current Action: "..self.action, 400, 340)
    end
end

function Player:hit(n)
    --Reduce the player health if it is able
    if n == nil then n = 1 end
    if self.healthCurrent > 0 and self.isVulnerable then
    self.healthCurrent = self.healthCurrent-1
    else 
        self.isVulnerable = true
    if self.healthCurrent == 0 then
        GlobalPhase = "dead"
    end
end
end

function Player:heal(n)
    --Heal the player
    if n == nil then n = 1 end
    if self.healthCurrent < self.healthMax then
        self.healthCurrent = self.healthCurrent + n
        while self.healthCurrent > self.healthMax do
            self.healthCurrent = self.healthCurrent - 1
        end
    end
end
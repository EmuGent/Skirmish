HealthBar = Moveable:extend()

function HealthBar:new(reference)
    self.obj = reference
    self.x = reference.x
    self.y = reference.y + GlobalScale * 1.3
end

function HealthBar:draw()
        if self.obj.healthCurrent ~= 0 then
        
            love.graphics.setColor(0.2, 0.2, 0.2)
            love.graphics.rectangle("fill", self.x, self.y, GlobalScale, GlobalScale*0.35)
            love.graphics.setColor(0.6, 0.2, 0.2)
            love.graphics.rectangle("fill", self.x+GlobalScale*0.035, self.y+GlobalScale*0.035, GlobalScale*0.925, GlobalScale*0.275)
            love.graphics.setColor(0.8, 0.3, 0.1)
            love.graphics.rectangle("fill", self.x+GlobalScale*0.035, self.y+GlobalScale*0.035, GlobalScale*0.925*self.obj.healthCurrent/self.obj.healthMax, GlobalScale*0.275)
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf("HP: "..self.obj.healthCurrent.." / "..self.obj.healthMax, self.x, self.y+GlobalScale*.1, GlobalScale, "center")
        end
        love.graphics.setColor(1, 1, 1)
end
HealthBar = Moveable:extend()

function HealthBar:new(reference)
    self.obj = reference
    self.x = reference.x
    self.y = reference.y + 100
end

function HealthBar:draw()
        if self.obj.healthCurrent ~= 0 then
        love.graphics.print("HP: "..self.obj.healthCurrent.." / "..self.obj.healthMax, self.x, self.y)
        end
end
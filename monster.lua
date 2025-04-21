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
    local default = ConvertCoordinateToCorner(posTable[position], self.size)
    self.y = default.y
    self.x = default.x
    self.healthMax = 10
    self.isAlive = false
    if self.isAlive then 
            self.healthCurrent = self.healthMax
    else
            self.healthCurrent = 0
    end
end

function Monster:update(dt)

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
BattleChoice = Moveable:extend()
local scaleFactor = 50

function BattleChoice:new(Slot1, Slot2, Slot3, Slot4)
    self.image = LoadImage("assets/Arrow.png")
    if BattleChoice:select(Slot1) then
    elseif BattleChoice:select(Slot2) then
    elseif BattleChoice:select(Slot3) then
    elseif BattleChoice:select(Slot4) then
    else
        self.selected = 1
        self.x = Slot1.x
        self.y = Slot1.y - 100
        self.rendered = false
    end
end

function BattleChoice:select(slot)
    if slot.isAlive then
        self.selected = slot.currentSlot
        self.x = slot.x
        self.y = slot.y - 100
        self.rendered = true
        return true
    else
        return false
    end
end

function BattleChoice:getMonster()
    local monsters = {
        [1] = Monster1,
        [2] = Monster2,
        [3] = Monster3,
        [4] = Monster4
    }
    return monsters[self.selected]
end



function BattleChoice:draw()
    if self.rendered then
        local imgW, imgH = self.image:getDimensions()
        love.graphics.draw(self.image, self.x, self.y, 0, scaleFactor/imgW, scaleFactor/imgH)
    end
end
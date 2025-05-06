BattleChoice = Moveable:extend()
local scaleFactor = GlobalScale

function BattleChoice:new(Mon1, Mon2, Mon3, Mon4)
    --Load an image then attempt to pre-select a monster.
    self.image = LoadImage("assets/Arrow.png")
    if BattleChoice:select(Mon1) then
    elseif BattleChoice:select(Mon2) then
    elseif BattleChoice:select(Mon3) then
    elseif BattleChoice:select(Mon4) then
    else
        self.selected = 1
        self.x = Mon1.x
        self.y = Mon1.y - GlobalScale * 2
        self.rendered = false
    end
end

function BattleChoice:select(mon)
    --Checks the alive state of a monster, switching to it if it is alive.
    if mon.isAlive then
        self.selected = mon.currentSlot
        self.x = mon.x
        self.y = mon.y - GlobalScale * 2
        self.rendered = true
        return true
    else
        return false
    end
end

function BattleChoice:selectNew()
    --Automatically scrolls to the next monster for when the current one dies.
    if AllMonsters[self.selected].isAlive then
        return true
    else
        for i, m in ipairs(AllMonsters) do
            if m.isAlive then 
                self:select(m)
                return true
            end
        end
        return false
    end
end

function BattleChoice:getMonster()
    --returns the monster object selected by the enemyselector.
    local monsters = {
        [1] = Monster1,
        [2] = Monster2,
        [3] = Monster3,
        [4] = Monster4
    }
    return monsters[self.selected]
end

function BattleChoice:control(key)
    --Does the controls for selecting the monster when attempting to attack.
    if MainPlayer.action == "select" then
        if key == "right" then
            for i=1, 4 do
                if self:select(AllMonsters[(self.selected+i-1)%4+1]) then
                    return true
                end
            end
        elseif key == "left" then
            for i=1, 4 do
                if self:select(AllMonsters[(self.selected-i-1)%4+1]) then
                    return true
                end
            end
        elseif key == "space" then
            MainPlayer.action = "strike"
        elseif key == "escape" then
            MainPlayer.action = ""
        end

    end
end

function BattleChoice:draw()
    --Only draw the arrow when selecting a monster
    if self.rendered and GlobalPhase == "preturn" and MainPlayer.action == "select" then
        local imgW, imgH = self.image:getDimensions()
        love.graphics.draw(self.image, self.x, self.y, 0, scaleFactor/imgW, scaleFactor/imgH)
        
        if Debug then love.graphics.print("Selected: "..self.selected, 400, 380) end

    end
end
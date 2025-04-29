Selector = Moveable:extend()
local action = Moveable:extend()


function action:new(text, command, r, g, b)
    self.text = text
    self.r, self.g, self.b = r, g, b
    self.command = command
end

function Selector:new()
    self.actions = {
                    action("Attack", "select", 1, 0, 0),
                    action("Defend", "block", .6, .6, 1), 
                    action("Escape", "run", 1, 1, 0)
                    }
    self.size = {w = 50, h = 50}
    local default = ConvertCoordinateToCorner(DefaultPostion.Player, self.size)
    self.x = default.x
    self.y = default.y
end

function Selector:control(key)
    if GlobalPhase == "preturn" and MainPlayer.action == "" then
    if key == "right" then
            self.actions = {
                self.actions[3],
                self.actions[1],
                self.actions[2]
            }
        elseif key == "left" then
            self.actions = {
                self.actions[2],
                self.actions[3],
                self.actions[1]
            }
        end
    end
end

function Selector:update(dt)
    
end

function Selector:draw()
    local offset = -100
    if GlobalPhase == "preturn" then
    for k, v in ipairs(self.actions) do
        love.graphics.setColor(v.r, v.g, v.b)
        love.graphics.rectangle("fill", self.x+offset, self.y-100, 50, 50)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(v.text, self.x+offset+5, self.y-90)
        offset = offset + 100
    end
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", self.x-5, self.y-105, 60, 60)
    love.graphics.setColor(1, 1, 1)
end
end
Selector = Moveable:extend()
local action = Moveable:extend()
local localScale = GlobalScale*0.8

function action:new(text, command, r, g, b)
    self.text = text
    self.r, self.g, self.b = r, g, b
    self.command = command
end

function Selector:new()
    self.actions = {
                    action("Escape", "run", 1, 1, 0),            
                    action("Attack", "select", 1, 0, 0),
                    action("Defend", "block", .6, .6, 1)
                    }
    self.size = {w = localScale, h = localScale}
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
    local offset = -(localScale*2)
    if GlobalPhase == "preturn" then
    for k, v in ipairs(self.actions) do
        love.graphics.setColor(v.r, v.g, v.b)
        love.graphics.rectangle("fill", self.x+offset, self.y-localScale*2, localScale, localScale)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(v.text, self.x+offset+localScale*.2, self.y-localScale*1.75)
        offset = offset + localScale*2
    end
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", self.x-localScale*0.1, self.y-localScale*2.1, localScale*1.2, localScale*1.2)
    love.graphics.setColor(1, 1, 1)
end
end
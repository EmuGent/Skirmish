Moveable = Object:extend()

function Moveable:new()
    self.size = {w = 0, h = 0}
    self.x = 0
    self.y = 0
end

function Moveable:move(x, y)
    self.x = x
    self.y = y
    return true
end

function Moveable.collisionCheck(a, b)
    local left = {p = b.x, c = a.x}
    local right = {p = b.x+b.size.w, c = a.x+a.size.w}
    local top = {p = b.y, c = a.y}
    local bottom = {p = b.y + b.size.h, c = a.y+a.size.h}
    if right.p > left.c 
    and left.p < right.c
    and bottom.p > top.c
    and top.p < bottom.c then
        return true 
    else
        return false
    end
end
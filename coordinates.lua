-- get the game screen without the bottom stage
local window_w, window_h = love.graphics.getDimensions()
GlobalScale = window_h/10
window_h = window_h - window_h/8


Midpoint = {x = window_w/2, y = window_h}
DefaultPostion = {
    Player = {x = window_w*.2, y = window_h},
    Partner = {x = window_w*.1, y = window_h},
    Monster1 = {x = window_w*.6, y = window_h},
    Monster2 = {x = window_w*.7, y = window_h},
    Monster3 = {x = window_w*.8, y = window_h},
    Monster4 = {x = window_w*.9, y = window_h}
}

function ConvertCoordinateToCorner(coor, size) 
    local topLeftCorner = {x = coor.x - size.w/2, y = coor.y - size.h}
    return topLeftCorner
end


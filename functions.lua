function LoadImage(file) 
    local findFile = love.filesystem.getInfo(file)
    if findFile then
        return love.graphics.newImage(file)
    else
        return false
    end
end
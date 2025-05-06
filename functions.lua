--General function for checking if a file exists then loading it as an image variable.
--DO NOT CALL IN UPDATE OR DRAW FUNCTIONS CAUSES MEMORY LEAK
function LoadImage(file) 
    local findFile = love.filesystem.getInfo(file)
    if findFile then
        return love.graphics.newImage(file)
    else
        return false
    end
end
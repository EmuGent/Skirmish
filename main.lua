-- Alt+L to run the game.

-- Love.load is called once when the game starts. Initialize things here.
function love.load()
 x = 100
end

-- love.update is called next, then love.draw, then back to update. This comprises the game loop.
-- dt stands for delta time, which is the time elapsed since the last love.update in seconds.
function love.update(dt)
print(dt)
    if love.keyboard.isDown("right") then
            x = x+50*dt
    elseif love.keyboard.isDown("left") then
         x = x-50*dt
    end
end

function love.draw()
    love.graphics.rectangle("line", x, 50, 200, 150)
end


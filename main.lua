-- Alt+L to run the game.

-- Love.load is called once when the game starts. Initialize things here.
function love.load()
    --Set window size
    love.window.setMode(1920, 1080, {fullscreen = true})
    --Load all other files
    Object = require "libraries/classic"
    require "moveable"
    require "player"
    require "monster"
    require "stage"
    require "selector"
    require "coordinates"
    
    -- Initialize game objects
    Player1 = Player()
    Monster1 = Monster()
    SetStage = Stage()
    ActionSelect = Selector()
end

-- love.update is called next, then love.draw, then back to update. This comprises the game loop.
-- dt stands for delta time, which is the time elapsed since the last love.update in seconds.
function love.update(dt)
    Player1:update(dt)

    -- quit game if escape is pressed
    if love.keyboard.isDown("escape") then
        love.event.quit(0)
    end
end

--love.draw is the rendering function.
function love.draw()
    SetStage:draw()
    Player1:draw()
    Monster1:draw()
    ActionSelect:draw()
end

function love.keypressed(key, scancode, isrepeat)
    Player1:control(key)
    ActionSelect:control(key)
end


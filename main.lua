-- Alt+L to run the game.

-- Love.load is called once when the game starts. Initialize things here.
function love.load()
    --Set window size
    love.window.setMode(1920, 1080, {fullscreen = true})
    --Enable/Disable Hitboxes
    Hitboxes = true
    --Load all other files
    require "functions"
    Object = require "libraries/classic"
    require "moveable"
    require "player"
    require "monster"
    require "stage"
    require "selector"
    require "coordinates"
    require "health"
    require "enemyselector"
    require "timer"
    
    -- Initialize game objects
    MainPlayer = Player()
    Monster1 = Monster(1)
    Monster2 = Monster(2)
    Monster3 = Monster(3)
    Monster4 = Monster(4)
    AllMonsters = {Monster1, Monster2, Monster3, Monster4}
    SetStage = Stage()
    ActionSelect = Selector()
    PlayerHealthBar = HealthBar(MainPlayer)
    MhpBar = {MHP1 = HealthBar(Monster1), MHP2 = HealthBar(Monster2), MHP3 = HealthBar(Monster3), MHP4 = HealthBar(Monster4)}
    MonsterSelect = BattleChoice(Monster1, Monster2, Monster3, Monster4)
    GlobalPhase = "preturn"
    MonsterTurn = 1

    -- Put all rendered objects in a table
    Drawables = {Monster1, Monster2, Monster3, Monster4, SetStage, ActionSelect, PlayerHealthBar, MhpBar.MHP1, MhpBar.MHP2, MhpBar.MHP3, MhpBar.MHP4, MonsterSelect, Timer, MainPlayer}

    --Alive a monster
    Monster2:initialize()
    Monster3:initialize()
    Monster4:initialize()
    MonsterSelect:select(Monster2)
end

-- love.update is called next, then love.draw, then back to update. This comprises the game loop.
-- dt stands for delta time, which is the time elapsed since the last love.update in seconds.
function love.update(dt)
    MainPlayer:update(dt)
    Timer:update(dt)
    if GlobalPhase == "monsterturn" then 
        if AllMonsters[MonsterTurn]:update(dt) then
            MonsterTurn = MonsterTurn+1
        end
        if MonsterTurn == 5 then 
            GlobalPhase = "preturn" 
            MonsterTurn = 1
        end
    end
    -- quit game if escape is pressed
    if love.keyboard.isDown("escape") then
        love.event.quit(0)
    end
end

--love.draw is the rendering function.
function love.draw()
    for index, value in ipairs(Drawables) do
        value:draw()
    end
end

function love.keypressed(key, scancode, isrepeat)
    MonsterSelect:control(key)
    MainPlayer:control(key)
    ActionSelect:control(key)
end


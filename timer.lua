timerObj = Moveable:extend()


function timerObj:new()
    self.red, self.orange, self.yellow, self.green = LoadImage("assets/TrafficRed.png"), LoadImage("assets/TrafficOrgange.png"), LoadImage("assets/TrafficYellow.png"), LoadImage("assets/TrafficGreen.png")
    self.rendered = false
    self.state = self.red
    self.count = 0
    self.hit = false
end

function timerObj:call(actor)
    self.x = actor.x
    self.y = actor.y - 80
    self.hit = false
    self.state = self.red
    self.count = 0
    self.rendered = true
end

function timerObj:draw()
    if self.rendered then
        love.graphics.draw(self.state, self.x, self.y, 0, 50/128, 50/256)
    end
end

function timerObj:update(dt)
    if self.rendered then self.count = self.count + dt end
    if self.count >= 3 then self.rendered = false 
    elseif self.count >= 1.5 then self.state = self.green
    elseif self.count >= 1.0 then self.state = self.yellow
    elseif self.count >= 0.5 then self.state = self.orange
    end
end

function timerObj:isReady() 
    if self.state == self.green and self.rendered and self.hit == false then
        self.hit = true
        return true
    elseif self.rendered then
        self.hit = true
        return false
    end
end

Timer = timerObj()
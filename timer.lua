local timerObj = Moveable:extend()


function timerObj:new()
    --Load each image into different variables to cycle through.
    self.red, self.orange, self.yellow, self.green = LoadImage("assets/TrafficRed.png"), LoadImage("assets/TrafficOrgange.png"), LoadImage("assets/TrafficYellow.png"), LoadImage("assets/TrafficGreen.png")
    self.rendered = false
    self.state = self.red
    self.count = 0
    self.hit = false
    self.scale = 1
end

function timerObj:call(actor, timescale)
    --"calls" the timer above the actor requesting it, then counts down.
    self.x = actor.x
    self.y = actor.y - GlobalScale*1.6
    self.hit = false
    self.state = self.red
    self.count = 0
    self.rendered = true
    if timescale == nil then timescale = 1 end
    self.scale = timescale
end

function timerObj:draw()
    if self.rendered then
        love.graphics.draw(self.state, self.x, self.y, 0, GlobalScale/128, GlobalScale/256)
    end
end

function timerObj:update(dt)
    --Updates the state of the timer over the course of time.
    if self.rendered then 
        self.count = self.count + dt 
        if self.count >= 3*self.scale then self.rendered = false 
        elseif self.count >= 1.5*self.scale then self.state = self.green
        elseif self.count >= 1.0*self.scale then self.state = self.yellow
        elseif self.count >= 0.5*self.scale then self.state = self.orange
        end
    end
end

function timerObj:isReady() 
    --Uses logic based on the current image to return true/false. Fails if it has been "hit" anytime before it is green.
    if self.state == self.green and self.rendered and self.hit == false then
        self.hit = true
        return true
    elseif self.rendered then
        self.hit = true
        return false
    end
end
--Only need one, global timer to call for each action, so create it at the end of file.
--Allows parent object to be local.
Timer = timerObj()
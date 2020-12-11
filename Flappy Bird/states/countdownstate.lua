CountdownState = Class{__includes = BaseState}

countdowntime = 0.75

function CountdownState:init()
    self.count = 3
    self.timer = 0
end

function CountdownState:update(dt)
    self.timer = self.timer + dt
    if self.timer > countdowntime then
        self.timer = self.timer % countdowntime
        self.count = self.count - 1
        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountdownState:render()
    love.graphics.setColor(223/255, 113/255, 38/255, 255)
    love.graphics.setFont(largeFont)
    love.graphics.printf(tostring(self.count), 0, 100, VIRTUAL_WIDTH, 'center')
end
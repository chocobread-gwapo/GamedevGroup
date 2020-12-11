ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setColor(223/255, 113/255, 38/255, 255)
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Ghostbusted!', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(scoreFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 123, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Hit Enter to Play Again!', 0, 175, VIRTUAL_WIDTH, 'center')
end
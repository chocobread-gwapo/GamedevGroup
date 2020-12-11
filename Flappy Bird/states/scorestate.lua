ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
    self.gold = love.graphics.newImage('gold.png')
    self.silver = love.graphics.newImage('silver.png')
    self.bronze = love.graphics.newImage('bronze.png')
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function ScoreState:render()
    local medal = nil
    local medaltype = nil
    if self.score >= 30 then
        medal = self.gold
        medaltype = 'Gold'
    elseif self.score >= 20 then
        medal = self.silver
        medaltype = 'Silver'
    elseif self.score >= 10 then
        medal = self.bronze
        medaltype = 'Bronze'
    end

    love.graphics.setColor(223/255, 113/255, 38/255, 255)
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Ghostbusted!', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(scoreFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 123, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Hit Enter to Play Again!', 0, 175, VIRTUAL_WIDTH, 'center')

    if medal ~= nil then
        love.graphics.setFont(mediumFont2)
        love.graphics.printf("Congratulations! You've earned a " .. medaltype .. " medal!", 0, 10, virtual_width, 'center')
        love.graphics.draw(medal, virtual_width / 2 - medal:getWidth() / 2, 200)
    end
end
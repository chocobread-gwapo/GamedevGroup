TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()

end

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setColor(223/255, 113/255, 38/255, 255)
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy Ghost!', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Hit Enter', 0, 128, VIRTUAL_WIDTH, 'center')
end
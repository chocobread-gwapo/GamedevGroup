StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle']:play()
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BRICK BALL", 0, vheight / 3, vwidth, 'center')
    love.graphics.setFont(gFonts['medium'])
    if highlighted == 1 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.printf("START", 0, vheight / 2 + 70, vwidth, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    if highlighted == 2 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.printf("HIGH SCORES", 0, vheight / 2 + 90, vwidth, 'center')
    love.graphics.setColor(255, 255, 255, 255)
end
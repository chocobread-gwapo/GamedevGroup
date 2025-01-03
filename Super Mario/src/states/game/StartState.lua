
StartState = Class{__includes = BaseState}

function StartState:init()
    self.mapWidth = 50
    self.map = LevelMaker.generate(self.mapWidth, 10)
    self.background = math.random(3)
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            mapWidth = self.mapWidth,
            score = 0
        })
    end
end

function StartState:render()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    self.map:render()

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Super 50 Bros.', 1, virtual_height / 2 - 40 + 1, virtual_width, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Super 50 Bros.', 0, virtual_height / 2 - 40, virtual_width, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter', 1, virtual_height / 2 + 17, virtual_width, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter', 0, virtual_height / 2 + 16, virtual_width, 'center')
end
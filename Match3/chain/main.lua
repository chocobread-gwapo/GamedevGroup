
push = require 'push'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

MOVEMENT_TIME = 2

function love.load()

    flappySprite = love.graphics.newImage('flappy.png')

    flappyX, flappyY = 0, 0

    baseX, baseY = flappyX, flappyY

    timer = 0

    destinations = {
        [1] = {x = VIRTUAL_WIDTH - flappySprite:getWidth(), y = 0},
        [2] = {x = VIRTUAL_WIDTH - flappySprite:getWidth(), y = VIRTUAL_HEIGHT - flappySprite:getHeight()},
        [3] = {x = 0, y = VIRTUAL_HEIGHT - flappySprite:getHeight()},
        [4] = {x = 0, y = 0}
    }


    for k, destination in pairs(destinations) do
        destination.reached = false
    end

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    timer = math.min(MOVEMENT_TIME, timer + dt)

    for i, destination in ipairs(destinations) do
        if not destination.reached then
            flappyX, flappyY =

            -- flag destination as reached if we've reached the movement time and set the
            -- base point as the new current point
            if timer == MOVEMENT_TIME then
                destination.reached = true
                baseX, baseY = destination.x, destination.y
                timer = 0
            end

            break
        end
    end
end

function love.draw()
    push:start()
    love.graphics.draw(flappySprite, flappyX, flappyY)
    push:finish()
end
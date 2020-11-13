
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFont = love.graphics.newFont('font.TTF', 8)
    scoreFont = love.graphics.newFont('font.TTF', 32)
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1score = 0
    player2score = 0

    player1y = 30
    player2y = VIRTUAL_HEIGHT - 50

end

function love.update(dt)
    --player1
    if love.keyboard.isDown('w') then
        player1y = player1y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then 
        player1y = player1y + PADDLE_SPEED * dt 
    end

    --player2
    if love.keyboard.isDown('up') then
        player2y = player2y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2y = player2y + PADDLE_SPEED * dt
    end

end
function love.keypressed(key)
   
    if key == 'escape' then

        love.event.quit()
    end
end

function love.draw()

    push:apply('start')

    love.graphics.clear(0,0,0,0)
    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 50, VIRTUAL_HEIGHT / 3)
    
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    love.graphics.circle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 6)

    push:apply('end')
end

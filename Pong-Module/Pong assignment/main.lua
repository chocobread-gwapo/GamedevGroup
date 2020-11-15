
push = require 'push'

Class =  require 'class'

require 'Paddle'
require 'Ball'

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

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 -2 VIRTUAL_HEIGHT / 2 -2, 4, 4)

    gameState ='start'
end 

function love.update(dt)
    --player1
    if love.keyboard.isDown('w') then
        player1y = math.max(0, player1y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then 
        player1y = math.min(VIRTUAL_HEIGHT - 20, player1y + PADDLE_SPEED * dt)
    end

    --player2
    if love.keyboard.isDown('up') then
        player2y = math.max(0, player2y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2y = math.min(VIRTUAL_HEIGHT - 20, player2y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ball:update(dt)        
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
   
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            ballx = VIRTUAL_WIDTH / 2 - 2
            bally = VIRTUAL_HEIGHT / 2 - 2
            balldx = math.random(2) == 1 and 100 or -100
            balldy = math.random(-50, 50) * 1.5
        end
    end
end

function love.draw()

    push:apply('start')

    love.graphics.clear(0,0,0,255)
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Playing!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 50, VIRTUAL_HEIGHT / 3)
    
    love.graphics.rectangle('fill', 10, player1y, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2y, 5, 20)

    love.graphics.circle('fill', ballx, bally, 4, 6)

    push:apply('end')
end

push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
    
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.TTF', 8)
    scoreFont = love.graphics.newFont('font.TTF', 32)
    vicoryFont = love.graphics.newFont('font.TTF', 24)
    largeFont = love.graphics.newFont('font.TTF', 20)
    
    love.graphics.setFont(smallFont)

    sounds = {
        ['paddle_hit'] =  love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    }) 

    player1Score = 0
    player2Score = 0

    servingPlayer = 1

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50, 5, 20)
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    player1Role = nil
    player2Role = nil

    ballstartingdx = 0

    winningPlayer = 0

    gameState = 'setup'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if gameState == 'serve' then

        ball.dy = math.random(-50,50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end



    elseif gameState == 'play' then

        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy  < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()

        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4
            
            if ball.dy < 0 then
                ball.dy = math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()

        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end
        
        if ball.x < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1
            sounds['score']:play()
            
            if player2Score >= 10 then
                winningPlayer = 2
                gameState = 'victory'
            else 
                gameState = 'serve'

                ball:reset()
            end   
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1
            sounds['score']:play()
            
            if player1Score >= 10 then
                winningPlayer = 1
                gameState = 'victory'
            else 
                gameState = 'serve'
                
                ball:reset()
            end
        end  
    end

    if player1.computer then
        if ball.dx < 0 and ball.x + ball.width < VIRTUAL_WIDTH + (ball.dx * 0.7) - 15 then
            if ball.y < player1.y then
                player1.dy = -PADDLE_SPEED / 2
            elseif ball.y + ball.height > player1.y + player1.height then
                player1.dy = PADDLE_SPEED / 2
            else
                player1.dy = 0
            end
        else
            player1.dy = 0
        end
    else
        if love.keyboard.isDown('w') then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else
            player1.dy = 0
        end
    end

    if player2.computer then
        if ball.dx > 0 and ball.x > (ball.dx * 0.7) + 15 then
            if ball.y < player2.y then
                player2.dy = -PADDLE_SPEED / 2
            elseif ball.y + ball.height > player2.y + player2.height then
                player2.dy = PADDLE_SPEED / 2
            else
                player2.dy = 0
            end
        else
            player2.dy = 0
        end
    else    
        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit{}

    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'victory' then
            gameState = 'serve'
            ball:reset()
            player1Score = 0
            player2Score = 0

            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        elseif gameState == 'serve' then
            gameState = 'play'
        end

    elseif key == 'backspace' then
        gameState = 'setup'

        player1Role = nil
        player2Role = nil

        ball:reset()

        player1Score = 0
        player2Score = 0

        servingPlayer = 1

    elseif gameState == 'setup' then
        if key == 'w' and not player1Role then
            player1.computer = false
            player1Role = 'Player 1 is a Human'
            if player2Role then
                gameState = 'start'
            end

        elseif key == 's' and not player1Role then
            player1.computer = true
            player1Role = 'Player 1 is a Computer'
            if player2Role then
                gameState = 'start'
            end

        elseif key == 'up' and not player2Role then
            player2.computer = false
            player2Role = 'Player 2 is a Human'
            if player1Role then
                gameState = 'start'
            end

        elseif key == 'down' and not player2Role then
            player2.computer = true
            player2Role = 'Player 2 is a Computer'
            if player1Role then
                gameState = 'start'
            end
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(smallFont)
    
    displayScore()

    if gameState == 'setup' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Please choose your player type!', 0, 24, VIRTUAL_WIDTH, 'center')

        if player1Role then
            love.graphics.printf(player1Role, 0, 50, VIRTUAL_WIDTH / 2, 'center')
        else
            love.graphics.setFont(smallFont)
            love.graphics.printf('W', 0, 90, VIRTUAL_WIDTH / 2, 'center')
            love.graphics.printf('Human', 0, 100, VIRTUAL_WIDTH / 2, 'center')
            love.graphics.printf('S', 0, 150, VIRTUAL_WIDTH / 2, 'center')
            love.graphics.printf('Computer', 0, 160, VIRTUAL_WIDTH / 2, 'center')
            love.graphics.setFont(largeFont)
            love.graphics.printf('Player 1', 0, 50, VIRTUAL_WIDTH / 2, 'center')
        end

        love.graphics.setFont(smallFont)
        if player2Role then
            love.graphics.printf(player2Role, VIRTUAL_WIDTH / 2, 50, VIRTUAL_WIDTH / 2, 'center')
        else
            love.graphics.printf('UP', VIRTUAL_WIDTH / 2, 90, VIRTUAL_WIDTH / 2, 'center')
            love.graphics.printf('Human', VIRTUAL_WIDTH / 2, 100, VIRTUAL_WIDTH / 2, 'center')
            love.graphics.printf('DOWN', VIRTUAL_WIDTH / 2, 150, VIRTUAL_WIDTH / 2, 'center')
            love.graphics.printf('Computer', VIRTUAL_WIDTH / 2, 160, VIRTUAL_WIDTH / 2, 'center')
            love.graphics.setFont(largeFont)
            love.graphics.printf('Player 2', VIRTUAL_WIDTH / 2, 50, VIRTUAL_WIDTH / 2, 'center')
        end

    elseif gameState == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf("Welcome to Pong!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 22, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Backspace to return to player selection!', 0, 35, VIRTUAL_WIDTH, 'center')
        love.graphics.printf(player1Role, 0, 50, VIRTUAL_WIDTH / 2, 'center')
        love.graphics.printf(player2Role, VIRTUAL_WIDTH / 2, 50, VIRTUAL_WIDTH / 2, 'center')
    end

    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')

    elseif gameState == 'play' then

    elseif gameState == 'victory' then
        love.graphics.setFont(vicoryFont)
        love.graphics.printf('CONGRATULATIONS!', 0, 17, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Backspace to return to player selection!', 0, 40, VIRTUAL_WIDTH, 'center')
    end

    player1:render()
    player2:render()
    ball:render()

    displayFPS()

    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)   
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end
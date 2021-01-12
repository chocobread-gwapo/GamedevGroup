--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.locked = params.locked
    self.key = params.key
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.balls = { params.ball }
    self.level = params.level

    self.recoverPoints = params.recoverPoints

    self.balls[1].dx = math.random(-200, 200)
    self.balls[1].dy = math.random(-50, -60)

    self.powerups = {}
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    self.paddle:update(dt)

    for k, ball in pairs(self.balls) do
        ball:update(dt)
    end

    for k, powerup in pairs(self.powerups) do
        powerup:update(dt)
    end

    for k, ball in pairs(self.balls) do
        if ball:collides(self.paddle) then
            ball.y = self.paddle.y - 8
            ball.dy = -ball.dy
      
            if ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
                ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - ball.x))
            
            elseif ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
                ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - ball.x))
            end

            gSounds['paddle-hit']:play()
        end
    end

    for k, brick in pairs(self.bricks) do
        
        for bk, ball in pairs(self.balls) do
          
            if brick.inPlay and ball:collides(brick) then

                brick:hit(self.key)
                
                if not brick.isLocked or not brick.inPlay then
                    self.score = self.score + (brick.tier * 200 + brick.color * 25 + (brick.isLocked and 1 or 0) * 500)
                end

                if not brick.inPlay then
                    local powerup = nil
                    if self:gotPowerup(brick) then
                        powerup = Assignment(9)
                    end

                    if self.locked then
                        if self:gotKey() and not self.key and not self:powerupsContainSkin(10) then
                            powerup = Assignment(10)
                        end
                    end
                    
                    if powerup ~= nil then
                        powerup.x = brick.x + brick.width / 2 - powerup.width / 2
                        powerup.y = brick.y + brick.height
                        table.insert(self.powerups, powerup)
                    end
                    if brick.isLocked then                        
                        self.key = false
                        self.locked = false
                    end
                    
                end

                if self.score > self.recoverPoints then
                
                    self.health = math.min(3, self.health + 1)

                    self.recoverPoints = math.min(100000, self.recoverPoints * 2)

                    gSounds['recover']:play()

                    self.paddle:grow()
                end

                if self:checkVictory() then
                    gSounds['victory']:play()

                    gStateMachine:change('victory', {
                        level = self.level,
                        paddle = self.paddle,
                        health = self.health,
                        score = self.score,
                        highScores = self.highScores,
                        ball = self.balls[1],
                        recoverPoints = self.recoverPoints
                    })
                end

                if ball.x + 2 < brick.x and ball.dx > 0 then

                    ball.dx = -ball.dx
                    ball.x = brick.x - 8
 
                elseif ball.x + 6 > brick.x + brick.width and ball.dx < 0 then
 
                    ball.dx = -ball.dx
                    ball.x = brick.x + 32

                elseif ball.y < brick.y then

                    ball.dy = -ball.dy
                    ball.y = brick.y - 8

                else

                    ball.dy = -ball.dy
                    ball.y = brick.y + 16
                end

                if math.abs(ball.dy) < 150 then
                    ball.dy = ball.dy * 1.02
                end

                break
            end
        end
    end

    for k, powerup in pairs(self.powerups) do
        if powerup:collides(self.paddle) then
            gSounds['confirm']:play()
            
            if powerup.skin == 10 then
                self.key = true
            else
                for i = 0, 1 do
                    local newBall = Ball()
                    newBall.skin = math.random(7)
                    newBall.x = self.paddle.x + self.paddle.width / 2 - newBall.width / 2
                    newBall.y = self.paddle.y - newBall.height
                    newBall.dx = math.random(-200, 200)
                    newBall.dy = math.random(-50, -60)
                    table.insert(self.balls, newBall)
                end
            end
            powerup.inPlay = false
        end
    end

    for k, powerup in pairs(self.powerups) do
        if not powerup.inPlay or powerup.y >= VIRTUAL_HEIGHT then
            table.remove(self.powerups, k)
        end
    end

    for k, ball in pairs(self.balls) do
        if ball.y >= VIRTUAL_HEIGHT then
            table.remove(self.balls, k)
        end
    end

    if #self.balls <= 0 then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            self.paddle:shrink()
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                locked = self.locked,
                key = self.key,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                recoverPoints = self.recoverPoints
            })
        end
    end

    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    self.paddle:render()

    for k, ball in pairs(self.balls) do
        ball:render()
    end
    
    for k, powerup in pairs(self.powerups) do
        powerup:render()
    end

    renderScore(self.score)
    renderHealth(self.health)

    if self.key then
        renderKeyPowerup()
    end

    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
end

function PlayState:gotPowerup(brick)
    local powerupRnd = brick.initTier * 13 + brick.initColor * 8
    return math.random(1,100) <= powerupRnd
end

function PlayState:bricksInPlay()
    local counter = 0
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            counter = counter + 1
        end
    end
    return counter
end

function PlayState:gotKey()
    return math.random(1, self:bricksInPlay()) <= 2
end

function PlayState:powerupsContainSkin(skin)
    for k, powerup in pairs(self.powerups) do
        if powerup.skin == skin then
            return true
        end
    end

    return false
end
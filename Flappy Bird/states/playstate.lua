PlayState = Class{__includes = BaseState}

local randomspawn = math.random() * 1.5 + 1.2

PIPE_SPD = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288
BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    if scrolling then
        self.timer = self.timer + dt

        if self.timer > randomspawn then
            local y = math.max(-PIPE_HEIGHT + 10, 
                math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
            self.lastY = y
            table.insert(self.pipePairs, PipePair(y))
            self.timer = 0
            randomspawn = math.random() * 1.5 + 1.2
        end

        for k, pair in pairs(self.pipePairs) do
            if not pair.scored then
                if pair.x + PIPE_WIDTH < self.bird.x then
                    self.score = self.score + 1
                    pair.scored = true
                    sounds['score']:play()
                end
            end
            pair:update(dt)
        end

        for k, pair in pairs(self.pipePairs) do
            if pair.remove then
                table.remove(self.pipePairs, k)
            end
        end

        self.bird:update(dt)

        for k, pair in pairs(self.pipePairs) do
            for l, pipe in pairs(pair.pipes) do
                if self.bird:collides(pipe) then
                    sounds['grave']:play()
                    sounds['hurt']:play()
                    gStateMachine:change('score', {score = self.score})
                end
            end
        end

        if self.bird.y > VIRTUAL_HEIGHT - 15 then
            sounds['grave']:play()
            sounds['hurt']:play()
            gStateMachine:change('score', {
                score = self.score
            })
        end
    end

    if love.keyboard.wasPressed('p') then
        if scrolling then
            scrolling = false
            sounds['music']:pause()
            sounds['pauseenter']:play()
            sounds['pausemenu']:setLooping(true)
            sounds['pausemenu']:play()
        else
            scrolling = true
            sounds['pauseexit']:play()
            sounds['pausemenu']:stop()
            sounds['music']:play()
        end
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()
    
    love.graphics.setColor(223/255, 113/255, 38/255, 255)
    love.graphics.setFont(mediumFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    if scrolling == false then
        love.graphics.setFont(largeFont)
        love.graphics.printf('PAUSE', 0, 75, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Hit P to continue', 0, 175, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:enter()
    scrolling = true
end

function PlayState:exit()
    scrolling = false
end
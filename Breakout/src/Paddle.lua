Paddle = Class{}

function Paddle:init(skin)
  
    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT - 32
    self.dx = 0
    self.width = 64
    self.height = 16
    self.skin = skin
    self.size = 2
end

function Paddle:update(dt)
  
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)

    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:render()
    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.size + 4 * (self.skin - 1)],
        self.x, self.y)
end

function Paddle:shrink()
    if self.size > 1 then
        self.size = self.size - 1
        self.width = self.width - 32
        self.x = self.x + 16
    end
end

function Paddle:grow()
    if self.size < 4 then
        self.size = self.size + 1
        self.width = self.width + 32
        self.x = self.x - 16
    end
end
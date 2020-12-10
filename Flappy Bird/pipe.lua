Pipe = Class{}

local pipe_img = love.graphics.newImage('pillar.png')
local pipescroll = -60

function Pipe:init()
    self.x = VIRTUAL_WIDTH
    self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)
    self.width = pipe_img:getWidth()
end

function Pipe:update(dt)
    self.x = self.x + pipescroll * dt
end

function Pipe:render()
    love.graphics.draw(pipe_img, math.floor(self.x + 0.5), math.floor(self.y))
end
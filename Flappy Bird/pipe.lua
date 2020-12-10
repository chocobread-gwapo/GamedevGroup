Pipe = Class{}

local pipe_img = love.graphics.newImage('pillar.png')

PIPE_SPD = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

function Pipe:init(orientation, y)
    self.x = VIRTUAL_WIDTH
    self.y = y
    self.width = pipe_img:getWidth()
    self.height = PIPE_HEIGHT
    self.orientation = orientation
end

function Pipe:update(dt)
    
end

function Pipe:render()
    love.graphics.draw(pipe_img, self.x, (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y), 0, 1, self.orientation == 'top' and -1 or 1)
end
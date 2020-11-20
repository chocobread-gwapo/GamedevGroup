Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = 0
    self.dx = 0
end

function Ball:collides(box)
    if self.x > box.x + box.width or box.x > self.x + self.width then
        return false
    end

    if self.y > box.y + box.height or box.y > self.y + self.height then
        return false
    end

    return  true
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = 0
    self.dx = 0
    
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.circle('fill', self.x, self.y, self.width, self.height)
    
end
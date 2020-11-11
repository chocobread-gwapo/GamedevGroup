push = require 'push'

window_width = 1280
window_height = 720
virtual_width = 512
virtual_height = 288

local bg = love.graphics.newImage('background.png')
local grd = love.graphics.newImage('ground.png')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pika Fly!')

    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        vsync = true,
        fullscreen = false,
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

function love.draw()
    push:start()
    
    love.graphics.draw(bg, 0, 0)
    love.graphics.draw(grd, 0, virtual_height - 16)
    
    push:finish()
end
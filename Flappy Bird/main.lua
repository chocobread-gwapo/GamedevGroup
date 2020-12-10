push = require 'push'
Class = require 'class'
require 'Bird'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local background_scroll = 0
local ground = love.graphics.newImage('ground.png')
local ground_scroll = 0
local background_scroll_spd = 30
local ground_scroll_spd = 60
local background_loop_point = 413
local bird = Bird()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Ghost!')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
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

function love.update(dt)
    background_scroll = (background_scroll + background_scroll_spd * dt) % background_loop_point
    ground_scroll = (ground_scroll + ground_scroll_spd * dt) % VIRTUAL_WIDTH
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -background_scroll, 0)
    love.graphics.draw(ground, -ground_scroll, VIRTUAL_HEIGHT - 16)

    bird:render()
    
    push:finish()
end
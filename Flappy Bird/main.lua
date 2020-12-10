push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'
require 'PipePair'

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
local ground_loop_point = 514
local bird = Bird()
local pipePairs = {}
local spawnTimer = 0
local lastY = -PIPE_HEIGHT + math.random(80) + 20
local scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Ghost!')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    if scrolling then
        background_scroll = (background_scroll + background_scroll_spd * dt) % background_loop_point
        ground_scroll = (ground_scroll + ground_scroll_spd * dt) % ground_loop_point

        spawnTimer = spawnTimer + dt
        if spawnTimer > 2 then
            local y = math.max(-PIPE_HEIGHT + 10, math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
            lastY = y
            table.insert(pipePairs, PipePair(y))
            spawnTimer = 0
        end

        bird:update(dt)

        for k, pair in pairs(pipePairs) do
            pair:update(dt)

            for l, pipe in pairs(pair.pipes) do
                if bird:collides(pipe) then
                    scrolling = false
                end
            end

            if pair.x < -PIPE_WIDTH then
                pair.remove = true
            end
        end

        for k, pair in pairs(pipePairs) do
            if pair.remove then
                table.remove(pipePairs, k)
            end
        end
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -background_scroll, 0)

    for k, pair in pairs(pipePairs) do
        pair:render()
    end

    love.graphics.draw(ground, -ground_scroll, VIRTUAL_HEIGHT - 16)

    bird:render()
    
    push:finish()
end
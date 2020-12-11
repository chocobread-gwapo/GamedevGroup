push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'
require 'PipePair'
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'

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

    smallFont = love.graphics.newFont('font.ttf', 20)
    mediumFont = love.graphics.newFont('flappy.ttf', 30)
    flappyFont = love.graphics.newFont('flappy.ttf', 60)
    largeFont = love.graphics.newFont('flappy.ttf', 64)
    scoreFont = love.graphics.newFont('flappy.ttf', 50)
    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['grave'] = love.audio.newSource('grave.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),
        ['music'] = love.audio.newSource('music.wav', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }

    gStateMachine:change('title')

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
    background_scroll = (background_scroll + background_scroll_spd * dt) % background_loop_point
    ground_scroll = (ground_scroll + ground_scroll_spd * dt) % ground_loop_point

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -background_scroll, 0)

    gStateMachine:render()

    love.graphics.draw(ground, -ground_scroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end
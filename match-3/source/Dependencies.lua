
Class = require 'lib/class'

push = require 'lib/push'


Timer = require 'lib/knife.timer'

require 'source/StateMachine'
require 'source/Util'

require 'source/Board'
require 'source/Tile'

require 'source/states/BaseState'
require 'source/states/BeginGameState'
require 'source/states/GameOverState'
require 'source/states/PlayState'
require 'source/states/StartState'

gSounds = {
    ['music'] = love.audio.newSource('sounds/music3.wav','static'),
    ['select'] = love.audio.newSource('sounds/select.wav','static'),
    ['error'] = love.audio.newSource('sounds/error.wav','static'),
    ['match'] = love.audio.newSource('sounds/match.wav','static'),
    ['clock'] = love.audio.newSource('sounds/clock.wav','static'),
    ['game-over'] = love.audio.newSource('sounds/game-over.wav','static'),
    ['next-level'] = love.audio.newSource('sounds/next-level.wav','static')
}

gTextures = {
    ['main'] = love.graphics.newImage('graphics/match3.png'),
    ['background'] = love.graphics.newImage('graphics/background.png')
}

gFrames = {
    
    ['tiles'] = GenerateTileQuads(gTextures['main'])
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}
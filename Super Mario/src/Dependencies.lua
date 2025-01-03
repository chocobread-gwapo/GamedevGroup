
-- libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

-- entity states
require 'src/states/entity/PlayerFallingState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerJumpState'
require 'src/states/entity/PlayerWalkingState'

require 'src/states/entity/snail/SnailChasingState'
require 'src/states/entity/snail/SnailIdleState'
require 'src/states/entity/snail/SnailMovingState'

-- general
require 'src/Animation'
require 'src/Entity'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Player'
require 'src/Snail'
require 'src/Tile'
require 'src/TileMap'


gSounds = {
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['death'] = love.audio.newSource('sounds/death.wav', 'static'),
    ['music'] = love.audio.newSource('sounds/music.wav', 'static'),
    ['powerup-reveal'] = love.audio.newSource('sounds/powerup-reveal.wav', 'static'),
    ['pickup'] = love.audio.newSource('sounds/pickup.wav', 'static'),
    ['empty-block'] = love.audio.newSource('sounds/empty-block.wav', 'static'),
    ['kill'] = love.audio.newSource('sounds/kill.wav', 'static'),
    ['kill2'] = love.audio.newSource('sounds/kill2.wav', 'static')
}

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['toppers'] = love.graphics.newImage('graphics/tile_tops.png'),
    ['bushes'] = love.graphics.newImage('graphics/bushes_and_cacti.png'),
    ['jump-blocks'] = love.graphics.newImage('graphics/jump_blocks.png'),
    ['gems'] = love.graphics.newImage('graphics/gems.png'),
    ['backgrounds'] = love.graphics.newImage('graphics/backgrounds.png'),
    ['pink-alien'] = love.graphics.newImage('graphics/pink_alien.png'),
    ['creatures'] = love.graphics.newImage('graphics/creatures.png'),
    --import the keys_and_locks and flags sprite sheet 
    ['keys-locks'] = love.graphics.newImage('graphics/keys_and_locks.png'),
    ['flags'] = love.graphics.newImage('graphics/flags.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], tile_size, tile_size),
    
    ['toppers'] = GenerateQuads(gTextures['toppers'], tile_size, tile_size),
    
    ['bushes'] = GenerateQuads(gTextures['bushes'], 16, 16),
    ['jump-blocks'] = GenerateQuads(gTextures['jump-blocks'], 16, 16),
    ['gems'] = GenerateQuads(gTextures['gems'], 16, 16),
    ['backgrounds'] = GenerateQuads(gTextures['backgrounds'], 256, 128),
    ['pink-alien'] = GenerateQuads(gTextures['pink-alien'], 16, 20),
    ['creatures'] = GenerateQuads(gTextures['creatures'], 16, 16),
    --generate quads for new sprite sheet
    ['keys-locks'] = GenerateQuads(gTextures['keys-locks'],16 , 16),
    ['flags'] = GenerateQuads(gTextures['flags'],16, 16)
}

gFrames['tilesets'] = GenerateTileSets(gFrames['tiles'], 
    tile_sets_wide, tile_sets_tall, tile_set_width, tile_set_height)

gFrames['toppersets'] = GenerateTileSets(gFrames['toppers'], 
    topper_sets_wide, topper_sets_tall, tile_set_width, tile_set_height)

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}
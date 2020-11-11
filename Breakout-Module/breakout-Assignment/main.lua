require 'src/Dependencies'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())
    love.window.setTitle('Brick Break')

    gFonts = {
        ['fps'] = love.graphics.newFont('fonts/fps.ttf', 10),
        ['small'] = love.graphics.newFont('fonts/font.otf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.otf', 16),
        ['large'] = love.graphics.newFont('fonts/font.otf', 32)
    }
    love.graphics.setFont(gFonts['small'])

    gTextures = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
    }
    
    push:setupScreen(vwidth, vheight, wwidth, wheight, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gSounds = {
        ['paddle'] = love.audio.newSource('sounds/paddle.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall'] = love.audio.newSource('sounds/wall.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['noselect'] = love.audio.newSource('sounds/noselect.wav', 'static'),
        ['brickhit1'] = love.audio.newSource('sounds/brickhit1.wav', 'static'),
        ['brickhit2'] = love.audio.newSource('sounds/brickhit2.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['highscore'] = love.audio.newSource('sounds/highscore.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/music.wav', 'static')
    }

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end
    }
    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    push:apply('start')

    local bgwidth = gTextures['background']:getWidth()
    local bgheight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'], 0, 0, 0, vwidth / (bgwidth - 1), vheight / (bgheight - 1))
    
    gStateMachine:render()
    displayFPS()
    
    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(gFonts['fps'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end
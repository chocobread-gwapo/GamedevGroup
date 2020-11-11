WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	smallfont = love.graphics.newFont('font.ttf', 8)
	scorefont = love.graphics.newFont('font.ttf', 32)
	love.graphics.setFont(smallfont)
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false, resizable = false, vsync = true})
end

function love.draw()
	love.graphics.printf('Pong!', 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center')
end

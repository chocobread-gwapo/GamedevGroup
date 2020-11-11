push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

virtual_width = 1280
virtual_height = 720

paddle_speed = 200

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	smallfont = love.graphics.newFont('font.ttf', 8)
	scorefont = love.graphics.newFont('font.ttf', 32)
	love.graphics.setFont(smallfont)
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false, resizable = false, vsync = true})
	
	player1score = 0
	player2score = 0
	
	player1y = 30
	player2y = virtual_height - 50
end

function love.update(dt)
	if love.keyboard.isDown('w') then 
		player1y = player1y + -paddle_speed * dt
	elseif love.keyboard.isDown('s') then 
		player1y = player1y + paddle_Speed * dt
	end
	
	if love.keyboardisDown('up') then 
		player2y = player2y + -paddle_speed * dt 
	elseif love.keyboardisDown('down') then 
		player2y = player2y + paddle_speed * dt 
	end
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end

function love.draw()
	push:apply('start')
	love.graphics.clear(0,0,0,0)
	love.graphics.setFont(smallfont)
	love.graphics.printf('Hello Pong!', 0, 20, virtual_width, 'center')
	love.graphics.setFont(scorefont)
	love.graphics.print(tostring(player1score), virtual_width / 2 - 50, virtual_height / 3)
	love.graphics.print(tostring(player2score), virtual_width / 2 + 30, virtual_height / 3)
	
	love.graphics.rectangle('fill', 10, player1y, 5, 25)
	love.graphics.rectangle('fill', virtual_width - 10, player2y, 5, 25)
	love.graphics.circle('fill', virtual_width / 2 - 2, virtual_height / 2 - 2, 4, 6)
	
	push:apply('end')
end

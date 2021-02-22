
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camX = 0
    self.camY = 0
    self.background = math.random(3)
    self.backgroundX = 0
    self.gravityOn = true
    self.gravityAmount = 6
end


function PlayState:enter(params)
    self.level = LevelMaker.generate(level_width, 10)  
    self.tileMap = self.level.tileMap
   

    self.player = Player({
        x = 0, y = 0,
        width = 16, height = 20,
        texture = 'pink-alien',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerWalkingState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player, self.gravityAmount) end,
            ['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end
        },
        map = self.tileMap,
        level = self.level,
        
    })
    level_complete = self.level_complete or false
    if params then
        self.player.score = params.score
    end

    self:spawnEnemies()

    self.player:changeState('falling')
end

function PlayState:update(dt)
    Timer.update(dt)

    self.level:clear()

    self.player:update(dt)
    self.level:update(dt)

    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > tile_size * self.tileMap.width - self.player.width then
        self.player.x = tile_size * self.tileMap.width - self.player.width
    end

    self:updateCamera()
end

function PlayState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    
    self.level:render()

    self.player:render()
    love.graphics.pop()
------------------------------------------------
    if self.player.key_obj then
        love.graphics.draw(gTextures[self.player.key_obj.texture], gFrames[self.player.key_obj.texture][self.player.key_obj.frame], 5, 20)
    end

    if self.player.level_complete then 
        self.player:renderlevel_complete()
    end

----------------------------------------------------
    
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print(tostring(self.player.score), 5, 5)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(tostring(self.player.score), 4, 4)
    
end

function PlayState:updateCamera()

    self.camX = math.max(0,
        math.min(tile_size * self.tileMap.width - virtual_width,
        self.player.x - (virtual_width / 2 - 8)))

    
    self.backgroundX = (self.camX / 3) % 256
end


function PlayState:spawnEnemies()
    
    for x = 1, self.tileMap.width do
        local groundFound = false

        for y = 1, self.tileMap.height do
            if not groundFound then
                if self.tileMap.tiles[y][x].id == tile_id_ground then
                    groundFound = true

                    if math.random(20) == 1 then
                        
                        local snail
                        snail = Snail {
                            texture = 'creatures',
                            x = (x - 1) * tile_size,
                            y = (y - 2) * tile_size + 2,
                            width = 16,
                            height = 16,
                            stateMachine = StateMachine {
                                ['idle'] = function() return SnailIdleState(self.tileMap, self.player, snail) end,
                                ['moving'] = function() return SnailMovingState(self.tileMap, self.player, snail) end,
                                ['chasing'] = function() return SnailChasingState(self.tileMap, self.player, snail) end
                            }
                        }
                        snail:changeState('idle', {
                            wait = math.random(5)
                        })

                        table.insert(self.level.entities, snail)
                    end
                end
            end
        end
    end
end
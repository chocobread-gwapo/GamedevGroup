Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.score = def.score or 0
    self.key_obj = nil
    self.level_complete = def.level_complete
    
    if self.level_complete then
        Timer.after(4, function() self.level_complete = false end)
    end
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
end

function Player:renderlevel_complete()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf("Level Complete!!", 0, 5, virtual_width, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf("Level Complete!!", 0, 4, virtual_width - 1, 'center')
end

function Player:checkLeftCollisions(dt)
    local tileTopLeft = self.map:pointToTile(self.x + 1, self.y + 1)
    local tileBottomLeft = self.map:pointToTile(self.x + 1, self.y + self.height - 1)

    if (tileTopLeft and tileBottomLeft) and (tileTopLeft:collidable() or tileBottomLeft:collidable()) then
        self.x = (tileTopLeft.x - 1) * tile_size + tileTopLeft.width - 1
    else
        
        self.y = self.y - 1
        local collidedObjects = self:checkObjectCollisions()
        self.y = self.y + 1

        if #collidedObjects > 0 then
            self.x = self.x + player_walk_speed * dt
        end
    end
end

function Player:checkRightCollisions(dt)
    local tileTopRight = self.map:pointToTile(self.x + self.width - 1, self.y + 1)
    local tileBottomRight = self.map:pointToTile(self.x + self.width - 1, self.y + self.height - 1)

    if (tileTopRight and tileBottomRight) and (tileTopRight:collidable() or tileBottomRight:collidable()) then
        self.x = (tileTopRight.x - 1) * tile_size - self.width
    else
        
        self.y = self.y - 1
        local collidedObjects = self:checkObjectCollisions()
        self.y = self.y + 1

        if #collidedObjects > 0 then
            self.x = self.x - player_walk_speed * dt
        end
    end
end

function Player:checkObjectCollisions()
    local collidedObjects = {}

    for k, object in pairs(self.level.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            elseif object.consumable then
                object.onConsume(self, object)
                table.remove(self.level.objects, k)

            end
        end
    end

    return collidedObjects
end
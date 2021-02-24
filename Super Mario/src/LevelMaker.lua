
LevelMaker = Class{}

function LevelMaker.generate(width, height)
    local tiles = {}
    local entities = {}
    local objects = {}

    local tileID = tile_id_ground

    local ground_height = 6
    local pillar_height = 4

    local topper = true
    local tileset = math.random(20)
    local topperset = math.random(20)

    local key_lock_color = math.random(#keys_locks)
    local flag_post_color = math.random(#flag_posts)

    for x = 1, height do
        table.insert(tiles, {})
    end
    for x = 1, width do 
        local tileID = tile_id_empty

        for y = 1, 6 do
            table.insert(tiles[y],
                Tile(x, y, tileID, nil, tileset, topperset))
        end

-----------------------------------------------------------------------
        if x <= 3 then 
            tileID = tile_id_ground
            for y = 7, height do 
                table.insert(tiles[y],
                    Tile(x, y, tileID, y == 7 and topper or nil, tileset, topperset))
            end
        end 
-----------------------------------------------------------------------------

        if math.random(7) == 1 then
            for y = 7, height do 
                if x == width - 1 and x == width - 2 then
                    tileID = tile_id_ground
                    table.insert(tiles[y],
                Tile(x, y, tileID, nil, tileset, topperset))
                else
                    tileID = tile_id_empty
                table.insert(tiles[y], Tile(x, y, tileID, nil, tileset, topperset))
                end
            end
        else
            tileID = tile_id_ground

            local block_height = 4

            for y = 7, height do 
                table.insert(tiles[y], 
                    Tile(x, y, tileID, y == 7 and topper or nil, tileset, topperset))
            end

            if math.random(8) == 1 then
                block_height = 2 
                
                if math.random(8) == 1 then
                    table.insert(objects,
                        GameObject {
                            texture = 'bushes',
                            x = (x - 1) * tile_size,
                            y = (4 - 1) * tile_size,
                            width = 16,
                            height = 16,

                            frame = bush_ids[math.random(#bush_ids)] + (math.random(4)-1) * 7
                        }
                    )
                end

                tiles[5][x] = Tile(x, 5, tileID, topper, tileset, topperset)
                tiles[6][x] = Tile(x, 6, tileID, nil, tileset, topperset)
                tiles[7][x].topper = nil

            elseif math.random(8) == 1 then
                table.insert(objects,
                    GameObject {
                        texture = 'bushes',
                        x = (x - 1) * tile_size,
                        y = (6 - 1) * tile_size,
                        width = 16 ,
                        height = 16,
                        frame = bush_ids[math.random(#bush_ids)] + (math.random(4) - 1) * 7,
                        collidable = false
                    }
                )
            end

            if math.random(10) == 1 then
                table.insert(objects,
                    GameObject {
                        texture = 'jump-blocks',
                        x = (x - 1) * tile_size,
                        y = (block_height - 1) * tile_size,
                        width = 16,
                        height = 16,
                        frame = math.random(#jump_blocks),
                        collidable = true,
                        hit = false,
                        solid = true,

                        onCollide = function(obj)

                            if not obj.hit then

                               
                                if math.random(5) == 1 then
                                    local gem = GameObject {
                                        texture = 'gems',
                                        x = (x - 1) * tile_size,
                                        y = (block_height - 1) * tile_size - 4,
                                        width = 16,
                                        height = 16,
                                        frame = math.random(#gems),
                                        collidable = true,
                                        consumable = true,
                                        solid = false,

                                        onConsume = function(player, object)
                                            gSounds['pickup']:play()
                                            player.score = player.score + 100
                                        end
                                    }
                                                                
                                    Timer.tween(0.1, {
                                        [gem] = {y = (block_height - 2) * tile_size}
                                    })
                                    gSounds['powerup-reveal']:play()

                                    table.insert(objects, gem)
                                end

                                obj.hit = true
                            end

                            gSounds['empty-block']:play()
                        end
                    }
                )
            end
        end
    end
-----------------------------------------------------------------------
--spawn lock block 

    local spawned = false
    while not spawned do
        local xPos = math.random(1, width - 10)
        if tiles[height][xPos].id == tile_id_ground then
            local block_height
            if tiles[ground_height][xPos].id == tile_id_empty then  
                block_height = ground_height - 1
            elseif tiles[pillar_height][xPos].id == tile_id_empty then
                block_height = pillar_height - 1
            end
            
            local lock = getkey_lock_base(lock_id, block_height, xPos, key_lock_color)

            lock.onCollide = function(player, object)
                if player.key_obj then
                    gSounds['pickup']:play()
                    player.key_obj = nil
                    object.remove = true
                    --spawn flag
                    local flag_objects = getFlag(tiles, objects, width, height, flag_post_color)
                    for k, obj in pairs(flag_objects) do
                        table.insert(objects, obj)
                    end
                else
                    gSounds['empty-block']:play()
                end
            end
            table.insert(objects, GameObject(lock))
            spawned = true

            for k, obj in pairs(objects) do 
                if obj.texture == 'jump-blocks' and obj.x == (xPos - 1) * tile_size then
                    table.remove(objects, k)
                    break
                end
            end
        end
    end

-- spawn key
    spawned = false
    while not spawned do 
        local xPos = math.random(1, width)
        if tiles[height][xPos].id == tile_id_ground then
            local block_height
            if tiles[ground_height][xPos].id == tile_id_empty then
                block_height = ground_height - 2
            elseif tiles[pillar_height][xPos].id == tile_id_empty then
                block_height = pillar_height - 2
            end

            local key = getkey_lock_base(key_id, block_height, xPos, key_lock_color)

    --player gets a key
            key.onConsume = function(player, object)
                gSounds['pickup']:play()
                player.key_obj = object
            end

            table.insert(objects, GameObject(key))
            spawned = true
        end
    end
----------------------------------------------------------------------------
    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(entities, objects, map)
end

--------------------------------------------------------------------------
function getkey_lock_base(key_or_lock, block_height, x, key_lock_color)
    --local yPos = key_or_lock == key_id and block_height + 2 or block_height
    return {
        texture = 'keys-locks',
        x = (x - 1) * tile_size,
        y = (block_height - 2) * tile_size,
        width = 16,
        height = 16,

        collidable = true,
        consumable = true,
        hit = false,
        solid = key_or_lock == lock_id,
        frame = keys_locks[key_lock_color] + key_or_lock
    }
end

function getFlag(tiles, objects, width, height, flag_post_color)
    local flag = {}
    local yPos = 6
    local xPos = -1
-- position of the flag 
    for x = width - 3, 1, -1 do
        if tiles[yPos][x].id == tile_id_empty and tiles[yPos + 1][x].id == tile_id_ground then
            xPos = x
            break
        end
    end
    
    for k, obj in pairs(objects) do 
        if obj.x == (xPos - 1) * tile_size then
            table.remove(objects, k)
        end
    end

    for pole_type = 2, 0, -1 do
        table.insert(flag, generateflag_post(width, flag_post_color, xPos, yPos, pole_type))
        
        if pole_type == 1 then 
            yPos = yPos - 1
            table.insert(flag, generateflag_post(width, flag_post_color, xPos, yPos, pole_type))
            
            yPos = yPos - 1
           table.insert(flag, generateflag_post(width, flag_post_color, xPos, yPos, pole_type))
        end

       yPos = yPos - 1
    end

    table.insert(flag, generateFlag(width, xPos, yPos + 2))
    return flag

end

function generateFlag(width, xPos, yPos)
    local base_frame = flags[math.random(#flags)]
    return GameObject {
        texture = 'flags',
        x = (xPos - 1) * tile_size + 8,
        y = (yPos - 1) * tile_size - 8,
        width = 16,
        height = 16,
        animation = Animation{
            frames = {base_frame, base_frame + 1},
            interval = 0.2
        }
    }
end

function generateflag_post(width, flag_post_color, xPos, yPos, pole_type)
    return GameObject {
        texture = 'flags',
        x = (xPos - 1) * tile_size,
        y = (yPos - 1) * tile_size,
        width = 6,
        height = 16,
        frame = flag_post_color + pole_type * flag_offset,
        collidable = true,
        consumable = true,
        solid = false,

        onConsume = function(player, object)
            gSounds['pickup']:play()
            player.score = player.score + 300 
            gStateMachine:change('play', {
                score = player.score
            })
        end
    }
end






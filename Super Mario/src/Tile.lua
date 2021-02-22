Tile = Class{}

function Tile:init(x, y, id, topper, tileset, topperset)
    self.x = x
    self.y = y

    self.width = tile_size
    self.height = tile_size

    self.id = id
    self.tileset = tileset
    self.topper = topper
    self.topperset = topperset
end


function Tile:collidable(target)
    for k, v in pairs(collidable_tiles) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    love.graphics.draw(gTextures['tiles'], gFrames['tilesets'][self.tileset][self.id],
        (self.x - 1) * tile_size, (self.y - 1) * tile_size)
    
    if self.topper then
        love.graphics.draw(gTextures['toppers'], gFrames['toppersets'][self.topperset][self.id],
            (self.x - 1) * tile_size, (self.y - 1) * tile_size)
    end
end
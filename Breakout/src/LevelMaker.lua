NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3
SOLID = 1           
ALTERNATE = 2       
SKIP = 3            
NONE = 4         

LevelMaker = Class{}

function LevelMaker.createMap(level)
    local levelMap = {}
    local bricks = {}

    local numRows = math.random(1, 5)

    local numCols = math.random(7, 13)
    numCols = numCols % 2 == 0 and (numCols + 1) or numCols

    local highestTier = math.min(3, math.floor(level / 5))

    local highestColor = math.min(5, level % 5 + 3)

    local lockedColPos = 0
    local lockedRowPos = 0
    local locked = math.random(3) == 1
    if locked then
        lockedColPos = math.random(1, numCols)
        lockedRowPos = math.random(1, numRows)
    end

    for y = 1, numRows do
        local skipPattern = math.random(1, 2) == 1 and true or false

        local alternatePattern = math.random(1, 2) == 1 and true or false
        local alternateColor1 = math.random(1, highestColor)
        local alternateColor2 = math.random(1, highestColor)
        local alternateTier1 = math.random(0, highestTier)
        local alternateTier2 = math.random(0, highestTier)
        local skipFlag = math.random(2) == 1 and true or false
        local alternateFlag = math.random(2) == 1 and true or false
        local solidColor = math.random(1, highestColor)
        local solidTier = math.random(0, highestTier)

        for x = 1, numCols do
            if skipPattern and skipFlag then
                skipFlag = not skipFlag
                if x == lockedColPos then
                    lockedColPos = lockedColPos + 1
                end
                goto continue
            else
                skipFlag = not skipFlag
            end

            b = Brick(
 
                (x-1)                  
                * 32                   
                + 8                    
                + (13 - numCols) * 16,  
                
                -- y-coordinate
                y * 16                
            )

  
            if alternatePattern and alternateFlag then
                b.color = alternateColor1
                b.tier = alternateTier1
                alternateFlag = not alternateFlag
            else
                b.color = alternateColor2
                b.tier = alternateTier2
                alternateFlag = not alternateFlag
            end

         
            if not alternatePattern then
                b.color = solidColor
                b.tier = solidTier
            end

            if lockedColPos == x and lockedRowPos == y then
                b.color = 5
                b.tier = 3
                b.lockedPos = 2
                b.isLocked = true
            end

            b.initColor = b.color
            b.initTier = b.tier
            table.insert(bricks, b)
           
            ::continue::
        end
    end 

    if #bricks == 0 then
        return self.createMap(level)
    else
        levelMap.bricks = bricks
        levelMap.locked = locked
        return levelMap
    end
end
Model = require("Model")

Controller= {}
function Controller:new()

    local private = {}
    local public= {}
    private.gameModel = Model:new(10)
    private.field = {{}}
    private.isPossibleToMove = false
    private.Point = 0

    
    function private:inputCommand()
        command = io.read(1)
        
        if command =="m" then
            io.read(1)
            x = io.read(1)
            io.read(1)
            posX = tonumber(x)
            y = io.read(1)
            io.read(1)
            posY = tonumber(y)
            direction = io.read(1)
            io.read(1)
    
            if posX < 0 or posX > private.gameModel.fieldSize-1 or posY < 0 or posY > private.gameModel.fieldSize-1 then
                print("It's out of the field")
                private.Point = private.Point - 10
                print("Point: "..private.Point)
            else 
                local element
                if direction=="u" then
                    if posY == 0 or not private:isCanDoMove(posX, posY, posX, posY-1) then
                        print("You can't move it up")
                        private.Point = private.Point - 10
                        print("Point: "..private.Point)
                    else
                        private.gameModel:move(posX, posY, posX, posY-1)
                        private.isPossibleToMove = false
                    end
    
                elseif direction=="d" then
                    if posY == private.gameModel.fieldSize-1 or not private:isCanDoMove(posX, posY, posX, posY+1) then
                        print("You can't move it down")
                        private.Point = private.Point - 10
                        print("Point: "..private.Point)
                    else
                        private.gameModel:move(posX, posY, posX, posY+1)
                        private.isPossibleToMove = false
                    end
    
                elseif direction=="l" then
                    if posX == 0 or not private:isCanDoMove(posX, posY, posX-1, posY) then
                        print("You can't move it left")
                        private.Point = private.Point - 10
                        print("Point: "..private.Point)
                    else
                        private.gameModel:move(posX, posY, posX-1, posY)
                        private.isPossibleToMove = false
                    end
    
                elseif direction=="r" then
                    if posX == private.gameModel.fieldSize-1 or not private:isCanDoMove(posX, posY, posX+1, posY) then
                        print("You can't move it right")
                        private.Point = private.Point - 10
                        print("Point: "..private.Point)
                    else
                        private.gameModel:move(posX, posY, posX+1, posY)
                        private.isPossibleToMove = false
                    end
                else 
                    print("It's incorrect direction")
                    private.Point = private.Point - 10
                    print("Point: "..private.Point)
                end
            end
            return false
        elseif command == "q" then
            return true
        else
            print("Incorrect command: "..command)
            private.Point = private.Point - 10
            print("Point: "..private.Point)
            return false
        end
    end

    function private:isCanDoMove(fromX, fromY, toX, toY)
        local crystal1 = private.field[fromY][fromX]
        local crystal2 = private.field[toY][toX]
        local count = 0
        if toY>0 and crystal1 == private.field[toY-1][toX] and not(fromY== toY-1 and fromX == toX) then
            count = count +1
            if toY>1 and crystal1 == private.field[toY-2][toX] then
                return true
            end
        end
        if toY < private.gameModel.fieldSize-1 and crystal1 == private.field[toY+1][toX] and not(fromY== toY+1 and fromX == toX) then
            count = count +1
            if toY < private.gameModel.fieldSize-2 and crystal1 == private.field[toY+2][toX] then
                return true
            end
        end
        if count ==2 then
            return true
        else
            count = 0
        end

        if toX>0 and crystal1 == private.field[toY][toX-1] and not(fromY== toY and fromX == toX-1) then
            count = count +1
            if toX>1 and crystal1 == private.field[toY][toX-2] then
                return true
            end
        end
        if toX < private.gameModel.fieldSize-1 and crystal1 == private.field[toY][toX+1] and not(fromY== toY and fromX == toX+1) then
            count = count +1
            if toX < private.gameModel.fieldSize-2 and crystal1 == private.field[toY][toX+2] then
                return true
            end
        end
        if count ==2 then
            return true
        else
            count = 0
        end

        if fromY>0 and crystal2 == private.field[fromY-1][fromX] and not(fromY-1== toY and fromX == toX) then
            count = count +1
            if fromY>1 and crystal2 == private.field[fromY-2][fromX] then
                return true
            end
        end
        if fromY < private.gameModel.fieldSize-1 and crystal2 == private.field[fromY+1][fromX] and not(fromY+1== toY and fromX == toX) then
            count = count +1
            if fromY < private.gameModel.fieldSize-2 and crystal2 == private.field[fromY+2][fromX] then
                return true
            end
        end
        if count ==2 then
            return true
        else
            count = 0
        end

        if fromX>0 and crystal2 == private.field[fromY][fromX-1] and not(fromY== toY and fromX-1 == toX) then
            count = count +1
            if fromX>1 and crystal2 == private.field[fromY][fromX-2] then
                return true
            end
        end
        if fromX < private.gameModel.fieldSize-1 and crystal2 == private.field[fromY][fromX+1] and not(fromY== toY and fromX+1 == toX) then
            count = count +1
            if fromX < private.gameModel.fieldSize-2 and crystal2 == private.field[fromY][fromX+2] then
                return true
            end
        end
        if count ==2 then
            return true
        else
            count = 0
            return false
        end
        
    end  

    function private:checkCombinationAroundPair(firstPosI, firstPosJ, orientation)
        if orientation == "h" then
            if firstPosI > 0 then
                if firstPosJ > 0 and private.field[firstPosI][firstPosJ] == private.field[firstPosI-1][firstPosJ-1] or
                firstPosJ < private.gameModel.fieldSize-1 and private.field[firstPosI][firstPosJ] == private.field[firstPosI-1][firstPosJ+2] then
                    private.isPossibleToMove = true
                    return
                end
            end
            if firstPosI < private.gameModel.fieldSize-1 then
                if firstPosJ > 0 and private.field[firstPosI][firstPosJ] == private.field[firstPosI+1][firstPosJ-1] or
                firstPosJ < private.gameModel.fieldSize-1 and private.field[firstPosI][firstPosJ] == private.field[firstPosI+1][firstPosJ+2] then
                    private.isPossibleToMove = true
                    return
                end
            end
            if firstPosJ+1 < private.gameModel.fieldSize-1 and private.field[firstPosI][firstPosJ] == private.field[firstPosI][firstPosJ+3] or
            firstPosJ-1 > 0 and private.field[firstPosI][firstPosJ] == private.field[firstPosI][firstPosJ-2] then
                private.isPossibleToMove = true
                return
            end

        elseif orientation == "v" then
            if firstPosJ > 0 then
                if firstPosI > 0 and private.field[firstPosI][firstPosJ] == private.field[firstPosI-1][firstPosJ-1] or
                firstPosI < private.gameModel.fieldSize-1 and private.field[firstPosI][firstPosJ] == private.field[firstPosI+2][firstPosJ-1] then
                    private.isPossibleToMove = true
                    return
                end
            end
            if firstPosJ < private.gameModel.fieldSize-1 then
                if firstPosI > 0 and private.field[firstPosI][firstPosJ] == private.field[firstPosI-1][firstPosJ+1] or
                firstPosI < private.gameModel.fieldSize-1 and private.field[firstPosI][firstPosJ] == private.field[firstPosI+2][firstPosJ+1] then
                    private.isPossibleToMove = true
                    return
                end
            end
            if firstPosI+1 < private.gameModel.fieldSize-1 and private.field[firstPosI][firstPosJ] == private.field[firstPosI+3][firstPosJ] or
            firstPosI-1 > 0 and private.field[firstPosI][firstPosJ] == private.field[firstPosI-2][firstPosJ] then
                private.isPossibleToMove = true
                return
            end

        end
    end

    function private:foundCombination()
        local deletedArr = {}
        deletedArr.orientation = nil
        deletedArr.lineNumber = nil
        deletedArr.firstIndex = nil
        deletedArr.lastIndex = nil

        local i = 0
        while i < private.gameModel.fieldSize and deletedArr.orientation == nil do
            local j = 0
            while j < private.gameModel.fieldSize and deletedArr.orientation == nil do
                local count = 0 --number of adjacent same pairs in row or column
                while j+count+1 < private.gameModel.fieldSize and private.field[i][j+count] == private.field[i][j+count+1] do
                    count = count + 1
                    --counting number of adjacent same pair in horizontal row
                end
                if count > 1 then
                    -- if this count = 2 or more, we have 3 or more same adjacent crystals in a row
                    deletedArr.orientation = "horizontal"
                    deletedArr.lineNumber = i
                    deletedArr.firstIndex = j 
                    deletedArr.lastIndex = j+count
                    --after this, loop of found ends and we go to deleting method
                else 
                    if count == 1 and not private.isPossibleToMove then
                        -- checking whether combinations with the founded pair are possible
                        private:checkCombinationAroundPair(i, j, "h")
                    end
                    count = 0
                    while i+count+1 < private.gameModel.fieldSize and private.field[i+count][j] == private.field[i+count+1][j] do
                        count = count + 1
                        --counting number of adjacent same pair in vertical column
                    end
                    if count > 1 then
                        -- if this count = 2 or more, we have 3 or more same adjacent crystals in a column
                        deletedArr.orientation = "vertical"
                        deletedArr.lineNumber = j 
                        deletedArr.firstIndex = i 
                        deletedArr.lastIndex = i+count
                        --after this, loop of found ends and we go to deleting method
                    else
                        if count == 1 and not private.isPossibleToMove then
                            -- checking whether combinations with the founded pair are possible
                            private:checkCombinationAroundPair(i, j, "v")
                        end
                        count = 0
                    end
                end
                j = j + 1
            end
            i = i +1
        end
        if deletedArr.orientation ~= nil then
            private.gameModel:tick(deletedArr.orientation, deletedArr.lineNumber, deletedArr.firstIndex, deletedArr.lastIndex)
            private.Point = private.Point + 80 + (deletedArr.lastIndex - deletedArr.firstIndex)*10
            private.field = private.gameModel:dump()
            print("Point: "..private.Point)
            private.isPossibleToMove = false
            private:foundCombination()
        end
    end

    function public:gameProcess()
        private.gameModel:init()
        local isQuite = false
        while not isQuite do
            while not private.isPossibleToMove do
                private.field = private.gameModel:dump()
                private:foundCombination()
                if private.isPossibleToMove then
                    break
                end
                private.gameModel:mix()
                private.Point = private.Point - 120
                private.field = private.gameModel:dump()
                print("Point: "..private.Point)
            end
            isQuite = private:inputCommand()
        end
    end

    setmetatable(public, self)
    self.__index = self; return public
end

return Controller
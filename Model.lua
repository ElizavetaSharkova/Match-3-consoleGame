Model= {}
function Model:new(size)

    local private = {}
        private.field = {{}}
        private.crystals = {"A", "B", "C", "D", "E", "F"}

    local public= {}
        public.fieldSize = size

    function public:init()
        math.randomseed(os.time())
        math.random(); math.random(); math.random()
        for i = 0, public.fieldSize-1, 1 do
            private.field[i] = {}
           for j = 0, public.fieldSize-1, 1 do
                private.field[i][j] = private.crystals[math.random(1, 6)]
            end  
        end   
    end

    function public:dump()
        io.write("  |")
        for i = 0, public.fieldSize-1, 1 do
            io.write(" "..i)
        end
        print()
        print("-----------------------")
        for i = 0, public.fieldSize-1, 1 do
            io.write(i.." |")
           for j = 0, public.fieldSize-1, 1 do
                io.write(" "..private.field[i][j])
            end
            print()  
        end
        print()
        return private.field    
    end

    function public:mix()
        math.randomseed(os.time())
        math.random(); math.random(); math.random()
        for i = 0, public.fieldSize-1, 1 do
           for j = 0, public.fieldSize-1, 1 do
                local newI = math.random(0, public.fieldSize-1)
                local newJ = math.random(0, public.fieldSize-1)
                public:move(i, j, newI, newJ)
            end  
        end
        print("Crystals in the field were mixed:")   
    end

    function public:move(fromX, fromY, toX, toY)
        local element = private.field[fromY][fromX]
        private.field[fromY][fromX] = private.field[toY][toX]
        private.field[toY][toX] = element
    end

    function public:tick(orientation, lineNumber, firstIndex, lastIndex)
        print("TICK "..orientation.." line #"..lineNumber.." begin from index "..firstIndex.." to index "..lastIndex)
        if orientation == "horizontal" then
            while lineNumber > 0 do
                for j = firstIndex, lastIndex, 1 do
                    private.field[lineNumber][j] = private.field[lineNumber-1][j]
                end
                lineNumber = lineNumber -1
            end
            for j = firstIndex, lastIndex, 1 do
                private.field[lineNumber][j] = private.crystals[math.random(1, 6)]
            end
        elseif orientation == "vertical" then
            while firstIndex > 0 do
                private.field[lastIndex][lineNumber] =  private.field[firstIndex-1][lineNumber]
                lastIndex = lastIndex-1
                firstIndex = firstIndex - 1
            end
            for i = firstIndex, lastIndex, 1 do
                private.field[i][lineNumber] = private.crystals[math.random(1, 6)]
            end

        end

    end

    setmetatable(public, self)
    self.__index = self; return public
end

return Model
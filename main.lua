-- Copyright (c) 2026 ZiggyBloos | ZLIB LICENSE, See LICENSE.txt for details

local conf = require("modules/config")

local start_player = conf.start_player
local currPlayer = start_player

local grid = {
    '1', '2', '3',
    '4', '5', '6',
    '7', '8', '9'
}

local win_combos = {
    {1, 2, 3}, {4, 5, 6}, {7, 8, 9},
    {1, 4, 7}, {2, 5, 8}, {3, 6, 9},
    {1, 5, 9}, {3, 5, 7}
}

local function drawGrid()
    os.execute("clear")
    io.write("Tic Tac Toe!\n\n")
    local currCell = 0
    for i=1, 3 do
        io.write("\n")
        for j=1, 3 do
            currCell = currCell + 1
            io.write("\t"..grid[currCell])
        end
        io.write("\n\n")
    end
end

local function printErr(err)
    drawGrid()
    print(conf.styles.err.."ERROR: "..err..conf.styles.reset)
end

local function stampPlayer(n)
    if currPlayer == 'X' then
        grid[n] = conf.styles.plr_x..currPlayer..conf.styles.reset
    else
        grid[n] = conf.styles.plr_o..currPlayer..conf.styles.reset
    end
end

local function switchPlayer()
    if currPlayer == 'X' then
        currPlayer = 'O'
    else
        currPlayer = 'X'
    end
end

local function reset()
    currPlayer = start_player
    grid = {
        '1', '2', '3',
        '4', '5', '6',
        '7', '8', '9'
    }
    drawGrid()
end

local function getWinner()
    for _, combo in ipairs(win_combos) do
        local a, b, c = combo[1], combo[2], combo[3]

        if grid[a] == grid[b] and grid[b] == grid[c] and type(grid[a]) == "string" then
            return grid[a]:gsub("\27%[[0-9;]*m", "")
        end
    end

    return nil
end

drawGrid()
while true do
    io.write(conf.styles.info.."\nCurrent player: ".. currPlayer.."  |  QUIT with 'quit'  |  RESET with 'reset'"..conf.styles.reset.."\n")

    io.write("Place in (1-9): ")
    local n = io.read()
    local new_n = tonumber(n)

    if new_n ~= nil then
        if new_n >= 1 and new_n <= 9 then
            if tostring(new_n) == grid[new_n] then
                stampPlayer(new_n)
                drawGrid()
                switchPlayer()
            else printErr("Not an empty cell.") end

        else printErr("Enter a number within the range.") end
    else
        if n == "quit" then break
        elseif n == "reset" then reset()
        else printErr("Invalid input.") end
    end

    local winner = getWinner()
    if winner then
        for i = 1, 9 do
            if tonumber(grid[i]) ~= nil then
                grid[i] = "_"
                drawGrid()
            end
        end
        print(conf.styles.win.." "..winner.." wins! "..conf.styles.reset)
    end
end

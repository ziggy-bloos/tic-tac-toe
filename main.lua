local u_os = package.config:sub(1,1)

local conf = require("modules/config")

local start_player = conf.start_player
local curr_player = start_player

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
    if u_os == "/" then
        os.execute("clear")
    elseif u_os == "\\" then
        os.execute("cls")
    end

    io.write("Tic Tac Toe!\n\n")
    local curr_cell = 0
    for i=1, 3 do
        io.write("\n")
        for j=1, 3 do
            curr_cell = curr_cell + 1
            io.write("\t"..grid[curr_cell])
        end
        io.write("\n\n")
    end
end

local function printErr(err)
    drawGrid()
    print(conf.styles.err.."ERROR: "..err..conf.styles.reset)
end

local function stampPlayer(n)
    if curr_player == 'X' then
        grid[n] = conf.styles.plr_x..curr_player..conf.styles.reset
    else
        grid[n] = conf.styles.plr_o..curr_player..conf.styles.reset
    end
end

local function switchPlayer()
    if curr_player == 'X' then
        curr_player = 'O'
    else
        curr_player = 'X'
    end
end

local function reset()
    curr_player = start_player
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
    io.write(conf.styles.info.."\nCurrent player: ".. curr_player.."  |  QUIT with 'quit'  |  RESET with 'reset'"..conf.styles.reset.."\n")

    io.write("Place in (1-9): ")
    local u_input = io.read()
    local n = tonumber(u_input)

    if n ~= nil then
        if n >= 1 and n <= 9 then
            if tostring(n) == grid[n] then
                stampPlayer(n)
                drawGrid()
                switchPlayer()
            else printErr("Not an empty cell.") end

        else printErr("Enter a number within the range.") end
    else
        if u_input == "quit" then break
        elseif u_input == "reset" then reset()
        else printErr("Invalid input.") end
    end

    local winner = getWinner()
    if winner then
        for i = 1, 9 do
            if tonumber(grid[i]) ~= nil then
                grid[i] = "-"
                drawGrid()
            end
        end
        print(conf.styles.win.." "..winner.." wins! "..conf.styles.reset)
    end
end

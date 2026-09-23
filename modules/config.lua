local M = {}

local function getVal(target)
    for line in io.lines("config.txt") do
        if not line:match("^%s*$") and not line:match("^%s*#") then
            local key, value = line:match("^%s*([^=]+)%s*=%s*(.*)%s*$")

            if key and value and key == target then
                return value
            end
        end
    end

    return nil
end

M.styles = {
    reset = "\27[0m",
    err = "\27"..getVal("error_messages"),
    info = "\27"..getVal("info"),
    plr_x = "\27"..getVal("player_X"),
    plr_o = "\27"..getVal("player_Y"),
    win = "\27"..getVal("win_message")
}

M.start_player = getVal("start_player")

return M

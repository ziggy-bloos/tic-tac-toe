# tic-tac-toe
Local multiplayer tic-tac-toe game written in lua.
>[!NOTE]
>This game requires a Lua interpreter to run.

## A few things:
- The game clears your terminal when you run it.
- The grid is limited to 3 columns and 3 rows.
- You can change a few settings using [config.txt](config.txt).
- There is no bot implementation, you just have to play alone or with a friend.
- Tie detection is not implemented. You can restart the match with 'reset'.
- Terminal line wrapping may cause issues, make sure to give this program *at least* **16** lines to run properly.

## Windows:
- There might be some issues with the [`os.execute("clear")`](https://github.com/ziggy-bloos/tic-tac-toe/blob/37c72581bd6d979cb46c9cdd0a22ee65bc5e3c21/main.lua#L27) line. Keep in mind that this program has not been tested on Windows (and likely won't be), so if problems do arise, that line might be worth looking into. You can replace `"clear"` with `"cls"`.

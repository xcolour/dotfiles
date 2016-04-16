local window = require "hs.window"
local hotkey = require "hs.hotkey"

window.animationDuration = 0

hotkey.bind({"alt"}, "0", function()
    local win = window.focusedWindow()
    win:maximize()
end)

hotkey.bind({"alt"}, "left", function()
    local win = window.focusedWindow()
    if win ~= nil then
        win:moveToUnit({x=0, y=0, w=0.5, h=1})
    end
end)

hotkey.bind({"alt"}, "right", function()
    local win = window.focusedWindow()
    if win ~= nil then
        win:moveToUnit({x=0.5, y=0, w=0.5, h=1})
    end
end)

hotkey.bind({"alt"}, "down", function()
    local win = window.focusedWindow()
    if win ~= nil then
        win:moveToUnit({x=0.167, y=0, w=0.666, h=1})
    end
end)

hotkey.bind({"alt"}, "r", function()
    hs.reload()
end)

hotkey.bind({"alt"}, "c", function()
    hs.openConsole()
end)

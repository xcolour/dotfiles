local application = require "mjolnir.application"
local window = require "mjolnir.window"
local hotkey = require "mjolnir.hotkey"
local fnutils = require "mjolnir.fnutils"

hotkey.bind({"alt"}, "0", function()
    local win = window.focusedwindow()
    win:maximize()
end)

hotkey.bind({"alt"}, "left", function()
    local win = window.focusedwindow()
    if win ~= nil then
        win:movetounit({x=0, y=0, w=0.5, h=1})
    end
end)

hotkey.bind({"alt"}, "right", function()
    local win = window.focusedwindow()
    if win ~= nil then
        win:movetounit({x=0.5, y=0, w=0.5, h=1})
    end
end)

hotkey.bind({"alt"}, "down", function()
    local win = window.focusedwindow()
    if win ~= nil then
        win:movetounit({x=0.167, y=0, w=0.666, h=1})
    end
end)

hotkey.bind({"alt"}, "r", function()
    mjolnir:reload()
end)

hotkey.bind({"alt"}, "c", function()
    mjolnir.openconsole()
end)

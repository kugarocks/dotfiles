-- osascript -e 'id of app "Raycast"'
local bundleIds = {
    raycast = "com.raycast.macos",
    cursor = "com.todesktop.230313mzl4w4u92"
}

-- Tap it for escape. Hold it for control
hs.loadSpoon('ControlEscape')
spoon.ControlEscape:setCancelDelay(0.5)
spoon.ControlEscape:start()

-- Cursor
hs.loadSpoon("Cursor")
spoon.Cursor:bindHotkeys({
    moveLeft = {{"cmd"}, "h"},
    moveDown = {{"cmd"}, "j"},
    moveUp = {{"cmd"}, "k"},
    moveRight = {{"cmd"}, "l"},
    moveWordLeft = {{"cmd", "ctrl"}, "h"},
    moveWordRight = {{"cmd", "ctrl"}, "l"},
    deleteChar = {{"cmd"}, "d"},
    deleteWord = {{"cmd"}, "s"},
})
overrideHotKeys = {
    moveLeft = {{"cmd", "ctrl"}, "h"},
    moveRight = {{"cmd", "ctrl"}, "l"},
    moveUp = {{"cmd", "ctrl"}, "k"},
    moveDown = {{"cmd", "ctrl"}, "j"},
    moveWordLeft = false,
    moveWordRight = false,
}
spoon.Cursor:overrideHotKeys({
    [bundleIds.raycast] = overrideHotKeys,
    [bundleIds.cursor] = overrideHotKeys,
})
spoon.Cursor:start()

-- ControlShift
-- $/^: vim works (OH YEAH)
hs.loadSpoon("ControlShift")
spoon.ControlShift:setKeyMapping({
    ["`"] = "~",
    ["1"] = "!",
    ["2"] = "@",
    ["3"] = "#",
    ["4"] = "$",
    ["5"] = "%",
    ["6"] = "^",
    ["7"] = "&",
    ["8"] = "*",
    ["9"] = "(",
    ["0"] = ")",
    ["-"] = "_",
    ["="] = "+",
    ["["] = "{",
    ["]"] = "}",
    ["\\"] = "|",
    [";"] = ":",
    ["'"] = "\"",
    [","] = "<",
    ["."] = ">",
    ["/"] = "?",
})
spoon.ControlShift:start()

-- Ctrl+Enter to Shift+Enter mapping
hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()
    
    if flags.ctrl and keyCode == 36 then
        event:setFlags({shift = true, ctrl = false})
        return false
    end

    -- Ctrl+Cmd+[ and Ctrl+Cmd+] to Shift+Cmd+[ and Shift+Cmd+]
    if flags.ctrl and flags.cmd and (keyCode == 33 or keyCode == 30) then
        print("Remapping brackets combination") 
        event:setFlags({shift = true, cmd = true, ctrl = false})
        return false
    end

    return false
end):start()

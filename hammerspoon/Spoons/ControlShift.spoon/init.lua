--- === ControlShift ===
---
--- Use Ctrl key with number row keys to type their corresponding shift characters.
--- For example: Ctrl+1 types !, Ctrl+2 types @, etc.

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "ControlShift"
obj.version = "1.0"
obj.author = "kugarocks" 
obj.homepage = "https://github.com/kugarocks/hammerspoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal variables
obj.eventTap = nil
obj.hotkeys = {}

-- Key mapping for special characters
obj.keyMapping = {
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
    ["="] = "+"
}

function obj:bindHotkeys(mapping)
    self.hotkeys = mapping
    return self
end

function obj:handleKeyEvent(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()
    local char = hs.keycodes.map[keyCode]
    
    -- Check if ctrl key is pressed
    if flags.ctrl then
        -- Check if it's a mapped key
        if obj.keyMapping[char] then
            -- Directly output the special character instead of simulating keystrokes
            hs.eventtap.keyStrokes(obj.keyMapping[char])
            return true
        end
    end
    
    return false
end

function obj:start()
    if self.eventTap then
        self.eventTap:start()
    else
        self.eventTap = hs.eventtap.new(
            { hs.eventtap.event.types.keyDown },
            function(event) return self:handleKeyEvent(event) end
        )
        self.eventTap:start()
    end
    return self
end

function obj:stop()
    if self.eventTap then
        self.eventTap:stop()
    end
    return self
end

function obj:init()
    return self
end

return obj

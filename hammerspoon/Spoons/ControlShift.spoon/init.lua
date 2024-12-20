--- === ControlShift ===
---
--- Use Ctrl key with keys to type their Shift-modified characters.
--- Keys can be configured using bindHotkeys() function.
---
--- Example usage:
--- ```lua
--- hs.loadSpoon("ControlShift")
--- spoon.ControlShift:bindHotkeys({
---     '1', '2', '3',  -- Will convert Ctrl+1 to Shift+1 (!)
---     '[', ']'        -- Will convert Ctrl+[ to Shift+[ ({)
--- })
--- spoon.ControlShift:start()
--- ```

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "ControlShift"
obj.version = "1.0"
obj.author = "kugarocks" 
obj.homepage = "https://github.com/kugarocks/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal variables
obj.eventTap = nil
obj.hotkeys = {}

-- Set of keys that should be handled
obj.bindHotkeys = {}

-- Key mapping for special characters
obj.keyMapping = {}

-- Internal keycode mapping table
local keyCodeMap = {
    ['`'] = 0x32,
    ['1'] = 0x12,
    ['2'] = 0x13,
    ['3'] = 0x14,
    ['4'] = 0x15,
    ['5'] = 0x17,
    ['6'] = 0x16,
    ['7'] = 0x1A,
    ['8'] = 0x1C,
    ['9'] = 0x19,
    ['0'] = 0x1D,
    ['-'] = 0x1B,
    ['='] = 0x18,
    ['['] = 0x21,
    [']'] = 0x1E,
    ['\\'] = 0x2A,
    [';'] = 0x29,
    ['\''] = 0x27,
    [','] = 0x2B,
    ['.'] = 0x2F,
    ['/'] = 0x2C,
}

function obj:bindHotkeys(keys)
    self.bindHotkeys = {}
    -- Convert user input key names to keycodes
    for _, key in ipairs(keys) do
        local keyCode = keyCodeMap[key]
        if keyCode then
            self.bindHotkeys[keyCode] = true
        end
    end
    return self
end

function obj:handleKeyEvent(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()

    if flags.ctrl and next(flags, next(flags)) == nil then
        if obj.bindHotkeys[keyCode] then
            event:setFlags({shift = true})
            return false
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

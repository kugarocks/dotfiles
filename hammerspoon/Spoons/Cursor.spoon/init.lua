--- === Cursor ===
---
--- Enhanced cursor control with keyboard shortcuts

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Cursor"
obj.version = "1.0"
obj.author = "kugarocks"
obj.homepage = "https://github.com/kugarocks/hammerspoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal variables
obj.eventTap = nil
obj.hotkeys = {}
obj.overrides = {}

-- Key mapping
obj.keyMapping = {
    -- Direction keys
    moveLeft = 0x7B,    -- left arrow
    moveDown = 0x7D,    -- down arrow
    moveUp = 0x7E,      -- up arrow
    moveRight = 0x7C,   -- right arrow
    
    -- Word movement (Option + arrow)
    moveWordLeft = {{"alt"}, 0x7B},   -- Option + left
    moveWordRight = {{"alt"}, 0x7C},  -- Option + right
    
    -- Deletion
    deleteChar = 0x33,  -- delete
    deleteWord = {{"alt"}, 0x33}  -- Option + delete
}

-- Get current application's bundle ID
function obj:getCurrentBundleID()
    local bundleID
    local currentWindow = hs.window.focusedWindow()
    
    if currentWindow then
        local windowApp = currentWindow:application()
        if windowApp then
            bundleID = windowApp:bundleID()
        end
    end
    
    if not bundleID then
        local currentApp = hs.application.frontmostApplication()
        bundleID = currentApp:bundleID()
    end
    
    return bundleID
end

function obj:bindHotkeys(mapping)
    self.hotkeys = mapping
    return self
end

function obj:overrideHotKeys(mapping)
    self.overrides = mapping
    return self
end

function obj:checkModifiers(flags, mods)
    for _, mod in ipairs(mods) do
        if not flags[mod] then
            return false
        end
    end
    
    for mod, _ in pairs(flags) do
        local isRequired = false
        for _, requiredMod in ipairs(mods) do
            if mod == requiredMod then
                isRequired = true
                break
            end
        end
        if not isRequired then
            return false
        end
    end
    
    return true
end

function obj:getHotkeyConfig(action, bundleID)
    local overrideConfig = self.overrides[bundleID]
    
    -- If no override config exists for this app, use default
    if not overrideConfig then
        return self.hotkeys[action]
    end
    
    -- If action is explicitly set to false, disable it
    if overrideConfig[action] == false then
        return nil
    end
    
    -- If override config exists for this action, use it
    if overrideConfig[action] then
        return overrideConfig[action]
    end
    
    -- If no override for this action, fall back to default
    return self.hotkeys[action]
end

function obj:handleKeyEvent(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()
    local isKeyDown = event:getType() == hs.eventtap.event.types.keyDown
    local bundleID = self:getCurrentBundleID()
    
    -- Handle all actions
    for action, mapping in pairs(self.hotkeys) do
        local hotkeyConfig = self:getHotkeyConfig(action, bundleID)
        
        if hotkeyConfig then
            local mods = hotkeyConfig[1]
            local key = hotkeyConfig[2]
            
            if keyCode == hs.keycodes.map[key] and self:checkModifiers(flags, mods) then
                local targetKey
                local targetMods = {}
                
                -- Determine target key and modifiers based on action
                if action == "moveWordLeft" then
                    targetKey = "left"
                    targetMods = {"alt"}
                elseif action == "moveWordRight" then
                    targetKey = "right"
                    targetMods = {"alt"}
                elseif action == "deleteChar" then
                    targetKey = "delete"
                    targetMods = {}
                elseif action == "deleteWord" then
                    targetKey = "delete"
                    targetMods = {"alt"}
                else
                    -- Direction keys
                    targetKey = self.keyMapping[action]
                end
                
                -- Create and post the event
                if type(targetKey) == "number" then
                    -- For arrow keys using key codes
                    local newEvent = hs.eventtap.event.newKeyEvent(targetMods, targetKey, isKeyDown)
                    newEvent:post()
                else
                    -- For other keys using key names
                    local newEvent = hs.eventtap.event.newKeyEvent(targetMods, targetKey, isKeyDown)
                    newEvent:post()
                end
                
                return true
            end
        end
    end
    
    return false
end

function obj:start()
    if self.eventTap then
        self.eventTap:start()
    else
        self.eventTap = hs.eventtap.new(
            { hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp },
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

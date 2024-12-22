--- === AppActivator ===
---
--- A Spoon that allows you to activate/focus applications using their own hotkeys.
--- When the configured hotkey is pressed while its corresponding app is focused,
--- it will bring that app to front.

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "AppActivator"
obj.version = "1.0"
obj.author = "kugarocks"
obj.homepage = "https://github.com/kugarocks/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal variables
obj.eventTap = nil
obj.hotkeyToBundleIDMap = {}

-- Generate a unique key for modifier+key combination
-- If there's only one modifier, return it directly with the key
-- If there are multiple modifiers, sort them first to ensure consistent matching
function obj:_generateMapKey(modifiers, key)
    -- Skip sorting if there's only one modifier
    if #modifiers == 1 then
        return modifiers[1] .. "+" .. key
    end
    
    -- Sort modifiers only when there are multiple
    local mods = {}
    for _, mod in ipairs(modifiers) do
        table.insert(mods, mod)
    end
    table.sort(mods)
    return table.concat(mods, "+") .. "+" .. key
end

--- AppActivator:bindHotkeys(ids)
--- Method
--- Configures hotkey to bundle ID mappings for application activation.
---
--- Parameters:
---  * ids - A table mapping bundle IDs to their hotkey configurations
---
--- Example:
---  ```lua
---  spoon.AppActivator:bindHotkeys({
---     ["com.raycast.macos"] = {{"cmd"}, "space"},
---     ["com.another.app"] = {{"cmd", "shift"}, "space"}
---  })
---  ```
function obj:bindHotkeys(ids)
    -- Create lookup table for mapping hotkey combinations to bundle IDs
    self.hotkeyToBundleIDMap = {}
    for bundleID, keyConfig in pairs(ids) do
        local mapKey = self:_generateMapKey(keyConfig[1], keyConfig[2])
        self.hotkeyToBundleIDMap[mapKey] = bundleID
    end
end

--- AppActivator:start()
--- Method
--- Starts monitoring keyboard events for configured hotkeys.
--- When a matching hotkey is pressed while its corresponding app is focused,
--- that app will be brought to front.
---
--- Returns:
---  * The AppActivator object
function obj:start()
    if self.eventTap then
        self.eventTap:stop()
    end
    
    self.eventTap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown}, function(event)
        local flags = event:getFlags()
        local keyCode = event:getKeyCode()
        local pressedKey = hs.keycodes.map[keyCode]

        local activeModifiers = {}
        for mod, isPressed in pairs(flags) do
            if isPressed then
                table.insert(activeModifiers, mod)
            end
        end

        local mapKey = self:_generateMapKey(activeModifiers, pressedKey)
        local bundleID = self.hotkeyToBundleIDMap[mapKey]

        if not bundleID then
            return false
        end

        local app = hs.application.get(bundleID)
        if app then
            app:activate()
        else
            hs.application.launchOrFocusByBundleID(bundleID)
        end

        return false
    end):start()
    
    return self
end

--- AppActivator:stop()
--- Method
--- Stop monitoring
---
--- Returns:
---  * The AppActivator object for method chaining
function obj:stop()
    if self.eventTap then
        self.eventTap:stop()
        self.eventTap = nil
    end
    return self
end

return obj

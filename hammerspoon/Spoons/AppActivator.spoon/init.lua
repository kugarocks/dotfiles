--- === AppActivator ===
---
--- A Spoon that allows you to activate applications using their own hotkeys.
--- When the configured hotkey is pressed, the corresponding app will be brought to front.
--- If the app is not running, it will be launched.

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

--- AppActivator:bindHotkeys(hotkeys)
--- Method
--- Configures hotkey to bundle ID mappings for application activation.
---
--- Parameters:
---  * hotkeys - A table mapping bundle IDs to their hotkey configurations
---
--- Example:
---  ```lua
---  spoon.AppActivator:bindHotkeys({
---     ["com.raycast.macos"] = {{"cmd"}, "space"},
---     ["com.another.app"] = {{"cmd", "shift"}, "space"}
---  })
---  ```
function obj:bindHotkeys(hotkeys)
    -- Create lookup table for mapping hotkey combinations to bundle IDs
    self.hotkeyToBundleIDMap = {}
    for bundleID, keyConfig in pairs(hotkeys) do
        local mapKey = self:_generateMapKey(keyConfig[1], keyConfig[2])
        self.hotkeyToBundleIDMap[mapKey] = bundleID
    end
end

--- AppActivator:start()
--- Method
--- Starts monitoring keyboard events for configured hotkeys.
--- When a matching hotkey is pressed, the corresponding app will be brought to front.
--- If the app is not running, it will be launched.

--- Returns:
---  * The AppActivator object
function obj:start()
    if self.eventTap then
        self.eventTap:stop()
    end
    
    self.eventTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
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

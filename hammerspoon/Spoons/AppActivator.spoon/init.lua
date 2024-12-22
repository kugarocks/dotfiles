--- === AppActivator ===
---
--- Activate focused window app such as raycast, chatgpt, etc.

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "AppActivator"
obj.version = "1.0"
obj.author = "kugarocks"
obj.homepage = "https://github.com/kugarocks/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal variables
obj.bundleIdMap = {}
obj.eventTap = nil

-- Get current application's bundle ID
function obj:getFocusedAppBundleID()
    local bundleID
    local currentWindow = hs.window.focusedWindow()
    
    if currentWindow then
        local windowApp = currentWindow:application()
        if windowApp then
            bundleID = windowApp:bundleID()
        end
    end

    return bundleID
end

--- AppActivator:setBundleIds(ids)
--- Method
--- Set the bundle IDs of applications to monitor
---
--- Parameters:
---  * ids - An array of bundle IDs, e.g., {"com.raycast.macos"}
function obj:setBundleIds(ids)
    local map = {}
    for _, id in ipairs(ids) do
        map[id] = true
    end
    self.bundleIdMap = map
end

--- AppActivator:start()
--- Method
--- Start monitoring
---
--- Returns:
---  * The AppActivator object for method chaining
function obj:start()
    if self.eventTap then
        self.eventTap:stop()
    end
    
    self.eventTap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
        local bundleID = self:getFocusedAppBundleID()
        
        if self.bundleIdMap[bundleID] then
            local app = hs.application.get(bundleID)
            if app then
                app:activate()
            end
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

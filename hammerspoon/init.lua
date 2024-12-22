-- osascript -e 'id of app "Raycast"'
local bundleIds = {
    "com.raycast.macos",
}
hs.loadSpoon("AppActivator")
spoon.AppActivator:setBundleIds(bundleIds)
spoon.AppActivator:start()

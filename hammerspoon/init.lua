local raycastBundleID = "com.raycast.macos"

hs.loadSpoon("AppActivator")
spoon.AppActivator:bindHotkeys({
    [raycastBundleID] = {{"cmd"}, "space"},
})
spoon.AppActivator:start()

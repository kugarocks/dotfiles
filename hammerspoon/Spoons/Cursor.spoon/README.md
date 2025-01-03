# Cursor.spoon

The goal of this shortcut setup is to assign the most common functions to the easiest key combos.
For apps with conflicts, you can rewrite the shortcuts individually.
To avoid conflicts, simply use `cmd`+`ctrl` as default prefix.
Don't forget to save your pinky by mapping `capsLock` to `control`.

| Function | Default | Cursor | Raycast |
|----------|----------|----------|----------|
| Move Left | `cmd`+`h` | `cmd`+`ctrl`+`h` | `cmd`+`ctrl`+`h` |
| Move Down | `cmd`+`j` | `cmd`+`ctrl`+`j` | `cmd`+`ctrl`+`j` |
| Move Up | `cmd`+`k` | `cmd`+`ctrl`+`k` | `cmd`+`ctrl`+`k` |
| Move Right | `cmd`+`l` | `cmd`+`ctrl`+`l` | `cmd`+`ctrl`+`l` |
| Move Word Left | `cmd`+`ctrl`+`h` | - | - |
| Move Word Right | `cmd`+`ctrl`+`l` | - | - |
| Delete Char | `cmd`+`d` | `cmd`+`d` | `cmd`+`d` |
| Delete Word | `cmd`+`s` | `cmd`+`s` | `cmd`+`s` |

## Get Bundle ID

```sh
osascript -e 'id of app "Raycast"'
```

## init.lua

```lua
local bundleIds = {
    raycast = "com.raycast.macos",
    cursor = "com.todesktop.230313mzl4w4u92"
}

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
```

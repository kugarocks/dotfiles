# ControlShift.spoon

Map special characters to Ctrl + key combinations for easier typing.
This spoon works best when your `capslock` key is mapped to `control`.
Using `capslock` instead of `shift` can save your pinky.

| Shortcut | Output |
|----------|--------|
| `ctrl` + `` ` `` | ~ |
| `ctrl` + `num` | !@#$%^&*() |
| `ctrl` + `...` | ... |

```lua
hs.loadSpoon("ControlShift")
-- Set custom key mappings
-- $/^: vim works (OH YEAH)
spoon.ControlShift:setKeyMapping({
    ["`"] = "~",
    ["1"] = "!",
    ["2"] = "@", 
    ["3"] = "#",
    ["4"] = "$",
    ["5"] = "%",
    ["6"] = "^",
})
spoon.ControlShift:start()
```
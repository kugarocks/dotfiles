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
-- ControlShift
-- $^: vim lineTail/lineHead
-- %": tmux splitVertical/splitHorizontal
hs.loadSpoon("ControlShift")
spoon.ControlShift:setKeys({
    '`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    '-', '=', '[', ']', '\\', ';', '\'', ',', '.', '/'
})
spoon.ControlShift:start()
```
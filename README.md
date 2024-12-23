# dotfiles

* tmux: Your best friend.
* Karabiner: Customize keyboard shortcuts.
* Hammerspoon: Help Karabiner recognize special apps such as Raycast.
* WezTerm: I love quick select mode.
* Alacritty: Run cli programs such as Markdown Finder.
* Markdown Finder: Copy markdown code block super fast.
* neovim: Not VSCode.
* powerlevel10k: Dress up your terminal.
* Oh My Zsh: 10x developer.

## tmux

I need run tmux in remote server to avoid network issues.
Also I need to run tmux locally to get used to its key bindings. There are two ways to do this.
First, use tmux nested within tmux. To maintain consistent key bindings, you might need a plugin like [tmux-suspend](https://github.com/MunifTanjim/tmux-suspend).
Additionally, for the inner tmux clipboard to work properly, you would need to use OSC 52 and the [set-clipboard](https://github.com/tmux/tmux/wiki/Clipboard#terminal-support---tmux-inside-tmux) option.
For me, I prefer the second way, just use a new tab or split panes to avoid nested tmux sessions entirely.
That's why I switch Alacritty to WezTerm.

## Karabiner

The goal of this shortcut setup is to assign the most common functions to the easiest key combos.
To resolve key binding conflicts, you can set conditions based on the frontmost application.
Don't forget to save your pinky by mapping `capsLock` to `control`.

| Function | Default | Cursor | Raycast |
|----------|----------|----------|----------|
| Move Left | `cmd`+`h` | `cmd`+`caps`+`h` | `cmd`+`caps`+`h` |
| Move Down | `cmd`+`j` | `cmd`+`caps`+`j` | `cmd`+`caps`+`j` |
| Move Up | `cmd`+`k` | `cmd`+`caps`+`k` | `cmd`+`caps`+`k` |
| Move Right | `cmd`+`l` | `cmd`+`caps`+`l` | `cmd`+`caps`+`l` |
| Move Word Left | `cmd`+`caps`+`h` | - | - |
| Move Word Right | `cmd`+`caps`+`l` | - | - |
| Delete Char | `cmd`+`d` | `cmd`+`d` | `cmd`+`d` |
| Delete Word | `cmd`+`s` | `cmd`+`s` | `cmd`+`s` |
| Line Break | `caps`+`enter` | `caps`+`enter` | `caps`+`enter` |
| Tab Left | `cmd`+`caps` + `[` | `cmd`+`caps` + `[` | `cmd`+`caps` + `[` |
| Tab Right | `cmd`+`caps` + `]` | `cmd`+`caps` + `]` | `cmd`+`caps` + `]` |
| !@#... | `caps` + `123...` | `caps` + `123...` | `caps` + `123...` |

## Alacritty

Alacritty is super fast and well-suited to serve as a shell for command-line applications.

## Markdown Finder

[Markdown Finder](https://github.com/kugarocks/markdown-finder) is a tool for quickly locating and copying code snippets in Markdown files.

## neovim

### Plugins

* [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [gopls](https://github.com/golang/tools/tree/master/gopls)
* [monokai](https://github.com/tanvirtin/monokai.nvim)

### File Structure

```txt
nvim
├── README.md
├── init.lua
├── lazy-lock.json
└── lua
    ├── config
    │   └── lazy.lua
    └── plugins
        ├── monikai.lua
        ├── nvim-cmp.lua
        ├── nvim-lspconfig.lua
        ├── nvim-tree.lua
        └── nvim-treesitter.lua
        └── ...
```

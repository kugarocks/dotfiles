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

## Setup

Set symlinks for dotfiles. Nothing will happen if the target file already exists.

```bash
./link.sh
```

## tmux

To avoid network issues, tmux is run on a remote server. Locally, tmux is also used to get accustomed to its key bindings.

There are two approaches:

* Nest tmux within tmux, using a plugin like [tmux-suspend](https://github.com/MunifTanjim/tmux-suspend) for consistent key bindings. For the inner tmux clipboard to function properly, OSC 52 and the [set-clipboard](https://github.com/tmux/tmux/wiki/Clipboard#terminal-support---tmux-inside-tmux) option must be enabled.

* The preferred method is to avoid nested tmux sessions by using a new tab or split panes instead. This is why I switched from Alacritty to WezTerm.

## Karabiner

Karabiner is used for key bindings because it has higher priority than any other app.
The goal of this setup is to assign the most common functions to the easiest key combinations.
To resolve conflicts, set conditions based on the frontmost application.
And don't forget to save your pinky by mapping `capsLock` to `control`.

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

## Hammerspoon

Hammerspoon is a powerful automation tool for macOS.
I use it to bring Raycast to the frontmost application for Karabiner, as Karabiner cannot recognize Raycast.

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

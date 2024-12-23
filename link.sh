#!/bin/bash

# Use current directory as source path
SOURCE_PATH="$(pwd)"

# Function to create symbolic link
create_symlink() {
    local source_file="$1"
    local target_file="$2"
    
    # Check if source file/directory exists
    if [ ! -e "$source_file" ]; then
        echo "Skip: Source '$source_file' does not exist"
        return 1
    fi

    # Check if target is exists
    if [ -e "$target_file" ]; then
        echo "Skip: $target_file is exists, backup and remove it first"
        return 1
    fi

    # Create symbolic link
    ln -sf "$source_file" "$target_file"
    echo "Done: $target_file -> $source_file"
}

# Create symbolic links for all config files
create_symlink "$SOURCE_PATH/zshrc" "$HOME/.zshrc"
create_symlink "$SOURCE_PATH/tmux.conf" "$HOME/.tmux.conf"
create_symlink "$SOURCE_PATH/p10k.zsh" "$HOME/.p10k.zsh"
create_symlink "$SOURCE_PATH/wezterm/wezterm.lua" "$HOME/.wezterm.lua"
create_symlink "$SOURCE_PATH/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
create_symlink "$SOURCE_PATH/mdf/alacritty.toml" "$HOME/.mdf/alacritty.toml"

# directory
create_symlink "$SOURCE_PATH/hammerspoon" "$HOME/.hammerspoon"
create_symlink "$SOURCE_PATH/alacritty" "$HOME/.config/alacritty"
create_symlink "$SOURCE_PATH/nvim" "$HOME/.config/nvim"

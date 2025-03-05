#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title mdf
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋
# @raycast.argument1 { "type": "text", "placeholder": "Snippet" }

LANG=en_US.UTF-8 \
MDF_HOME=/Users/kuga/.mdf \
/Applications/Alacritty.app/Contents/MacOS/alacritty \
    --config-file /Users/kuga/dotfiles/mdf/alacritty.toml \
    -e /opt/homebrew/bin/mdf "$1" \
    > /dev/null 2>&1

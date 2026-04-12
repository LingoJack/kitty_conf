#!/bin/bash
KITTY_DIR="$HOME/.config/kitty"
KITTY_CONF="$KITTY_DIR/kitty.conf"
LIGHT="theme-anthropic-light.conf"
DARK="theme-anthropic-dark.conf"

current=$(grep -E '^include theme-.*\.conf' "$KITTY_CONF" | head -1)

if echo "$current" | grep -q "$LIGHT"; then
    sed -i '' "s|^include theme-.*\.conf|include $DARK|" "$KITTY_CONF"
    echo ">> switched to dark theme"
else
    sed -i '' "s|^include theme-.*\.conf|include $LIGHT|" "$KITTY_CONF"
    echo ">> switched to light theme"
fi

kitten @ load-config

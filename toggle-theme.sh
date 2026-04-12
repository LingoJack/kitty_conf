#!/bin/bash
KITTY_DIR="$HOME/.config/kitty"
KITTY_CONF="$KITTY_DIR/kitty.conf"
LIGHT="theme-anthropic-light.conf"
DARK="theme-anthropic-dark.conf"

current=$(grep -E '^include theme-.*\.conf' "$KITTY_CONF" | head -1)

if echo "$current" | grep -q "$LIGHT"; then
    sed -i '' "s|^include theme-.*\.conf|include $DARK|" "$KITTY_CONF"
else
    sed -i '' "s|^include theme-.*\.conf|include $LIGHT|" "$KITTY_CONF"
fi

# 模拟 ctrl+cmd+, 重载 kitty 配置
osascript -e 'tell application "System Events" to keystroke "," using {control down, command down}'

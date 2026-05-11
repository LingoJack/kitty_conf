#!/bin/sh
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

# 自动发现 kitty socket
SOCKET=$(ls -t /tmp/kitty-rc-* 2>/dev/null | head -1)
if [ -n "$SOCKET" ]; then
    kitty @ --to "unix:$SOCKET" load-config
fi

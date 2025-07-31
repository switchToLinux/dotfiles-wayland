#!/bin/bash

# 获取所有窗口信息
selected=$(hyprctl clients -j | jq -r '.[] | "\(.address) \(.title)"' | wofi --show dmenu \
            --width 800 \
            --height 600 \
            --cache-file /dev/null \
            --style ~/.config/wofi/window_switcher.css)

pkill wofi

if [ -n "$selected" ]; then
    window_id=$(echo "$selected" | awk '{print $1}')
    hyprctl dispatch focuswindow address:$window_id
fi

#!/bin/bash
#
# 切换 waybar 布局结构

CONFIG_FILE="$HOME/.config/waybar/config"
STYLE_FILE="$HOME/.config/waybar/style.css"
SCRIPT_DIR="$HOME/.config/waybar/scripts"

show_layout() {
    echo "top"
    echo "bottom"
    echo "left"
    echo "right"
}
switch_layout() {
    local select_layout="$1"
    [[ -z "$select_layout" ]] && notify-send "Error: invalid layout[$select_layout]" && exit 1
    sed -i 's/"position".*$/"position" : '\"${select_layout}\",'/' ${CONFIG_FILE}

    if [[ "$select_layout" == "top" || "$select_layout" == "bottom" ]]; then
        sed -i 's#/left_modules.json#/modules.json#g;s#/left_modules-custom.json#/modules-custom.json#g' ${CONFIG_FILE}
        sed -i 's#padding:.*;#padding: 0pt 4pt;#g' ${STYLE_FILE}
        $SCRIPT_DIR/auto_color.sh
    else
        sed -i 's#/modules.json#/left_modules.json#g;s#/modules-custom.json#/left_modules-custom.json#g' ${CONFIG_FILE}
        sed -i 's#padding: .*;#padding: 4pt 0pt;#g' ${STYLE_FILE}
        $SCRIPT_DIR/auto_color.sh "space space"
    fi
}


select_layout=$(show_layout | wofi --dmenu )
switch_layout "$select_layout"


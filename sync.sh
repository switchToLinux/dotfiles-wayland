#!/usr/bin/env bash

sync_hyprland() {
    rsync -vulr ./{mako,waybar,wofi} ~/.config/
    rsync -vulr ./hypr --exclude='custom' ~/.config/
}

sync_other() {
    rsync -vulr ./{Thunar,mpd,xfce4,yazi} ~/.config/
}

sync_repo() {
    rsync -vulr hypr mako waybar wofi xfce4 mpd yazi Thunar wconfig ../dotfiles-i3wm/
}

sync_all() {
    sync_hyprland
    sync_other
    sync_repo
}

if [[ $# -eq 0 ]]; then
    sync_hyprland
else
    case $1 in
        hypr*)
            sync_hyprland
            ;;
        other)
            sync_other
            ;;
        repo)
            sync_repo
            ;;
        all)
            sync_all
            ;;
        *)
            echo "Usage: $0 [hyprland|other|all]"
            ;;
    esac
fi


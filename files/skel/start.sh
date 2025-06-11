#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland

pipewire &
wireplumber &
pipewire-pulse &
pipewire-jack &
pipewire-alsa &

waybar &
mpd &
dunst &
$HOME/scripts/mpd-osd.sh &
exec dbus-run-session Hyprland

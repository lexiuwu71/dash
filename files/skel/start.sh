#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland

exec dbus-run-session Hyprland
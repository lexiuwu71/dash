#!/bin/sh

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland

exec dbus-run-session Hyprland
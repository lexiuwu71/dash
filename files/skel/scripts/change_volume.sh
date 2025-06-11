#!/bin/bash

STEP=5
direction=$1

if [[ "$direction" == "u" ]]; then
    pamixer -i "${STEP}"
elif [[ "$direction" == "d" ]]; then
    pamixer -d "${STEP}"
elif [[ "$direction" == "m" ]]; then
    pamixer --toggle-mute
elif [[ "$direction" == "M" ]]; then
    pamixer --default-source --toggle-mute
    mute=$(pamixer --default-source --get-mute)
    if [[ "${mute}" == "false" ]]; then
        icon="/home/lexi/scripts/osd/mic/0.svg"
    else
        icon="/home/lexi/scripts/osd/mic/1.svg"
    fi
    notify-send "Microphone" -a "microphone" -h string:x-dunst-stack-tag:microphone -i $icon
else
    echo "Usage: $0 [u|d|m]"
    exit 1
fi

python /home/lexi/scripts/volume-osd.py

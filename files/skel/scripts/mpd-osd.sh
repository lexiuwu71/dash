#!/bin/bash

oldsong=""
while true; do
    newsong=$(mpc current)
    if [[ "$newsong" != "$oldsong" && -n "$newsong" ]]; then
		cover="/home/$(whoami)/Music/$(dirname "$(mpc current -f %file%)")/cover.bmp"
		oldsong=$(mpc current)
		notify-send "Now playing" "$(mpc current -f '%title%\n%artist%\n%album%')" "--icon" "$cover"
	fi
	sleep 1
done

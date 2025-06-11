#!/bin/sh

echo -e " * Installing '$1' package profile!"

case $1 in
	"update")
		apk update
		apk upgrade
		;;
	"sys")
		apk add $(cat packages/packages.txt)
		;;
	"xfce4")
		apk add $(cat packages/hypr.txt)
		setup-xorg-base
		setup-devd udev
		rc-update add seatd
		rc-update add dbus
		rc-update add elogind
		rc-service seatd start
		rc-service dbus start
		rc-service elogind start
		;;
	"silly")
		apk add $(cat packages/terminal_apps.txt)
		;;
	"desktop")
		apk add $(cat packages/desktop_apps.txt)
		;;
	"music")
		apk add $(cat packages/music.txt)
		;;
esac

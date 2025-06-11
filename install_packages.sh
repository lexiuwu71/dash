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
	"hypr")
		apk add $(cat packages/hypr.txt)
		setup-devd udev
		rc-update add seatd
		rc-update add dbus
		rc-service seatd start
		rc-service dbus start
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

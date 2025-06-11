#!/bin/bash

choice=$(dialog --title "TUI Apps" --menu "Apps:" 15 50 4 \
    1 "Cava" \
    2 "Clock" \
    3 "Pipes" \
    4 "Cmatrix" \
    5 "Music" \
		6 "Calender" \
    7 "Exit" 2>&1 > /dev/tty)

# Handle the user's choice
case $choice in
    1) cava ;;
    2) tty-clock -s -D -c ;;
    3) pipes.sh ;;
    4) cmatrix ;;
    5) ncmpcpp ;;
    6) calcurse ;;
    7) clear; exit 0 ;;
    *) dialog --msgbox "Invalid choice, try again." 5 30 ;;
esac

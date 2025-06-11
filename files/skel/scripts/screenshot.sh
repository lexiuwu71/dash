#!/bin/bash

mkdir -p $HOME/Pictures/Screenshots

if [ "$1" == "--select" ]; then
  import $HOME/Pictures/Screenshots/"$(date +'%Y%m%d_%H%M%S')".png
else
  import -window root $HOME/Pictures/Screenshots/"$(date +'%Y%m%d_%H%M%S')".png
fi

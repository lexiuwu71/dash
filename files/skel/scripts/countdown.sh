#!/bin/bash

COUNTDOWN_DATE="July 9 2025"
EVENT="get my license frfr"

TODAY=$(date +%j)
EVENT_DATE=$(date -d "$COUNTDOWN_DATE" +%j)
DAYS=$((EVENT_DATE - TODAY))

case $DAYS in
  0) echo "$EVENT is today~!";;
  [1-9]*|[1-9][0-9]*) echo "$DAYS days remaining";;
  -*) echo "The countdown is over! :3";;
esac

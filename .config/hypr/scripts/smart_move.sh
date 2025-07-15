#!/bin/bash

# direction: left, right, up, down
DIR="$1"

STEP=20

INFO=$(hyprctl activewindow -j)
ISFLOAT=$(echo "$INFO" | jq '.floating')

case "$DIR" in
  left) X="-${STEP}"; Y="0"; MOVE="l" ;;
  right) X="${STEP}"; Y="0"; MOVE="r" ;;
  up) X="0"; Y="-${STEP}"; MOVE="u" ;;
  down) X="0"; Y="${STEP}"; MOVE="d" ;;
  *) exit 1 ;;
esac

if [[ "$ISFLOAT" == "true" ]]; then
  hyprctl dispatch moveactive "$X" "$Y"
else
  hyprctl dispatch movewindow "$MOVE"
fi

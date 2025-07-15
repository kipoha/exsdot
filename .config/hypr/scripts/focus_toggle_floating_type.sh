#!/bin/bash

# Получаем данные об активном окне
active_info=$(hyprctl activewindow -j)
active_addr=$(echo "$active_info" | jq -r '.address')
active_floating=$(echo "$active_info" | jq -r '.floating')
active_workspace=$(echo "$active_info" | jq -r '.workspace.id')

# Что ищем: противоположный тип
target_type=$( [ "$active_floating" = "true" ] && echo false || echo true )

# Ищем окно противоположного типа на том же workspace
hyprctl clients -j | jq -r \
  --argjson ws "$active_workspace" \
  --arg type "$target_type" \
  --arg current "$active_addr" '
  .[] | select(.workspace.id == $ws and .floating == ($type | test("true|false")) and .address != $current)
  | .address' | while read -r addr; do
    hyprctl dispatch focuswindow address:$addr
    exit 0
done

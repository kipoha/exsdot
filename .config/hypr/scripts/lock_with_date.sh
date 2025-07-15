#!/bin/bash
export DATE="$(date '+%A, %d %B %Y')"
export RANDOM_PHRASE="$(~/.config/hypr/scripts/random.sh)"
hyprlock

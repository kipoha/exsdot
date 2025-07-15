#!/bin/bash

case "$1" in
    volume)
        vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
        icon="audio-volume-high"
        if [ "$vol" -eq 0 ]; then
            icon="audio-volume-muted"
        elif [ "$vol" -lt 30 ]; then
            icon="audio-volume-low"
        fi

        notify_file="/tmp/notify-volume-id"
        [ -f "$notify_file" ] && id=$(cat "$notify_file") || id=0

        new_id=$(notify-send -r "$id" \
            -i "$icon" \
            -u low \
            -h int:value:"$vol" \
            "Volume" "🔊 $vol%" \
            --print-id \
            -t 1000
        )

        echo "$new_id" > "$notify_file"
        ;;

    brightness)
        bright=$(brightnessctl get)
        max_bright=$(brightnessctl max)
        percent=$((bright * 100 / max_bright))

        notify_file="/tmp/notify-brightness-id"
        [ -f "$notify_file" ] && id=$(cat "$notify_file") || id=0

        new_id=$(notify-send -r "$id" \
            -i display-brightness \
            -u low \
            -h int:value:"$percent" \
            "Brightness" "󰃞 $percent%" \
            --print-id \
            -t 1000
        )

        echo "$new_id" > "$notify_file"
        ;;
esac

#!/usr/bin/env bash

waybar_tooltip()
{
    echo "$1" | while read -r line; do
        count="${#line}"
        [ "$count" -lt 69 ] && line="${line}$(printf "%$((69 - count))s")"
        printf '%s' "$line "
    done
}

text=$(df -h /home | tail -1 | awk '{print $5 " "}')
alt=$(df -h /home | tail -1 | awk '{print $4 " / " $2 " "}')
tooltip=$(df -h | sed -z 's/\n/\\n/g')

printf '{"text":"%s","alt":"%s","tooltip":"%s","class":"disk","percentage":"%s"}\n' "$text" "$alt" "$tooltip" "$alt"
exit


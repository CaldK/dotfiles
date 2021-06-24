#!/bin/bash

plyctlstatus="(playerctl --player=spotify,spotifyd status)"

if [ "$plyctlstatus" = "Stopped" ]; then
    echo "No music is playing"
elif [ "$plyctlstatus" = "Paused"  ]; then
    polybar-msg -p "$(pgrep -f "polybar bottom")" hook spotify-play-pause 2 1>/dev/null 2>&1
    playerctl --player=spotify,spotifyd metadata --format "{{ title }} - {{ artist }}"
else # Can be configured to output differently when player is paused
    polybar-msg -p "$(pgrep -f "polybar bottom")" hook spotify-play-pause 1 1>/dev/null 2>&1
    playerctl --player=spotify,spotifyd metadata --format "{{ title }} - {{ artist }}"
fi

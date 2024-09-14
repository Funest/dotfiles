#!/usr/bin/env bash

XIDLEHOOK_PID=$(pgrep 'xidlehook')
if [ $? -eq 0 ]; then
    echo "Killing running xidlehook at ${XIDLEHOOK_PID//$'\n'/, }."
    killall 'xidlehook'
fi

echo "Running xidlehook."
xidlehook \
    --not-when-fullscreen --not-when-audio \
    --timer 120 \
        '$HOME/.scripts/set-brightness.sh .5' \
        '$HOME/.scripts/set-brightness.sh 1' \
    --timer 30 \
        '$HOME/.scripts/set-brightness.sh 1; xset dpms force off' \
        '' \
    --timer 30 \
        'i3lock -i $HOME/i3lock-wallpaper.png' \
        '' \
    --timer 1800 \
        'loginctl suspend' \
        '' &

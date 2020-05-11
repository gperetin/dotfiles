#!/bin/bash

if [ $# -eq 0 ]
    then
    echo -e " Shutdown\nﰇ Reboot\n鈴Suspend\n祥 Set Timer"
else
    if [[ $1 = " Shutdown" ]]; then
        systemctl poweroff
    elif [[ $1 = "ﰇ Reboot" ]]; then
        systemctl reboot
    elif [[ $1 = "鈴Suspend" ]]; then
        systemctl suspend
    elif [[ $1 = "祥 Set Timer" ]]; then
        systemd-run --on-active=2250 --user --service-type=oneshot notify-send "Take a break"
    fi
fi

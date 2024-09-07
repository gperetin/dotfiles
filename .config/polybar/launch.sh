#!/usr/bin/env bash

# Terminate already running bar instances
killall -qr polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar top &
  done
else
  polybar top &
fi

echo "Polybar launched..."

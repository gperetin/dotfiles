#!/bin/sh

# DP3 and DP1 are 27" monitors, DP1 is directly below DP3. eDP1 is a 4K laptop screen that sits to the right of DP1
xrandr --output VIRTUAL1 --off --output DP3 --scale 2x2 --mode 2560x1440 --fb 8960x5760 --pos 0x0 --rotate normal --output DP1 --scale 2x2 --mode 2560x1440 --pos 0x2880 --rotate normal --output eDP1 --primary --mode 3840x2160 --pos 5120x3600 --rotate normal --output DP2 --off

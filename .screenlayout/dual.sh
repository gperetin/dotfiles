#!/bin/sh

# DP3 is a 27" monitor, to the left of eDP1 which is a laptop 4K screen, their tops are aligned
xrandr --output VIRTUAL1 --off --output DP3 --scale 1.75x1.75 --mode 2560x1440 --fb 8960x2880 --pos 0x0 --rotate normal --output eDP1 --primary --mode 3840x2160 --pos 5120x0 --rotate normal --output DP2 --off

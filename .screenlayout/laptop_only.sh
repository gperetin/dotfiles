#!/bin/sh

# Just the eDP1, laptop 4K screen. I use this when disconnecting all external monitors
xrandr --output VIRTUAL1 --off --output DP3 --off --output DP1 --off --output eDP1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output DP2 --off

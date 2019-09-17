#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x211 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --mode 1280x1024 --pos 1920x0 --rotate normal

#apply bg
sh ~/.fehbg

# bar
~/.config/polybar/launch.sh

#!/bin/sh
xrandr --output DP-1-3 --off --output eDP-1 --primary --mode 1920x1080 --pos 2400x1048 --rotate normal --output DP-2 --off --output DP-1 --off --output DP-3 --off --output DP-1-2 --mode 1920x1200 --pos 0x0 --rotate left --output DP-1-1 --mode 1920x1200 --pos 1200x0 --rotate left

#apply bg
sh ~/.fehbg

# bar
~/.config/polybar/launch.sh

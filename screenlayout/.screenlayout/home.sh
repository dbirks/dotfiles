#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1200 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --mode 1920x1200 --pos 0x0 --rotate normal

# bar
pkill polybar
~/.config/polybar/launch.sh &

# add workspaces to each monitor
~/.config/bspwm/bspwmrc &


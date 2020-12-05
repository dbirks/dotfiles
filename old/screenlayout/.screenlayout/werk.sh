#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 3120x1102 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-1-1 --mode 1920x1200 --pos 0x0 --rotate left --output DP-1-2 --mode 1920x1200 --pos 1200x360 --rotate normal --output DP-1-3 --off

# bar
pkill polybar
~/.config/polybar/launch.sh &

# add workspaces to each monitor
~/.config/bspwm/bspwmrc &


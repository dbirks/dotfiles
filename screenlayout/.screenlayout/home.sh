#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 791x1080 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-2 --off --output DP-1-3 --mode 1280x1024 --pos 1920x56 --rotate normal

# bar
~/.config/polybar/launch.sh

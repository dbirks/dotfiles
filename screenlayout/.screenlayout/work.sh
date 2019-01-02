#!/bin/sh
xrandr --output DP-1 --mode 1920x1200 --pos 0x0 --rotate normal --output HDMI-1 --off --output eDP-1 --primary --mode 1920x1080 --pos 1920x368 --rotate normal --output HDMI-2 --off

#apply bg
feh --bg-fill --recursive --randomize "/home/david/Pictures/Wallpapers/super cute girl"

# bar
~/.config/polybar/launch.sh

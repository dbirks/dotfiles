#!/bin/sh
xrandr --output HDMI2 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output eDP1 --mode 1920x1080 --pos 0x1080 --rotate normal --output VIRTUAL1 --off

#apply bg
feh --bg-fill --recursive --randomize "/home/david/Pictures/Wallpapers/super cute girl"

# bar
~/.config/polybar/launch.sh

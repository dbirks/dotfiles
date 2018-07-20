#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 3000x736 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output DP1-3 --off --output DP1-2 --mode 1920x1080 --pos 1080x424 --rotate normal --output DP1-1 --mode 1920x1080 --pos 0x0 --rotate left

#apply bg
feh --bg-fill --recursive --randomize "/home/david/Pictures/Wallpapers/super cute girl"

# bar
~/.config/polybar/launch.sh

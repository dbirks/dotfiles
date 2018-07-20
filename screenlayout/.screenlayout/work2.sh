#!/bin/sh
xrandr --output VIRTUAL1 --off --output DP3 --mode 1920x1080 --pos 0x0 --rotate left --output DP2 --mode 1920x1080 --pos 1080x544 --rotate normal --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --primary --mode 1366x768 --pos 3000x856 --rotate normal --output VGA1 --off

#apply bg
feh --bg-fill --recursive --randomize "/home/david/Pictures/Wallpapers/super cute girl"

# bar
~/.config/polybar/launch.sh
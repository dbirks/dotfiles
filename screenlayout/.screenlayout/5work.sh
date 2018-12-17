#!/bin/sh
xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --mode 1024x768 --pos 0x0 --rotate left --output HDMI2 --mode 1024x768 --pos 768x0 --rotate left --output HDMI1 --off --output LVDS1 --primary --mode 1366x768 --pos 1536x256 --rotate normal --output VGA1 --off

#apply bg
feh --bg-fill --recursive --randomize "/home/david/Pictures/Wallpapers/super cute girl"

# bar
~/.config/polybar/launch.sh

#!/bin/sh

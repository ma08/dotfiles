# xrandr | grep 'HDMI-A-0 connected' && xrandr --output eDP --auto --output HDMI-A-0 --auto --rotate right --right-of eDP --output  DisplayPort-0 --auto --right-of HDMI-A-0
# xrandr | grep 'HDMI-A-0 connected' && 
xrandr | grep 'HDMI-A-0 connected' && xrandr --output eDP --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 1920x0 --rotate right --output DisplayPort-0 --mode 1920x1080 --pos 3000x0 --rotate normal


xrandr | grep 'HDMI-A-0 connected' && xrandr --output eDP  --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 1920x0 --rotate right --output DisplayPort-0 --primary --mode 1920x1080 --pos 3000x0 --rotate normal

setxkbmap -option caps:super

# xrandr --output eDP --auto\
#         --output HDMI-A-0 --rotate right --right-of eDP\
#          --output  DisplayPort-0 --primary --auto --right-of HDMI-A-0

# xrandr --output eDP --auto\
#         --output HDMI-A-0 --rotate right --right-of eDP\
#          --output  DisplayPort-0 --primary --auto --right-of HDMI-A-0

feh --bg-scale ~/Pictures/Wallpapers/buddha_matrix.jpg
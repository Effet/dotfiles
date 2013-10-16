#!/bin/bash

# Merge .Xresources
[[ -r "$HOME/.Xresources" ]] && xrdb -merge "$HOME/.Xresources"

# turn numlock on
#numlockx on

# turn bell off
xset b off

# Energy Star on, standby/suspend/off
xset dpms 1800 3600 7200

# Keyboard control, repeat delay and repeat rate
xset r rate 200 30

# Pointer control, acceleration and threshold
xset m 3/2 4

setxkbmap -option ctrl:nocaps

# Pointer appearance
#   - xcb does not support Xcursor yet
xsetroot -cursor_name left_ptr

# Disable the touchpad while typing
syndaemon -k -i 1 -d &

# auto hide cursor
unclutter -idle 3 -root -grab -noevents &

xss-lock -- i3lock -n -i $HOME/pics/Color_1024x600.png &

# set clipboard
#parcellite &
# sync
#dropbox &
# volume icon in systray
#volumeicon &

xset +fp /usr/share/fonts/local
xset fp rehash


#dunst &
#compton &


## Spawn Apps
(emacs --daemon) &
(fcitx &> /dev/null) &


## Start WM
case "$WM" in
    i3)
        exec i3
        ;;
    bspwm)
        export PANEL_FIFO=/tmp/panel-fifo
        [ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
        mkfifo "$PANEL_FIFO"
        panel &
        sxhkd &
        exec bspwm -s "$PANEL_FIFO" -p W
        ;;
    *)
        exec i3
        ;;
esac

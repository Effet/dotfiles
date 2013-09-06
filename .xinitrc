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

# Pointer appearance
#   - xcb does not support Xcursor yet
xsetroot -cursor_name left_ptr

# Disable the touchpad while typing
syndaemon -k -i 1 -d &

# auto hide cursor
#unclutter -idle 3 -root -grab -noevents &

# set clipboard
#parcellite &
# sync
#dropbox &
# volume icon in systray
#volumeicon &

xset +fp /usr/share/fonts/local
xset fp rehash

setxkbmap -option ctrl:nocaps


export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
(fcitx &> /dev/null) &


#dunst &
#compton &

#xset 180 120
xss-lock -- i3lock &

# Start WM
case "$WM" in
    i3)
        exec i3
        ;;
    *)
        exec i3
        ;;
esac

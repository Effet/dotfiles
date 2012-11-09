#!/bin/sh
#
# ~/.xinitrc
#
# Many thanks to:
#    http://git.sysphere.org/dotfiles/tree/xinitrc


# Merge .Xdefaults
xrdb -merge $HOME/.Xdefaults


# # turn numlock on
# numlockx on

### TODO:
# Use:
#   Option "XkbLayout" "us"
#   Option "XkbVariant" "dvorak"
#   Option "XkbOptions" "terminate:ctrl_alt_bksp"
# in /etc/X11/xorg.conf.d/10-evdev.conf
# This is for all sessions, but I perfer to use setxkbmap
#setxkbmap -layout us -variant dvorak -option terminate:ctrl_alt_bksp

# call xmodmap for programmer dvorak
#xmodmap $HOME/dotFiles/keymaps/hhkb-dvp.xmodmap

# turn bell off
xset b off

# screen always light
xset s off
xset -dpms
#xset dpms force off
#xset dpms 1800 3600 7200

# Keyboard control, repeat delay and repeat rate
xset r rate 200 30

# Pointer control, acceleration and threshold
xset m 3/2 4

# Pointer appearance
#   - xcb does not support Xcursor yet
xsetroot -cursor_name left_ptr

# Disable the touchpad while typing
#syndaemon -k -i 2 -d &

# auto hide cursor
unclutter -idle 3 -root -grab -noevents &
# screen lock
xautolock -time 23 -locker xtrlock &


xcompmgr -cCfF -D.9 -t-5 -l-5 -r4.2 -I.07 -O.05 &
# conky -q -d -c ~/dotFiles/x-looks/time.conkyrc &

# urxvtd -q -f -o

# set clipboard
parcellite &
# sync
dropbox &
# volume icon in systray
volumeicon &

# keylogger
/usr/local/bin/WhatPulse &

## Setup XIM environment
eval `dbus-launch --sh-syntax --exit-with-session`
export XMODIFIERS="@im=fcitx"
# export XIM=fcitx
# export XIM_PROGRAM=fcitx

# If use English environment, needed
export IM_MODULE=xim
export GTK_IM_MODULE=fcitx
## I don't use qt
#export QT_IM_MODULE=fcitx
(fcitx &> /dev/null) &

(sh ~/.fehbg) &


# ((killall emacs ; emacs --daemon) && emacsclient -c) &
(killall emacs ; emacs --daemon) &


# Start WM
exec ck-launch-session awesome

#!/bin/sh
#
# ~/.xinitrc

# Fontpath for Terminus
xset +fp /usr/share/fonts/local/

# turn bell off
xset b off
# set mouse spead
xset m 0 10
# screen always light
xset s off
xset -dpms
#xset dpms force off

# screen lock
xautolock -time 8 -locker sflock &

# turn numlock on
numlockx on

# Merge .Xresources
xrdb -merge $HOME/.Xresources

# enable restart X
setxkbmap -option terminate:ctrl_alt_bksp
# call Xmodap for programmer dvorak
xmodmap $HOME/dotfiles/keymaps/hhkb-dvp.xmodmap

# set clipboard
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
## Set Wallpaper
#feh --bg-max "$HOME/Docs/pics/black_than_darker/ipod_yin.png" &

# Setup XIM environment, needn't if use SCIM as gtk-immodules
eval `dbus-launch --sh-syntax --exit-with-session`
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
(fcitx &> /dev/null) &

# set cursor
#xsetroot -cursor_name left_ptr &
xsetroot -cursor_name left_ptr
# auto hide cursor
unclutter -noevents -idle 5 &

# Start urxvt daemon
#urxvtd -q -f -o &

dropboxd &

xcompmgr -cF &
conky -q -d &

# Start WM
DWM="$HOME/Scripts/dwm-start"
XMONAD="xmonad"
AWESOME="awesome"
MONSTERWM="/$HOME/Scripts/monster-start"
OPENBOX="openbox"
KDE="exec ck-launch-session startkde"
GNOME="exec ck-launch-session gnome-session"
RAZOR="exec razor-session"
FVWM="exec fvwm-crystal"

DEFAULT_SESSION=$AWESOME
case $2 in
  dwm)
    $DWM;;
  xmonad)
    $XMONAD;;
  awesome)
    $AWESOME;;
  monster)
    $MONSTERWM;;
  openbox)
    $OPENBOX;;
  kde)
    $KDE;;
  gnome)
    $GNOME;;
  razor)
    $RAZOR;;
  fvwm)
    $FVWM;;
  *)
    $DEFAULT_SESSION;;
esac

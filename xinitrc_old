#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

devmon &
xrdb -merge ~/.Xresources
feh --bg-scale ~/archlinux001.jpg &
setxkbmap -layout si &
mpd ~/.mpdconf 
xcompmgr -f &
########################### TESTING #######################

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
# exec ck-launch-session xmonad
exec xmonad

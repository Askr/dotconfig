trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x2f4f4f --height 17 &

xscreensaver -no-splash &
~/.dropbox-dist/dropboxd &

xrdb -merge $HOME/.Xdefaults

xsetbg ~/pictures/ninjaswp.jpg

xsetroot -cursor_name left_ptr

xset fp+ /usr/share/fonts/local/terminus
xset fp+ /usr/share/fonts/TTF

xset b 100 0 0
xset r rate 300 100
exec xmonad

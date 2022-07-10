xset r rate 220 50
xset -b
xmodmap ~/.Xmodmap &
xcape -e 'Control_L=Escape' &
xbindkeys

# exec dwm
exec i3

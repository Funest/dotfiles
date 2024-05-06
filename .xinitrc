mega-sync
xrdb .Xresources
xrandr --output HDMI-A-0 --left-of DisplayPort-0

urxvtd --quiet --opendisplay --fork

picom &
exec dbus-launch --exit-with-session i3

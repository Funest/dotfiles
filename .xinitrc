xrdb .Xresources
xrandr --output HDMI-A-0 --left-of DisplayPort-0
picom -b --backend glx &

mega-sync
playerctld daemon
urxvtd --quiet --opendisplay --fork
export TERMINAL="urxvtc"

exec dbus-launch --exit-with-session i3

xrdb .Xresources
picom -b --backend glx &

mega-sync
playerctld daemon
urxvtd --quiet --opendisplay --fork
export TERMINAL="st"

exec dbus-launch --exit-with-session i3

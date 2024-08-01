xrdb .Xresources
picom -b --backend glx &

mega-sync
urxvtd --quiet --opendisplay --fork
export TERMINAL="st"

~/.fehbg
exec dbus-launch --exit-with-session i3

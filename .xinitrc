xrdb .Xresources
xrandr --output HDMI-A-0 --left-of DisplayPort-0

exec dbus-launch --exit-with-session i3

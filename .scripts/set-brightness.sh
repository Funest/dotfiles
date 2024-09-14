#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "No brightness supplied."
    exit
fi

XRANDR_OUT=$(xrandr | sed -n 's/\(.*\) connected.*/\1/p')

for OUTPUT in $XRANDR_OUT
do
    xrandr --output $OUTPUT --brightness $1
done

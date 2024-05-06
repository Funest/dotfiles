#!/bin/bash
if [ "$1" = "select" ]; then
    magick x: png:- | xclip -t image/png -se c -i
elif [ "$1" = "current" ]; then
    id=$(xprop -root _NET_ACTIVE_WINDOW | sed 's/.* //')
    magick "x:$id" png:- | xclip -t image/png -se c -i
fi

#!/bin/bash

while [ $# -ge 1 ]; do
    case $1 in
        -h|--help)
            PRINT_HELP=1
            break
            ;;
        -f|--file)
            OUTFILE=$2
            shift
            ;;
        -x|--xdg-open)
            XDG_OPEN=1
            ;;
        -c|--clipboard)
            CLIPBOARD=1
            ;;
        select|current|all|root)
            COMMAND=$1
            ;;
        -*)
            echo "Unrecognized option $1."
            PRINT_HELP=1
            break
            ;;
        *)
            echo "Unrecognized command $1."
            PRINT_HELP=1
            break
            ;;
    esac
    shift
done


if [ -v PRINT_HELP ]; then
    echo "Usage: $0 [options] command"
    echo "Takes a screenshot of a particular part of the screen and saves it to a png file in /tmp. Requires ImageMagick and, optionally, xclip and xdg-open."
    echo -e '\ncommands:'
    echo -e '\tselect             \tselect a rectangle or window interactively.'
    echo -e '\tcurrent            \tscreenshot the current window.'
    echo -e '\tall|root           \tscreenshot the whole X display.'
    echo -e '\noptions:'
    echo -e '\t-h, --help         \tprint this help text and do nothing else.'
    echo -e '\t-f, --file filename\tsave screenshot in filename instead.'
    echo -e '\t-x, --xdg-open     \topen screenshot with xdg-open.'
    echo -e '\t-c, --clipboard    \tuse xclip to copy screenshot to clipboard.'
    exit
fi

echo "a"

if ! [ -v OUTFILE ]; then
    OUTFILE=$(mktemp /tmp/scrsht.XXXXXXX.png)
fi

case $COMMAND in
    select)
        magick x: "png:$OUTFILE"
        ;;
    current)
        id=$(xprop -root _NET_ACTIVE_WINDOW | sed 's/.*\(0x\)/\1/')
        magick "x:$id" "png:$OUTFILE"
        ;;
    all|root)
        magick x:root "png:$OUTFILE"
        ;;
    *)
        echo "Unrecognized command $1."
        ;;
esac

echo "Screenshot saved as $OUTFILE."

if [ -v CLIPBOARD ]; then
    xclip -t image/png -se c -i "$OUTFILE"
fi

if [ -v XDG_OPEN ]; then
    xdg-open "$OUTFILE"
fi

#if [ -a $OUTFILE ]; then
#    echo "$OUTFILE"
#    xdg-open "$OUTFILE"
#fi

#if [ "$1" = "select" ]; then
#    magick x: png:- | xclip -t image/png -se c -i
#elif [ "$1" = "current" ]; then
#    id=$(xprop -root _NET_ACTIVE_WINDOW | sed 's/.* //')
#    magick "x:$id" png:- | xclip -t image/png -se c -i
#elif [ "$1" = "all"
#fi

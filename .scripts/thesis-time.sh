#!/usr/bin/bash

if [[ -z $THESIS_FILE ]]; then 
    THESIS_NAME="TCC"
    THESIS_DIR="$HOME/MEGA/Academico/TCC/TCC"
    THESIS_FILE="TCC-Guilherme-Felix"
elif [[ -z $THESIS_DIR ]]; then
    THESIS_DIR="$PWD"
elif [[ -z $THESIS_NAME ]]; then
    THESIS_NAME="thesis"
fi

if [[ -z $PDF_PREVIEWER ]]; then
    PDF_PREVIEWER="zathura"
fi

if [[ -z $EDITOR ]]; then
    EDITOR="nano"
fi

tmux new-session -d -c "$THESIS_DIR" -s "$THESIS_NAME" -n "preview" "$PDF_PREVIEWER $THESIS_FILE.pdf"
tmux move-window -s "$THESIS_NAME:1" -t "$THESIS_NAME:10"
tmux split-window -t "$THESIS_NAME:10" -h -c "$THESIS_DIR" "latexmk -xelatex -pvc"
tmux new-window -t "$THESIS_NAME:1" -c "$THESIS_DIR" -n "write" "$EDITOR $THESIS_FILE.tex" 
tmux new-window -t "$THESIS_NAME:2" -d -c "$THESIS_DIR"

case $1 in 
    "setup")
        ;;
    *)
        tmux attach;;
esac

#!/usr/bin/bash
LOGFILE=/var/log/SSDtrim

decho() {
    echo "$(date +"[%d-%m-%Y %H:%M:%S]") $1"
}

fdecho() {
    while read -r line 
    do
        decho "$line"
    done <"$1"
}

TMPOUT=$(mktemp /tmp/trimOUTXXXX)
TMPERR=$(mktemp /tmp/trimERRXXXX)

decho "Beginning fstrim" >> "$LOGFILE"
fstrim -v / > "$TMPOUT" 2> "$TMPERR"
TRIMSTAT=$?

if [ $TRIMSTAT -ne 0 ]
then
    decho "fstrim failed" >> "$LOGFILE"
    if [ ! -s "$TMPERR" ] && [ ! -s "$TMPOUT" ]
    then
        decho "No output" >> "$LOGFILE"
    else
        if [ -s "$TMPERR" ]
        then
            decho "---------- stderr -----------" >> "$LOGFILE"
            fdecho "$TMPERR" >> "$LOGFILE"
        else
            decho "No stderr captured" >> "$LOGFILE"
        fi
        if [ -s "$TMPOUT" ]
        then
            decho "---------- stdout -----------" >> "$LOGFILE"
            fdecho "$TMPOUT"
        fi
        decho "-------- end output ---------" >> "$LOGFILE"
    fi
else
    fdecho "$TMPOUT" >> "$LOGFILE"
    test -s "$TMPERR" && fdecho "$TMPERR" >> "$LOGFILE"
    decho "Trimming done" >> "$LOGFILE"
fi

exit $TRIMSTAT

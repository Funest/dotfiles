#!/usr/bin/bash

MEGA_COMMAND='mega-sync --output-cols=RUN_STATE,STATUS,ERROR'

MEGA_STATUS=$(awk     '
    BEGIN { active_syncs = 0; 
            synced = 0; 
            noerr = 0 } 
    $1 == "Running" { active_syncs++ } 
    $1 == "Running" && $2 == "Synced" { synced++ } 
    $1 == "Running" && $3 == "NO" { noerr++; } 
    END { 
        errors = active_syncs - noerr;
        unsynced = active_syncs - synced;
        if (errors != 0)
            print "2"
        else {
            if (unsynced != 0)
                print "1" 
            else 
                print "0" }
    }' <($MEGA_COMMAND))

GOODCOLOR='#b8bb26'
WARNCOLOR='#fabd2f'
ERRCOLOR='#fb4934'

echo -n '%{F'

if [ $MEGA_STATUS -eq 0 ]; then
    echo -n "$GOODCOLOR"'}Synced'
elif [ $MEGA_STATUS -eq 1 ]; then
    echo -n "$WARNCOLOR"'}Syncing'
else
    echo -n "$ERRCOLOR"'}ERROR'
fi

echo '%{F-}'

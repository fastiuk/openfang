#!/bin/sh

. /opt/scripts/common_functions.sh
night_mode $1 # comment this line when test

# TODO: test
# fix: autonight sends disable/enable every time it starts. not good
TIMER_PID_FILE=/tmp/nm_pid

if [ ! -f $TIMER_PID_FILE ]; then
    night_mode $1
    (
        sleep 60
        rm $TIMER_PID_FILE
    ) &
    echo $! > $TIMER_PID_FILE
else
    kill -9 "$(cat $TIMER_PID_FILE)"
    (
        sleep 60
        night_mode $1
        rm $TIMER_PID_FILE
    ) &
    echo $! > $TIMER_PID_FILE
fi

#!/bin/bash
START_M=$(date +%s%N)
START_S=$(date +%s)
if [ -n "$1" ]; then
    if [ $# -gt 1 ]; then
	echo "Too many options"
    elif [ -d $1 ]; then
        ARG=$1
    	if [ "${ARG:$((${#ARG}-1)):1}" = "/" ]; then
            ./info.sh $1
            END_M=$(date +%s%N)
            END_S=$(date +%s)
            DIFF_M=$((($END_M - $START_M)/10000000))
            DIFF_S=$(( $END_S - $START_S ))
            echo "Script execution time (in seconds) = $DIFF_S.$DIFF_M"
        else
            echo "Last char is not '/'"
        fi
    else
        echo "$1 is not directory"
    fi
else
    echo "No parameters found"
fi

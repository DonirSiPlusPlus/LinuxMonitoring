#!/bin/bash
if [ -n "$1" ]; then
    if [ $# -gt 1 ]; then
        echo "Too many options" 
    elif [[ $1 =~ ^[0-9]*$ ]]; then
	echo "Incorrect input"
    else
        echo "$1"
    fi
else
    echo "No parameters found"
fi

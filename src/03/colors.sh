#!/bin/bash
LB="\033[107m"
LF="\033[97m"
RB="\033[107m"
RF="\033[97m"
if [ $1 -eq 2 ]; then
    LB="\033[41m"
elif [ $1 -eq 3 ]; then
    LB="\033[42m"
elif [ $1 -eq 4 ]; then
    LB="\033[44m"
elif [ $1 -eq 5 ]; then
    LB="\033[45m"
elif [ $1 -eq 6 ]; then
    LB="\033[40m"
fi

if [ $2 -eq 2 ]; then
    LF="\033[31m"
elif [ $2 -eq 3 ]; then
    LF="\033[32m"
elif [ $2 -eq 4 ]; then
    LF="\033[34m"
elif [ $2 -eq 5 ]; then
    LF="\033[35m"
elif [ $2 -eq 6 ]; then
    LF="\033[30m"
fi

if [ $3 -eq 2 ]; then
    RB="\033[41m"
elif [ $3 -eq 3 ]; then
    RB="\033[42m"
elif [ $3 -eq 4 ]; then
    RB="\033[44m"
elif [ $3 -eq 5 ]; then
    RB="\033[45m"
elif [ $3 -eq 6 ]; then
    RB="\033[40m"
fi

if [ $4 -eq 2 ]; then
    RF="\033[31m"
elif [ $4 -eq 3 ]; then
    RF="\033[32m"
elif [ $4 -eq 4 ]; then
    RF="\033[34m"
elif [ $4 -eq 5 ]; then
    RF="\033[35m"
elif [ $4 -eq 6 ]; then
    RF="\033[30m"
fi
./info.sh $LB $LF $RB $RF

#!/bin/bash
LB=`cat colors.conf | head -n1 | tail -n1 | grep "=[0-9]*" -o | sed 's/=//'`
LF=`cat colors.conf | head -n2 | tail -n1 | grep "=[0-9]*" -o | sed 's/=//'`
RB=`cat colors.conf | head -n3 | tail -n1 | grep "=[0-9]*" -o | sed 's/=//'`
RF=`cat colors.conf | head -n4 | tail -n1 | grep "=[0-9]*" -o | sed 's/=//'`
CLB=$LB
CLF=$LF
CRB=$RB
CRF=$RF

if [ -z "${LB}" ]; then
    LB="\033[107m" && CLB="default (white)"
elif [ $LB -eq 1 ]; then
    LB="\033[107m" && CLB+=" (white)"
elif [ $LB -eq 2 ]; then
    LB="\033[41m" && CLB+=" (red)"
elif [ $LB -eq 3 ]; then
    LB="\033[42m" && CLB+=" (green)"
elif [ $LB -eq 4 ]; then
    LB="\033[44m" && CLB+=" (blue)"
elif [ $LB -eq 5 ]; then
    LB="\033[45m" && CLB+=" (purple)"
elif [ $LB -eq 6 ]; then
    LB="\033[40m" && CLB+=" (black)"
else
    LB="\033[107m" && CLB="default (white)"
fi

if [ -z "${LF}" ]; then
    LF="\033[35m" && CLF="default (purple)"
elif [ $LF -eq 1 ]; then
    LF="\033[97m" && CLF+=" (white)"
elif [ $LF -eq 2 ]; then
    LF="\033[31m" && CLF+=" (red)"
elif [ $LF -eq 3 ]; then
    LF="\033[32m" && CLF+=" (green)"
elif [ $LF -eq 4 ]; then
    LF="\033[34m" && CLF+=" (blue)"
elif [ $LF -eq 5 ]; then
    LF="\033[35m" && CLF+=" (purple)"
elif [ $LF -eq 6 ]; then
    LF="\033[30m" && CLF+=" (black)"
else
    LF="\033[35m" && CLF="default (purple)"
fi

echo "$CLB" > tmp.txt && echo "$CLF" > tmp2.txt
if [ "$(awk '{print $1}' tmp.txt)" = "$(awk '{print $1}' tmp2.txt)" ]; then
    LB="\033[107m" && CLB="default (white)"
    LF="\033[35m" && CLF="default (purple)" 
elif [ "$(awk '{print $1}' tmp.txt)" = "default" ]; then
    if [ "$(awk '{print $1}' tmp2.txt)" = "1" ]; then
        LF="\033[35m" && CLF="default (purple)"
    fi
elif [ "$(awk '{print $1}' tmp2.txt)" = "default" ]; then
    if [ "$(awk '{print $1}' tmp.txt)" = "5" ]; then
        LB="\033[107m" && CLB="default (white)"
    fi
fi

if [ -z "${RB}" ]; then    
    RB="\033[107m" && CRB="default (white)"
elif [ $RB -eq 1 ]; then
    RB="\033[107m" && CRB+=" (white)"
elif [ $RB -eq 2 ]; then
    RB="\033[41m" && CRB+=" (red)"
elif [ $RB -eq 3 ]; then
    RB="\033[42m" && CRB+=" (green)"
elif [ $RB -eq 4 ]; then
    RB="\033[44m" && CRB+=" (blue)"
elif [ $RB -eq 5 ]; then
    RB="\033[45m" && CRB+=" (purple)"
elif [ $RB -eq 6 ]; then
    RB="\033[40m" && CRB+=" (black)"
else
    RB="\033[107m" && CRB="default (white)"
fi

if [ -z "${RF}" ]; then
    RF="\033[35m" && CRF="default (purple)"
elif [ $RF -eq 1 ]; then
    RF="\033[97m" && CRF+=" (white)"
elif [ $RF -eq 2 ]; then
    RF="\033[31m" && CRF+=" (red)"
elif [ $RF -eq 3 ]; then
    RF="\033[32m" && CRF+=" (green)"
elif [ $RF -eq 4 ]; then
    RF="\033[34m" && CRF+=" (blue)"
elif [ $RF -eq 5 ]; then
    RF="\033[35m" && CRF+=" (purple)"
elif [ $RF -eq 6 ]; then
    RF="\033[30m" && CRF+=" (black)"
else
    RF="\033[35m" && CRF="default (purple)"
fi

echo "$CRB" > tmp.txt && echo "$CRF" > tmp2.txt
if [ "$(awk '{print $1}' tmp.txt)" = "$(awk '{print $1}' tmp2.txt)" ]; then
    RB="\033[107m" && CRB="default (white)"
    RF="\033[35m" && CRF="default (purple)"
elif [ "$(awk '{print $1}' tmp.txt)" = "default" ]; then
    if [ "$(awk '{print $1}' tmp2.txt)" = "1" ]; then
        RF="\033[35m" && CRF="default (purple)"
    fi
elif [ "$(awk '{print $1}' tmp2.txt)" = "default" ]; then
    if [ "$(awk '{print $1}' tmp.txt)" = "5" ]; then
        RB="\033[107m" && CRB="default (white)"
    fi
fi
./info.sh $LB $LF $RB $RF && echo "" && rm -rf tmp.txt tmp2.txt
echo "Column 1 background = $CLB"
echo "Column 1 font color = $CLF"
echo "Column 2 background = $CRB"
echo "Column 2 font color = $CRF"

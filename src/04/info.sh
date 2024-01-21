#!/bin/bash
#echo "$1 $2 $3 $4"
echo -e "$1$2HOSTNAME\033[0m = $3$4`hostname`\033[0m" 
echo -ne "$1$2TIMEZONE\033[0m = "
TIME=`timedatectl show | grep zone | sed -e 's/Timezone=//'`
timedatectl | head -n4 | tail -n1 > tmp.txt
echo -e "$3$4$TIME UTC `awk '{print $5}' tmp.txt | sed -e 's/)//'`\033[0m"
echo -e "$1$2USER\033[0m = $3$4`whoami`\033[0m" 
echo -e "$1$2OS\033[0m = $3$4`awk '{print $1" "$2" "$3}' /etc/issue | head -n1 | tail -n1`\033[0m"
echo -e "$1$2DATE\033[0m = $3$4`date +"%e %b %Y %H:%M:%S"`\033[0m"
echo -e "$1$2UPTIME\033[0m = $3$4`uptime -p`\033[0m"
echo -e "$1$2UPTIME_SEC\033[0m = $3$4`awk '{print $1}' /proc/uptime`\033[0m"
echo -e "$1$2IP\033[0m = $3$4`hostname -I | awk '{print $1}'`\033[0m"
echo -e "$1$2MASK\033[0m = $3$4`ifconfig | head -n2 | tail -n1 | awk '{print $4}'`\033[0m"
echo -e "$1$2GATEWAY\033[0m = $3$4`ip r | head -n2 | tail -n1 | awk '{print $1}'`\033[0m"
echo -en "$1$2RAM_TOTAL\033[0m = " && vmstat -s | head -n1 | tail -n1 > tmp.txt
MEM=$(bc<<<"scale=3;`awk '{print $1}' tmp.txt`/1024/1024")
if [[ $MEM == .* ]]; then
    echo -en "$3$40"
fi
echo -e "$3$4$MEM GB\033[0m"
echo -en "$1$2RAM_USED\033[0m = " && vmstat -s | head -n2 | tail -n1 > tmp.txt
USED=$(bc<<<"scale=3;`awk '{print $1}' tmp.txt`/1024/1024")
if [[ $USED == .* ]]; then
    echo -en "$3$40"
fi
echo -e "$3$4$USED GB\033[0m"
echo -en "$1$2RAM_FREE\033[0m = " && vmstat -s | head -n5 | tail -n1 > tmp.txt
FREE=$(bc<<<"scale=3;`awk '{print $1}' tmp.txt`/1024/1024")
if [[ $FREE == .* ]]; then
    echo -en "$3$40"
fi
echo -e "$3$4$FREE GB\033[0m" && df / | head -n2 | tail -n1 > tmp.txt
echo -e "$1$2SPACE_ROOT\033[0m = $3$4$(bc<<<"scale=2;`awk '{print $2}' tmp.txt`/1024") MB\033[0m"
df / | head -n2 | tail -n1 > tmp.txt
echo -e "$1$2SPACE_ROOT_USED\033[0m = $3$4$(bc<<<"scale=2;`awk '{print $3}' tmp.txt`/1024") MB\033[0m"
df / | head -n2 | tail -n1 > tmp.txt
echo -e "$1$2SPACE_ROOT_FREE\033[0m = $3$4$(bc<<<"scale=2;`awk '{print $4}' tmp.txt`/1024") MB\033[0m"
rm -rf tmp.txt 

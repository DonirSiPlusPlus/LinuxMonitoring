#!/bin/bash
FILE=`date +"%e_%m_%y_%H_%M_%S"`.status
echo -n "HOSTNAME = " > $FILE && hostname >> $FILE
echo -n "TIMEZONE = " >> $FILE
timedatectl | head -n4 | tail -n1 > tmp.txt
echo -n "`timedatectl show | grep zone | sed -e 's/Timezone=//'` UTC " >> $FILE
awk '{print $5}' tmp.txt | sed -e 's/)//' >> $FILE
echo -n "USER = " >> $FILE && whoami >> $FILE
echo -n "OS = " >> $FILE && `awk '{print $1" "$2" "$3}' /etc/issue | head -n1 | tail -n1 >> $FILE`
echo -n "DATE = " >> $FILE && date +"%e %b %Y %H:%M:%S" >> $FILE
echo -n "UPTIME = " >> $FILE && uptime -p >> $FILE
echo "UPTIME_SEC = `cat /proc/uptime | grep -o ".* "`" >> $FILE
echo -n "IP = " >> $FILE
hostname -I > tmp.txt && awk '{print $1}' tmp.txt >> $FILE
echo -n "MASK = " >> $FILE
ifconfig | head -n2 | tail -n1 > tmp.txt && awk '{print $4}' tmp.txt >> $FILE
echo -n "GATEWAY = " >> $FILE
ip r | head -n2 | tail -n1 > tmp.txt && awk '{print $1}' tmp.txt >> $FILE
echo -n "RAM_TOTAL = " >> $FILE && vmstat -s | head -n1 | tail -n1 > tmp.txt 
MEM=$(bc<<<"scale=3;`awk '{print $1}' tmp.txt`/1024/1024")
if [[ $MEM == .* ]]; then
    echo -n 0 >> $FILE
fi
echo "$MEM GB" >> $FILE
echo -n "RAM_USED = " >> $FILE && vmstat -s | head -n2 | tail -n1 > tmp.txt
USED=$(bc<<<"scale=3;`awk '{print $1}' tmp.txt`/1024/1024")
if [[ $USED == .* ]]; then
    echo -n 0 >> $FILE
fi
echo "$USED GB" >> $FILE
echo -n "RAM_FREE = " >> $FILE && vmstat -s | head -n5 | tail -n1 > tmp.txt
FREE=$(bc<<<"scale=3;`awk '{print $1}' tmp.txt`/1024/1024")
if [[ $FREE == .* ]]; then
    echo -n 0 >> $FILE
fi
echo "$FREE GB" >> $FILE
df / | head -n2 | tail -n1 > tmp.txt
SROOT=$(bc<<<"scale=2;`awk '{print $2}' tmp.txt`/1024")
echo "SPACE_ROOT = $SROOT MB" >> $FILE
df / | head -n2 | tail -n1 > tmp.txt
UROOT=$(bc<<<"scale=2;`awk '{print $3}' tmp.txt`/1024")
echo "SPACE_ROOT_USED = $UROOT MB" >> $FILE
df / | head -n2 | tail -n1 > tmp.txt
FROOT=$(bc<<<"scale=2;`awk '{print $4}' tmp.txt`/1024") && rm -rf tmp.txt
echo -n "SPACE_ROOT_FREE = $FROOT MB" >> $FILE
echo ""	>> $FILE
cat $FILE && echo ""
echo -n "Save data to file? Enter 'Y' to save, 'N' - cancel: "
read -n 1 B && echo ""
if [[ "$B" = "Y" || "$B" = "y" ]]; then
    echo "Data saved"
else
    rm -rf $FILE
    echo Cancel 
fi

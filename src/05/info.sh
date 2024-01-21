#!/bin/bash
DIRS=0
for dir in `find $1 -type d`;  do
    if [ ! $dir = $1 ]; then
        let DIRS++
    fi
done
echo "Total number of folders (including all nested ones) = $DIRS"
echo "TOP 5 folders of maximum size arranged in descending order (path and size): "
ls -lSh $1 | grep "^d" > tmp.txt
WC=`cat tmp.txt | wc -l`
if [ $WC -gt 5 ]; then
    WC=5
fi
for (( i=1; i<="$WC"; i++ )); do
    echo -n "$i - $1"
    as=`awk '{print $9}' tmp.txt | head -n"$i" | tail -n1` && echo -n $as/
    awk '{print ", "$5}' tmp.txt | head -n"$i" | tail -n1 && let ST++
done
if [ $WC -lt 5 ]; then
    echo "etc up to 5"
fi
FILS=0 && rm -rf tmp.txt
for files in `find $1 -maxdepth 1 -type f`; do
    let FILS++
done
echo "Total number of files = $FILS"
echo "Number of:" && rm -rf tmp.txt
CONF=0 && TXT=0 && SH=0 && LOG=0 && ARC=0 && LIN=0
for file in `find $1 -maxdepth 1`; do
    if [ ! $file = "./" ]; then
        if [[ $file =~ ".conf"$ ]]; then
            let CONF++
        elif [[ $file =~ ".txt"$ ]]; then
            let TXT++
        elif [[ $file =~ ".log"$ ]]; then
            let LOG++
        elif [[ $file =~ ".gz"$ ]]; then
            let ARC++
        elif [[ $file =~ ".bz2"$ ]]; then
            let ARC++
        elif [ -x $file ]; then
            if [ -f $file ]; then
		if [ ! -h $file ]; then
                    #echo $file
		    let SH++
		fi
            fi
        fi
    fi
done
for links in `find $1 -maxdepth 1 -type l`; do
    let LIN++
done
echo "Configuration files (with the .conf extension) = $CONF"
echo "Text files = $TXT"
echo "Executable files = $SH"
echo "Log files (with the extension .log) = $LOG"
echo "Archive files = $ARC"
echo "Symbolic links = $LIN"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
rm -rf tmp.txt && WC=`ls -laSh $1 | grep "^-" | wc -l`
if [ $WC -gt 10 ]; then
    WC=10
fi
ls -laSh $1 | grep "^-" > tmp.txt
for (( i=1; i<="$WC"; i++ )); do
    if [ ! $(awk '{print $9}' tmp.txt | head -n"$i" | tail -n1)  = ".{1,2}" ]; then
        echo -n "$i - $1"
        fs=`awk '{print $9", "$5}' tmp.txt | head -n"$i" | tail -n1`
        EXST=`awk '{print $9}' tmp.txt | head -n"$i" | tail -n1 | grep -o "\.[a-zA-Z]*$" | sed 's/.//'`
        if [ -z "${EXST}" ]; then
            EXST=`file -b $1$(awk '{print $9}' tmp.txt | head -n"$i" | tail -n1)`
    	fi
        echo "$fs, $EXST" && let ST++
    fi
done
if [ $WC -eq 0 ]; then
    echo "No files"
elif [ $WC -lt 10 ]; then
    echo "etc up to 10"
fi
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
rm -rf tmp.txt && ls -lSh $1 | sort -rk5 | grep "^-" > tmp.txt
WC=`cat tmp.txt | wc -l`
I=1
for (( i=1; i<="$WC"; i++ )); do
    FILE=`awk '{print $9}' tmp.txt | head -n"$i" | tail -n1`
    if [ -x $1$FILE ]; then
	if [ -f $1$FILE ]; then
	    echo -n "$I - $1$FILE" && let I++
       	    fs=`awk '{print ", "$5}' tmp.txt | head -n"$i" | tail -n1`
	    HASH=`md5sum $1$FILE | awk '{print $1}'`
            echo "$fs, $HASH" && let ST++
            if [ $I -gt 10 ]; then
                break
            fi
	fi
    fi
done
if [ $I -eq 1 ]; then
    echo "No executable files"
elif [ $I -lt 10 ]; then
    echo "etc up to 10"
fi
rm -rf tmp.txt

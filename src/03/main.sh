#!/bin/bash
if [ -n "$1" ]; then
    if [ $# -gt 4 ]; then 
        echo "Too many options" 
    elif [ $# -lt 4 ]; then
        echo "Too few arguments"
    elif grep -q "[^0-9]" <<< "$1"; then
        echo "Incorrect input"
    elif grep -q "[^0-9]" <<< "$2"; then
        echo "Incorrect input"
    elif grep -q "[^0-9]" <<< "$3"; then
        echo "Incorrect input"
    elif grep -q "[^0-9]" <<< "$4"; then
        echo "Incorrect input"
    elif [ $1 -lt 1 ]; then
        echo "Incorrect input"
    elif [ $1 -gt 6 ]; then
        echo "Incorrect input"
    elif [ $2 -lt 1 ]; then
        echo "Incorrect input"
    elif [ $2 -gt 6 ]; then
        echo "Incorrect input"
    elif [ $3 -lt 1 ]; then
        echo "Incorrect input"
    elif [ $3 -gt 6 ]; then
        echo "Incorrect input"
    elif [ $4 -lt 1 ]; then
        echo "Incorrect input"
    elif [ $4 -gt 6 ]; then
        echo "Incorrect input"
    elif [ $1 -eq $2 ]; then
        echo "Цвет и фон названий значений совпадает"
    	echo -n "Запустить скрипт заново с новыми параметрами? Нажмите 'Y' чтобы запустить, 'N' - отмена: " && read -n 1 B && echo ""
	if [[ "$B" = "Y" || "$B" = "y" ]]; then
	    echo "Введите новые параметры скрипта"
    	    read -p "./main.sh " A B C D
	    ./main.sh $A $B $C $D
	fi
    elif [ $3 -eq $4 ]; then
        echo "Цвет и фон значений совпадает:"
        echo -n "Запустить скрипт заново с новыми параметрами? Нажмите 'Y' чтобы запустить, 'N' - отмена: " && read -n 1 B && echo ""
        if [[ "$B" = "Y" || "$B" = "y" ]]; then
            echo "Введите новые параметры скрипта:"
            read -p "./main.sh " A B C D
            ./main.sh $A $B $C $D
        fi
    else
        ./colors.sh $@
    fi
else
    echo "No parameters found"
fi

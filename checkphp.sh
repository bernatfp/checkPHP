#!/bin/bash
#
#Autor: Bernat Fages
#

echo -e "\033[00m"

if [ "$1" == "-l" ] 
then
	echo "Output log PHP"
	cat /Applications/MAMP/logs/php_error.log

elif [ $# -eq 0 ] 
then
	echo "Comprovant errors de sintaxi..."
	num=`find ./ -name '*.php' | wc -l | sed 's/ //g'`
	let i=0
	for file in `find ./ -name '*.php' | sed 's/\/\//\//g'`
	do
		let i=i+1
		echo "[$i/$num]$file:"
		output=`php -l $file`
		if [[ "$output" =~ ^"No syntax errors" ]]
		then
			echo -e "[\033[00;32mOK\033[00m]"
		else
			echo -e "[\033[00;31mFAIL\033[00m] $output"
		fi
	done
	echo ""
else
	echo "Usage:"
	echo "	./checkphp.sh [-l]"
	echo ""
	echo "	[-l] show PHP error log"
	echo "	No parameters means syntax checking"
	echo ""
fi

exit 0

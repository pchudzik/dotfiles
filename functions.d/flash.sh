#!/bin/bash

# Alows to play flash files in external player or throught dlna server
# Flash file MUST be loaded in firefox!
# for play it's not required to fully load file
# for dlna or cp file should be loaded fully inot memory
# if there is more than one file loaded in firefox all files will be played/copied
# when using dlna please remeber to manully add WIDEO_DIR to directory served by PMS
function flash() {
	PLAYER="vlc -q "

	#Play station media server is required to run: http://www.ps3mediaserver.org/
	PS3_SRV="/home/pawel/Tools/pms/PMS.sh"
	WIDEO_DIR="/home/pawel/Wideo/flash"

	echo "Select firefox window"
	FIREFOX_PID=`xprop _NET_WM_PID | cut -d' ' -f3`
	FLASH_PID=`ps auxwww | grep flash | grep $FIREFOX_PID | awk -F' ' '{print $2}'`
	FLASH_FILES=`ls -l /proc/$FLASH_PID/fd | grep Flash | awk -F ' ' '{print $9}'`

	FILES=()
	for FLASH_FILE in $FLASH_FILES ; do
		FILES+=("/proc/$FLASH_PID/fd/$FLASH_FILE")
	done

	if [ $1 = 'play' ]; then
		for FILE in ${FILES[@]} ; do
			echo "playing file $FILE with $PLAYER"
			(`$PLAYER "$FILE"` &> /dev/null)&
		done
	elif [ $1 = 'cp' ]; then
		for i in ${!FILES[@]}; do
			FILE="${FILES[$i]}"
			if [ -d $2 ]; then
				DST="$2/$FILE_$(($i+1)).flv"
			else
				DST="$2"
			fi
			debug "Copy $FILE to $DST"
			cp $FILE $DST
		done
	elif [ $1 = 'dlna' ]; then
		mkdir -p "$WIDEO_DIR"
		for i in ${!FILES[@]}; do
			FILE=${FILES[$i]}
			DST="$WIDEO_DIR/$FILE_$(($i+1)).flv"
			echo "copy $FILE to $DST"
			cp "$FILE" "$DST"
		done
		echo "you can close browser and start tv. Select ps 3 media server as input device"
		`$PS3_SRV` &> /dev/null
	else
		echo "Usage:"
		echo "flash play to play file with vlc"
		echo "flash cp destination to copy file to destination"
		echo "flash dlna to start media server with file"
	fi
}

function _flash() {
	local current=${COMP_WORDS[COMP_CWORD]}
	OPTS="play dlna cp"
	COMPREPLY=( $(compgen -W "${OPTS}" -- ${current}) )
}
complete -F _flash flash

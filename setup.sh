#!/bin/bash
function backupOriginal() {
	FILE=$1;
	BACKUP="$FILE.bak"
	if [ -f "$FILE" ]; then
		mv "$FILE" "$BACKUP"
		echo "$FILE backuped in $BACKUP"
	else
		echo "No original file $FILE"
	fi;
}

function addFile() {
	ORG_FILE="$1"
	MY_FILE="$2"

	backupOriginal $ORG_FILE;
	ln -s "$MY_FILE" "$ORG_FILE"
	echo "$MY_FILE linked to $ORG_FILE"
}

DIR=`pwd`
addFile "$HOME/.vimrc" "$DIR/vimrc"
addFile "$HOME/.gitconfig" "$DIR/gitconfig"
addFile "$HOME/.gitignore" "$DIR/gitignore"

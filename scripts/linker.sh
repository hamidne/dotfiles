#!/bin/bash
set -e

function backup() {
    # check existance of the directory or the file and ask for confirmation
    if ( [ "$1" = "directory" ] && [ -d "$2" ] ) || ( [ "$1" = "file" ] && [ -f "$2" ] ); then
        read -n1 -p "Backup existing "$2" "$1"? ([y]es / [n]o)" confirmation
    else
        return # return the function if the directory or the file doesn't exists.
    fi

    # backup if confirmed
    if [[ $confirmation == "y" || $confirmation == "Y" ]]; then
        cp -rf $2 "$2.backup" 2> /dev/null 
    fi

    # remove original directory or file anyway
    rm -rf $2
}

backup "directory" ~/Develop/test.backup

#!/bin/bash

# backup existing files and directories
# parameter 1: type of the backup ( "directory" / "file" ) - string - required
# parameter 2: path to the config file or directory - string - required
function backup() {
    # check existance of the directory or the file
    if ( [ "$1" = "directory" ] && [ ! -d "$2" ] ) || ( [ "$1" = "file" ] && [ ! -f "$2" ] ); then
        return # return if the directory or the file doesn't exists.
    fi

    # ask for confirmation
    read -n1 -ep "Backup existing "$2" "$1"? ([y]es / [n]o) " confirmation

    # backup if confirmed
    if [[ $confirmation == "y" || $confirmation == "Y" ]]; then
        cp -rf $2 "$2.backup" 2> /dev/null 
    fi

    # remove original directory or file anyway
    rm -rf $2
}

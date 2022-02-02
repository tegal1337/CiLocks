#!/usr/bin/env bash

config() {
    echo -e "Detect Installed Package";
    clear

    if ! msfconsole -v COMMAND &> /dev/null; then
        echo "msfconsole could not be found";
        exit 1;
    else
        xterm -T "☣ INSTALL SEARCHSPLOIT ☣" -geometry 100x30 -e "sudo apt-get install msfconsole -y"
        if ! msfconsole -v COMMAND &> /dev/null; then
            echo "failed install";
            exit 1;
        else
            echo "sucess";
            exit 1;
        fi
    fi
}

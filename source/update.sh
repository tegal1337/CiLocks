#!/usr/bin/env bash

update() {
    # Remove old version
    rm -f "$(pwd)/cilocks.sh" >/dev/null 2>&1
    rm -f "$(pwd)/utils/config.sh" >/dev/null 2>&1
    rm -f "$(pwd)/utils/os.sh" >/dev/null 2>&1

    # Update new release
    wget https://raw.githubusercontent.com/tegal1337/CiLocks/main/cilocks.sh -O "$(pwd)/cilocks.sh" >/dev/null 2>&1
    wget https://raw.githubusercontent.com/tegal1337/CiLocks/main/utils/config.sh -O "$(pwd)/utils/config.sh" >/dev/null 2>&1
    wget https://raw.githubusercontent.com/tegal1337/CiLocks/main/utils/os.sh -O "$(pwd)/utils/os.sh" >/dev/null 2>&1

    # Give permission
    do_chmod "$(pwd)" "$1" "$2"

    # Success log and do sleep for 3 second to show the logs
    echo "Done!"
    echo "Restarting Cilocks..."

    # Do sleep for user to read the log
    sleep 4

    # Call main script
    files "$(pwd)" "$3"
}

#!/usr/bin/env bash

# Import or call other script
# source utils/colors
source utils/os.sh
source utils/menu.sh
source utils/files.sh
source utils/banner.sh
source utils/do_chmod.sh
source utils/permission.sh
source utils/requirements.sh
source utils/adb_connection.sh

source source/adb_toolkit.sh
source source/brute_pin_4_digit.sh
source source/brute_pin_6_digit.sh
source source/brute_pin_wordlist.sh
source source/root_android_supersu.sh
source source/bypass_lockscreen_antiguard.sh

# Declare readonly variable
readonly VERSION="v2.1"
readonly FILE_NAME="cilocks.sh"
readonly UTILS_DIR="utils/*.sh"
readonly SOURCE_DIR="source/*.sh"

# Check if permission is root
is_root_user
ROOT_STATUS=$?
if [[ $ROOT_STATUS == 1 ]]; then
    echo "You need to run this script as a root user."
    exit 1
fi

# Show banner
banner "$VERSION"

# Banner loading
banner_os "$VERSION"

# Check os
check_os

# Check requirements
requirements

# Show banner
banner "$VERSION"

# Show menu
menu

# Get lastest return value(we got it from menu)
SELECTED_MENU=$?

if [[ $SELECTED_MENU == 1 ]]; then
    # Remove old version
    rm -f "$(pwd)/cilocks.sh" >/dev/null 2>&1
    rm -f "$(pwd)/utils/config.sh" >/dev/null 2>&1
    rm -f "$(pwd)/utils/os.sh" >/dev/null 2>&1

    # Update new release
    wget https://raw.githubusercontent.com/tegal1337/CiLocks/main/cilocks.sh -O "$(pwd)/cilocks.sh" >/dev/null 2>&1
    wget https://raw.githubusercontent.com/tegal1337/CiLocks/main/utils/config.sh -O "$(pwd)/utils/config.sh" >/dev/null 2>&1
    wget https://raw.githubusercontent.com/tegal1337/CiLocks/main/utils/os.sh -O "$(pwd)/utils/os.sh" >/dev/null 2>&1

    # Give permission
    do_chmod "$(pwd)" "$UTILS_DIR" "$SOURCE_DIR"

    # Success log and do sleep for 3 second to show the logs
    echo "Done!"
    echo "Restarting Cilocks..."

    # Do sleep for user to read the log
    sleep 4

    # Call main script
    files "$(pwd)" $FILE_NAME

elif [[ $SELECTED_MENU == 2 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        brutepin4digit
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 3 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        brutepin6digit
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 4 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        brutepinwordlist
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 5 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        bypasslockscreenantiguard
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 6 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        rootandroidsupersu
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 7 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        adbtoolkit
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 99 ]]; then
    # Clear terminal
    clear

    # Show messages
    echo "successfuly exit, goodbye!"

    # Sleep for 2 second
    sleep 2

    # Clear terminal
    clear

    # Exit from terminal
    exit 1
else
    # Call main script
    files "$(pwd)" $FILE_NAME
fi

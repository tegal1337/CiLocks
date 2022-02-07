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
    source source/update.sh
    update "$UTILS_DIR" "$SOURCE_DIR" $FILE_NAME

elif [[ $SELECTED_MENU == 2 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        source source/brute_pin_4_digit.sh
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
        source source/brute_pin_6_digit.sh
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
        source source/brute_pin_wordlist.sh
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
        source source/bypass_lockscreen_antiguard.sh
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
        source source/root_android_supersu.sh
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
        source source/adb_toolkit.sh
        adbtoolkit
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 8 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        source source/factory_reset.sh
        factoryreset
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 9 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        source source/remove_lockscreen.sh
        removelockscreen
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 10 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        source source/metasploit.sh
        metasploit
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 11 ]]; then
    source source/control_android.sh
    controlandroid

elif [[ $SELECTED_MENU == 12 ]]; then
    check_adb_connection
    ADB_CONNECTION=$?

    if [[ $ADB_CONNECTION == 0 ]]; then
        source source/phone_info.sh
        phoneinfo
    else
        clear
        echo "No device attached, please connect your phone/emulator through adb"

        # Do sleep for user to read the log
        sleep 4

        # Call main script
        files "$(pwd)" $FILE_NAME
    fi

elif [[ $SELECTED_MENU == 13 ]]; then
    source source/ip_logger.sh
    iplogger

elif [[ $SELECTED_MENU == 14 ]]; then
    source source/get_webcam.sh
    getwebcam

elif [[ $SELECTED_MENU == 15 ]]; then
    source source/firestore_vulnerability.sh
    firestorevulnerability

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

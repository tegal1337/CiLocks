#!/usr/bin/env bash

# source utils/colors
source utils/menu.sh
source utils/files.sh
source utils/banner.sh
source utils/config.sh
source utils/do_chmod.sh
source utils/permission.sh
source utils/adb_connection.sh

source source/adb_toolkit.sh
source source/brute_pin_4_digit.sh
source source/brute_pin_6_digit.sh
source source/brute_pin_wordlist.sh
source source/root_android_supersu.sh
source source/bypass_lockscreen_antiguard.sh

readonly VERSION="v2.1"
readonly FILE_NAME="cilocks.sh"
readonly UTILS_DIR="utils/*.sh"
readonly SOURCE_DIR="source/*.sh"

is_root_user
ROOT_STATUS=$?

if [[ $ROOT_STATUS == 1 ]]; then
    echo "You need to run this script as a root user."
    exit 1
fi

banner "$VERSION"

# lanip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
# lanip6=$(ip addr | grep 'state UP' -A4 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
# publicip=$(dig +short myip.opendns.com @resolver1.opendns.com)
# # host=$(host "$publicip" | awk '{print $5}' | sed 's/.$//')
# #####os
# source data/os
# sleep 1
# function os() {
#     banner
#     echo -e "${m}        Detect Your OS ${n}"
# }
# os
# sleep 0.5
# echo "Kernel: "$(uname)
# sleep 0.5
# echo $(lsb_release -i)
# sleep 0.5
# echo $(lsb_release -c)
# sleep 0.5
# echo "Your IP Address: ""$lanip"
# sleep 3
# # echo "Your IP Address (Ipv6): "$lanip6
# # sleep 0.5
# # echo "Your IP Address (Public): "$host
# # sleep 0.5

# config

# banner "$VERSION"


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
    do_chmod "$(pwd)" $UTILS_DIR $SOURCE_DIR

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
else
    # Call main script
    files "$(pwd)" $FILE_NAME
fi


#!/usr/bin/env bash

factoryreset() {
    echo -e "
  1.Fastboot
  2.Recovery
  "
    read -p "senpai@tegalsec:~# " select
    if [[ $select == 1 ]]; then
        adb reboot bootloader
        deviceConnected=konek

        if [ "$(konek)" = 'NO' ]; then
            echo "Waiting Phone..."
            adb wait-for-device
        fi

        fastboot devices
        fastboot erase userdata
        fastboot erase cache

        export deviceConnected

    elif [[ $select == 2 ]]; then
        deviceConnected=konek

        if [ "$(konek)" = 'NO' ]; then
            echo "Waiting Phone..."
            adb wait-for-device
        fi

        adb devices
        adb shell recovery --wipe_data
    else
        echo -e " Your Brain Error!"
    fi
}

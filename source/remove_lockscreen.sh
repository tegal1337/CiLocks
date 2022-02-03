#!/usr/bin/env bash

removelockscreen() {
    rem=$(adb shell su -c rm /data/system/*.key | adb reboot)
    echo "$rem"
    echo "success"

}

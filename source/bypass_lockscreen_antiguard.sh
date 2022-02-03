#!/usr/bin/env bash

bypasslockscreenantiguard() {
    adb shell pm list packages | grep io.kos.antiguard 2>/dev/null >/dev/null

    isInstalled=$?

    if [ $isInstalled -eq 0 ]; then
        adb uninstall io.kos.antiguard
    else
        adb install ../anti_guard/AntiGuard.apk
        adb shell am start io.kos.antiguard/.unlock
    fi
}

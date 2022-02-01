#!/usr/bin/env bash

rootandroidsupersu() {
    adb restore modules/fakebackup.ab

    command "while ! ln -s /data/local.prop /data/data/com.android.settings/a/file99 2>/dev/null; do :; done; echo 'Overwrote local.prop!';"

    if command "cat /data/local.prop"; then
        echo "Succesfully rooted!"
        echo "Requires a reboot..."

        adb reboot
        sleep 4
        adb wait-for-device

        command "mount -o rw,remount /system"

        adb push modules/su-static /system/xbin/su

        command "/data/local/tmp/busybox chown 0:0 /system/xbin/su"
        command "/data/local/tmp/busybox chmod 6777 /system/xbin/su"

        adb push modules/Superuser.apk /system/app/
        
        command "rm /data/local.prop"
        adb reboot
    fi
}
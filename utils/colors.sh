#!/usr/bin/env bash

############################## Color

colors() {
    if [[ "$1" = "r" ]]; then
        COLOR="\e[0;31m" # Red
    elif [[ "$1" = "b" ]]; then
        COLOR="\e[0;34m" # Blue
    elif [[ "$1" = "p" ]]; then
        COLOR="\e[1;31m" # Pink
    elif [[ "$1" = "g" ]]; then
        COLOR="\e[0;32m" # Green
    elif [[ "$1" = "y" ]]; then
        COLOR="\e[0;33m" # Yellow
    elif [[ "$1" = "bs" ]]; then
        COLOR="\[1;34m" # Blue sky
    elif [[ "$1" = "lg" ]]; then
        COLOR="\e[1;32m" # Light Green
    elif [[ "$1" = "tw" ]]; then
        COLOR="\e[1;37m" # Thick White
    elif [[ "$1" = "by" ]]; then
        COLOR="\e[1;33m" # Bright Yellow
    else
        COLOR="\e[0m" # Neutral
    fi
}

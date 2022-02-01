#!/usr/bin/env bash

function files() {
    # Clear old output
    clear

    # File path
    file=$1/$2;
    bash "$file"
}
#!/usr/bin/env bash

do_chmod() {
    # Source and utils path
    local utils=$1/$2;
    local source=$1/$3;

    chmod +x "$utils";
    chmod +x "$source";
}
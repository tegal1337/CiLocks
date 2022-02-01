#!/usr/bin/env bash

do_chmod() {
    # Source and utils path
    utils=$1/$2;
    source=$1/$3;

    chmod +x "$utils";
    chmod +x "$source";
}
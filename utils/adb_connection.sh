#!/usr/bin/env bash

check_adb_connection() {
    adb get-state 1>/dev/null 2>&1 && return 0 || return 1;
}

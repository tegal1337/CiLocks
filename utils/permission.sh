#!/usr/bin/env bash

is_root_user() {
    [[ $(id -u) -eq 0 ]] 1>/dev/null 2>&1 && return 0 || return 1;
}

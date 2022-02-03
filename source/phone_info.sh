#!/usr/bin/env bash

phone_info() {
    manu=$(adb shell getprop ro.product.manufacturer)
    model=$(adb shell getprop ro.product.model)
    version=$(adb shell getprop ro.build.version.release)
    sdk=$(adb shell getprop ro.build.version.sdk)
    info=$(printf "%s %s %s (API %s)" "$manu" "$model" "$version" "$sdk")
    
    echo "Info: " "$info"
    echo "Manufacturer: " "$manu"
    echo "Model: " "$model"
    echo "Version: " "$version"
    echo "Sdk: " "$sdk"
}

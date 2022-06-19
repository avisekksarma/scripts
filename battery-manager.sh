#!/usr/bin/env bash

path_img="/home/abhishek/Downloads/wallpapers/battery.jpg"
time_limit=7000
lower_limit=45
upper_limit=80
path="/sys/class/power_supply/BAT0/"
battery="$(cat $path/capacity)"
status="$(cat $path/status)"
if [[ "$battery" -gt 98 && "$status" == "Charging" ]]; then
    XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send -i $path_img -t $time_limit "Battery fully charged" "Unplug power"
    elif [[ "$battery" -gt "$upper_limit" && "$status" == "Charging" ]]; then
    XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send -i $path_img -t $time_limit  "Battery beyond current limit of $upper_limit" "Unplug power"
    elif [[ "$battery" -lt 10 && "$status" == "Discharging" ]]; then
    XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send -i $path_img -t $time_limit "Battery critically low." "Plug In Immediately."
    elif [[ "$battery" -lt 25 && "$status" == "Discharging" ]]; then
    XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send -i $path_img -t $time_limit  "Battery less than 25%" "Plug In power"
    elif  [[ "$battery" -lt "$lower_limit" && "$status" == "Discharging" ]]; then
    XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send -i $path_img -t $time_limit "Battery less than lower limit of $lower_limit"  "Plug In power"
fi

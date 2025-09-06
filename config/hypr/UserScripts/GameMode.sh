#!/bin/bash
scriptsDir="$HOME/.config/hypr/scripts"
export gaming_monitor_model="C27HG7x"
gaming_monitor_name=$(hyprctl -j monitors | jq -r '. []|select(.model == $ENV.gaming_monitor_model)|.name')
echo "$gaming_monitor_name"
nb_monitor=$(hyprctl -j monitors | jq '.|length')
if [ $nb_monitor -gt 1 ]
then
    echo "Enable Hyprland GameMode"
    $scriptsDir/GameMode.sh
    killall hyprlock
    for m in $(hyprctl -j monitors | jq -r '. []|select(.model != $ENV.gaming_monitor_model)|.name')
    do
      echo $m
      hyprctl keyword monitor $m, disable
    done
    hyprctl keyword monitor $gaming_monitor_name, 2560x1440@144, 0x0, 1
    #steam
else
    echo "Disable Hyprland GameMode"
    $scriptsDir/GameMode.sh
    hyprctl reload
    #pkill --signal SIGTERM steam
fi
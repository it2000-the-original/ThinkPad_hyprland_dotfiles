#!/bin/bash
# A script to adjust backlight using brightnessctl
# and show it using a wob pipe

# Chek the existence of the lock file
# This is to prevent the script from being
# executed multiple times at the same time

LOCKFILE="/tmp/brightness_script.lock"

if [[ -e "$LOCKFILE" ]]; then

	exit 1
fi

touch "$LOCKFILE"

get_current_value() {
	
	echo $(brightnessctl | grep "Current" | awk '{print $4}' | tr -d % | tr -d "(" | tr -d ")")
}

# Set here the minimum value that you want
min_value=1

current_value=($(get_current_value))

if [[ $1 == "--increase" || $1 == "-i" ]]; then

	brightnessctl set "$2"%+

elif [[ $1 == "--decrease" || $1 == "-d" ]]; then

	if [[ $(($current_value - $2)) -ge $min_value ]]; then

		brightnessctl set "$2"%-
	
	else

		brightnessctl set "$min_value"%
	fi
fi

# Calculating percentage to show wob progress bar
current_value=($(get_current_value))

echo $current_value > ~/.config/wob/pipes/brightnesspipe

rm -f "$LOCKFILE"

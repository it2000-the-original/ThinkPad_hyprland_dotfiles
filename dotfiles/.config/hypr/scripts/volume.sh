#!/bin/bash
# A script to adjust volume

# Chek the existence of the lock file
# This is to prevent the script from being
# executed multiple times at the same time

LOCKFILE="/tmp/volume_script.lock"

if [[ -e "$LOCKFILE" ]]; then

	exit 1
fi

touch "$LOCKFILE"

get_current_value() {
	
	echo $(pactl get-sink-volume @DEFAULT_SINK@ | grep  'Volume:' | awk '{print $5}'| tr -d '%')
}

max_value=100

current_value=($(get_current_value))

if [[ $1 == "--increase" || $1 == "-i" ]]; then

	new_value=$(($current_value + $2))

	# The new volume percentage must be lesser than max_value

	if [[ $new_value -le $max_value ]]; then

		pactl set-sink-volume @DEFAULT_SINK@ "$new_value"%

	else
		
		pactl set-sink-volume @DEFAULT_SINK@ "$max_value"%
	fi

elif [[ $1 == "--decrease" || $1 == "-d" ]]; then

	new_value=$(($current_value - $2))

	pactl set-sink-volume @DEFAULT_SINK@ "$new_value"%
fi

# Setting the pipe to show wob progres bar

current_value=($(get_current_value))

echo $current_value > ~/.config/wob/pipes/volumepipe

rm -f "$LOCKFILE"

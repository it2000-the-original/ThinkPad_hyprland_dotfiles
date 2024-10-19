#!/bin/bash

# Check if bluetooth is disabled

status=$(rfkill list bluetooth | grep "Soft blocked: yes")

if [[ -z $status ]]; then

	rfkill block bluetooth

else

	rfkill unblock bluetooth
fi

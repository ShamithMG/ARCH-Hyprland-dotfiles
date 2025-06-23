#!/bin/bash

# --- CONFIGURATION ---
CITY="London"
STATE_FILE="$HOME/.config/waybar/clock_weather_state"
CLOCK_FORMAT=" %H:%M | %a %d/%B/%Y |"
# --- END CONFIGURATION ---

if [ ! -f "$STATE_FILE" ]; then
    echo "CLOCK" > "$STATE_FILE"
fi


# Handle the --toggle argument
if [ "$1" == "--toggle" ]; then
    current_state=$(cat "$STATE_FILE")
    if [ "$current_state" == "CLOCK" ]; then
        echo "WEATHER" > "$STATE_FILE"
    else
        echo "CLOCK" > "$STATE_FILE"
    fi
    exit 0
fi

# Read the current state and display the correct information
current_state=$(cat "$STATE_FILE")

if [ "$current_state" == "CLOCK" ]; then
    # --- DEFAULT STATE: Show Clock and Current Temp ---
    time_str=$( TZ='Europe/London' date +"$CLOCK_FORMAT")
    weather_temp=$(curl -s "wttr.in/${CITY}?format=%c%t")

    echo "$time_str $weather_temp"

else
    # --- TOGGLED STATE: Show Full Weather Statement ---
    weather=$(curl -s "wttr.in/${CITY}?format=%c%C|(%t/%f)|💧%p|%w|(%S+-+%s)")
    echo "$weather"
fi

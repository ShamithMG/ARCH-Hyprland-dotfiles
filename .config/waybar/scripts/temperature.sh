#!/bin/bash

# --- CONFIGURATION ---
CITY="London"
STATE_FILE="$HOME/.config/waybar/clock_weather_state"
CLOCK_FORMAT=" %H:%M | %a %d/%B/%Y |"
TIMEOUT=3
WEATHER_CACHE_FILE="$HOME/.config/waybar/waybar_weather_cache.txt"
# --- END CONFIGURATION ---

if [ ! -f "$STATE_FILE" ]; then
    echo "CLOCK" > "$STATE_FILE"
fi


# Handle the --toggle argument
if [ "$1" == "--toggle" ]; then
    current_state=$(cat "$STATE_FILE")
    if [ "$current_state" == "CLOCK" ]; then
        echo "WEATHER" > "$STATE_FILE"
        ( sleep "$TIMEOUT" && echo "CLOCK" > "$STATE_FILE" ) &
    else
        echo "CLOCK" > "$STATE_FILE"
    fi
    exit 0
fi

# Read the current state and display the correct information
current_state=$(cat "$STATE_FILE")

# Read weather data from cache file
if [ -f "$WEATHER_CACHE_FILE" ]; then
    TEMP_ONLY_CACHED=$(head -n 1 "$WEATHER_CACHE_FILE")
    FULL_WEATHER_CACHED=$(tail -n 1 "$WEATHER_CACHE_FILE")
else
    # Fallback if cache file not found (e.g., initial run before cron job)
    TEMP_ONLY_CACHED="N/A"
    FULL_WEATHER_CACHED="N/A"
fi


if [ "$current_state" == "CLOCK" ]; then
    # --- DEFAULT STATE: Show Clock and Current Temp ---
    time_str=$(TZ="Europe/London" date +"$CLOCK_FORMAT")
    echo "$time_str $TEMP_ONLY_CACHED" # <--- CHANGED to read from cache

else # current_state is "WEATHER"
    # --- TOGGLED STATE: Show Full Weather Statement ---
    echo "$FULL_WEATHER_CACHED" # <--- CHANGED to read from cache
fi

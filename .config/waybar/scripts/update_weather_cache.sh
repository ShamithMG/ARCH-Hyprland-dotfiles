#!/bin/bash

CITY="London" # Your city
WEATHER_CACHE_FILE="$HOME/dotfiles/.config/waybar/waybar_weather_cache.txt" # Temporary file for weather

# Fetch temperature only for CLOCK state
TEMP_ONLY=$(curl -s "wttr.in/$CITY?format=%c%t")
# Fetch full weather for WEATHER state
FULL_WEATHER=$(curl -s "wttr.in/${CITY}?format=%c%C|(%t/%f)|💧%p|%w|(%S+-+%s)")

# Store both in a simple format in the cache file
echo "$TEMP_ONLY" > "$WEATHER_CACHE_FILE"
echo "$FULL_WEATHER" >> "$WEATHER_CACHE_FILE" # Append full weather on next line
#!/bin/bash

STATE_FILE="$HOME/dotfiles/.config/hypr/wallpaper_mode_state.txt"
STATIC_WALLPAPER_DIR="$HOME/Downloads/Backgrounds-home"
LIVE_WALLPAPER_DIR="$HOME/Downloads/Backgrounds-live"

DEFAULT_STATIC_WALLPAPER="$HOME/Downloads/Backgrounds-home/37.jpg"
DEFAULT_LIVE_WALLPAPER="$HOME/Downloads/Backgrounds-live/live6.mp4"

EXTRACTED_FRAME_CACHE="/tmp/video_frame_cache.png"
MONITOR_NAMES="DP-2 HDMI-A-2"

if [ ! -f "$STATE_FILE" ]; then
	echo "STATIC" > "$STATE_FILE"
fi

if pgrep -x hyprpaper; then
	pkill hyprpaper
	mpvpaper -s -o "no-audio loop vf=scale=2560:-1" "DP-3 HDMI-A-2" "$DEFAULT_LIVE_WALLPAPER" &
else 
	pkill mpvpaper
	hyprpaper &
fi


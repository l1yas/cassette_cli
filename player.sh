#!/bin/bash

MUSIC_DIR="$HOME/Music"
TRACKS=("$MUSIC_DIR"/*)
INDEX=0
PLAYER_PID=""

play_track() {
    clear
    TRACK="${TRACKS[$INDEX]}"
    echo "Now playing: $(basename "$TRACK")"
    echo "[p] Play/Pause | [n] Next | [r] Rewind | [q] Quit"
    play "$TRACK" &
    PLAYER_PID=$!
}

stop_track() {
    if [ -n "$PLAYER_PID" ]; then
        kill "$PLAYER_PID" 2>/dev/null
    fi
}

next_track() {
    stop_track
    ((INDEX++))
    if [ $INDEX -ge ${#TRACKS[@]} ]; then
        INDEX=0
    fi
    play_track
}

rewind_track() {
    stop_track
    play_track
}

pause_track() {
    if [ -n "$PLAYER_PID" ]; then
        kill -STOP "$PLAYER_PID"
    fi
}

resume_track() {
    if [ -n "$PLAYER_PID" ]; then
        kill -CONT "$PLAYER_PID"
    fi
}

IS_PAUSED=0

play_track

while true; do
    read -rsn1 key

    case "$key" in
        p)
            if [ $IS_PAUSED -eq 0 ]; then
                pause_track
                IS_PAUSED=1
                echo "Paused"
            else
                resume_track
                IS_PAUSED=0
                echo "Playing"
            fi
            ;;
        n)
            next_track
            ;;
        r)
            rewind_track
            ;;
        q)
            stop_track
            exit 0
            ;;
    esac
done

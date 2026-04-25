# Cassette Tape CLI Player

A minimalist cassette-style music player built in Bash, inspired by the tape player mechanics from Five Nights at Candy's 3, and running entirely in the terminal.


## Features

* Play audio files from your Music directory
* Pause / Resume playback
* Skip to next track
* Rewind current track
* Real-time keyboard controls (no Enter required)
* Lightweight and dependency-minimal



## Project Structure

```bash
cassette_cli/
 └── player.sh (script)  # Main executable
```



## Requirements

* bash
* sox

Install dependency:

```bash
sudo apt install play
```



## Usage

Make the script executable:

```bash
chmod +x player.sh
```

Run:

```bash
./player.sh
```


## Controls

| Key | Action       |
|---  | ------------ |
| p   | Play / Pause |
| n   | Next track   |
| r   | Rewind       |
| q   | Quit         |



## Music Directory

By default, the player uses:

```bash
$HOME/Music
```

You can modify the script to use a custom directory if needed.



## How It Works

### Background Process

Tracks are played in the background:

```bash
play "$TRACK" &
```

The process ID is stored:

```bash
PLAYER_PID=$!
```



### Signal Handling

Playback control uses Unix signals:

* SIGSTOP → pause
* SIGCONT → resume
* SIGTERM → stop



### Keyboard Input

Key presses are captured instantly:

```bash
read -rsn1 key
```

* `-r` raw input
* `-s` silent
* `-n1` one character



### Track Management

Tracks are loaded into an array:

```bash
TRACKS=("$MUSIC_DIR"/*)
```

Navigation is handled via an index pointer.


## License

Free to use, modify, and improve.


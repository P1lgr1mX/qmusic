# Easy & Quick Music CLI (ezmusic)

A lightweight, efficient command-line interface designed to stream audio from YouTube directly within your terminal. Built as a single Bash shell script, this tool eliminates the need for heavy web browsers or complex installations, providing a minimalist audio experience with minimal resource overhead.

## Key Features

* **Single-File Architecture:** Zero complex configurations. Download, configure permissions, and execute immediately.
* **Direct YouTube Streaming:** Leverages industry-standard utilities to extract and play clean audio streams.
* **Resource Efficient:** Disables video rendering entirely to conserve system RAM, CPU, and network bandwidth.
* **Standard Keyboard Controls:** Supports native `mpv` keybindings for real-time playback control inside the terminal.

## Dependencies

To ensure seamless audio streaming, please verify that your system has the following utilities installed:

* **Bash** (v4.0 or higher)
* **mpv** (Media player backend)
* **yt-dlp** (YouTube audio stream extractor)

### Installation of Dependencies

* **macOS (via Homebrew):**
  ```bash
  brew install mpv yt-dlp
  ```
* **Linux (Ubuntu/Debian):**
  ```bash
  sudo apt update && sudo apt install mpv yt-dlp -y
  ```

## Quick Start

### 1. Make the Script Executable
Before running the script for the first time, grant execution permissions by running the following command in your terminal:
```bash
chmod +x ezmusic.sh
```

### 2. Launch Playback
Execute the script and provide a valid YouTube URL as the first argument:
```bash
./ezmusic.sh "https://youtube.com"
```

## Playback Controls

While the audio is streaming, you can control playback directly through your keyboard:
* `[Space]` Pause / Resume
* `[9]` / `[0]` Decrease / Increase Volume
* `[q]` Stop playback and exit

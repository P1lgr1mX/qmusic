# 🎵 qmusic (`yt`)

<div align="center">

**A minimalist, lightning-fast background YouTube audio player for the Linux terminal.**

[![Platform](https://img.shields.io/badge/platform-Linux-blue.svg?style=flat-square)](https://www.kernel.org)
[![Shell](https://img.shields.io/badge/shell-Bash%204.0+-4EAA25.svg?style=flat-square)](https://www.gnu.org/software/bash/)
[![Engine](https://img.shields.io/badge/engine-mpv%20%2B%20yt--dlp-red.svg?style=flat-square)](https://mpv.io)
[![License](https://img.shields.io/badge/license-MIT-informational.svg?style=flat-square)](https://opensource.org/licenses/MIT)

[Overview](#-overview) • [Features](#-key-features) • [Prerequisites](#-prerequisites) • [Installation](#-installation) • [Usage](#-command-reference) • [Window Manager Shortcuts](#-window-manager-integration) • [Architecture](#-architecture)

</div>

---

## 💡 Overview

**qmusic** (invoked via the command `yt`) is an ultra-lightweight command-line YouTube music streamer engineered for speed, minimalism, and uninterrupted terminal workflows.

Unlike resource-heavy desktop apps or browser tabs, `qmusic` streams pure audio in the background and releases your terminal immediately. Playback is managed in real time through a UNIX domain IPC socket with sub-millisecond response latency.

Whether you want to play a link from your clipboard with a single keypress, search tracks via fuzzy keywords, or shuffle your saved bookmark list, `qmusic` delivers an effortless listening experience.

```bash
# Copy any YouTube link, then simply type:
$ yt

# Or search and play instantly:
$ yt lofi hip hop radio
🔍 Searching & playing: "lofi hip hop radio"
   [yt p: Pause | yt stop: Stop | yt v +5: Volume | yt --save: Save]
```

---

## ✨ Key Features

- 📋 **Zero-Touch Clipboard Playback**: Simply type `yt` and hit Enter—it auto-detects and streams YouTube URLs directly from your clipboard (native support for **Wayland** via `wl-clipboard` and **X11** via `xclip`/`xsel`).
- 🔍 **Fuzzy Keyword Search**: No need to open a web browser. Enter search terms directly (e.g. `yt chill synthwave`), and `qmusic` automatically queries and streams the top matching track.
- ⚡ **Background Daemon with Instant IPC**: Runs completely detached from your terminal session using `mpv`'s JSON IPC server. Your shell prompt is freed immediately.
- 🪶 **Low Resource & Bandwidth Friendly**: Disables video rendering entirely (`--no-video`, `--audio-display=no`, `bestaudio`), saving massive CPU cycles, RAM, and network bandwidth.
- ⭐ **Built-in Favorites Manager**: Bookmark tracks on the fly with `yt --save`, list them with `yt --fav list`, or shuffle a random favorite when you don't know what to listen to (`yt --fav`).
- 🔊 **Fine-Grained Volume Control**: Increment, decrement, or set exact volume percentages smoothly (`yt v +5`, `yt v -5`, `yt v 80`).
- 🔄 **Multi-Tool Socket Resilience**: Communicates with the MPV IPC socket using `socat`, `nc`, or a pure `python3` fallback.
- 🚀 **Runtime Acceleration**: Automatically detects and leverages `node` or `deno` runtimes for `yt-dlp` JavaScript challenge solving.

---

## 🛠 Prerequisites

`qmusic` requires a few standard Linux CLI utilities:

| Tool | Purpose | Required? |
| :--- | :--- | :--- |
| **`bash`** (≥ 4.0) | Core shell script execution | Yes |
| **`mpv`** | High-performance audio player backend | Yes |
| **`yt-dlp`** | YouTube stream resolution and extractor | Yes |
| **`socat`** or **`nc`** | UNIX domain socket IPC communication | Yes (or `python3`) |
| **`wl-clipboard`** | Wayland clipboard integration (`wl-paste`) | Recommended on Wayland |
| **`xclip`** / **`xsel`** | X11 clipboard integration | Recommended on X11 |
| **`node`** / **`deno`** | Fast JS engine for `yt-dlp` cipher solving | Optional (Recommended) |

### Quick Install Commands

#### Arch Linux / Manjaro / EndeavourOS
```bash
sudo pacman -S mpv yt-dlp socat wl-clipboard xclip
```

#### Ubuntu / Debian / Linux Mint / Pop!_OS
```bash
sudo apt update
sudo apt install mpv yt-dlp socat wl-clipboard xclip xsel -y
```

#### Fedora / RHEL
```bash
sudo dnf install mpv yt-dlp socat wl-clipboard xclip xsel -y
```

#### openSUSE
```bash
sudo zypper install mpv yt-dlp socat wl-clipboard xclip
```

> [!TIP]
> Keep `yt-dlp` up to date to prevent YouTube extraction breakages:
> ```bash
> yt-dlp -U # or: sudo pip install -U yt-dlp
> ```

---

## 🚀 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/P1lgr1mX/qmusic.git
   cd qmusic
   ```

2. **Grant execution permissions:**
   ```bash
   chmod +x yt
   ```

3. **Symlink to your binary path (e.g., `~/.local/bin`):**
   ```bash
   mkdir -p ~/.local/bin
   ln -sf "$(pwd)/yt" ~/.local/bin/yt
   ```

4. **Verify installation:**
   ```bash
   yt --help
   ```

*(Ensure `~/.local/bin` is in your `$PATH`. If not, append `export PATH="$HOME/.local/bin:$PATH"` to your `~/.bashrc` or `~/.zshrc`).*

---

## 📖 Command Reference

### 🎵 Playback & Search

| Command | Description | Example |
| :--- | :--- | :--- |
| `yt` | Automatically reads YouTube URL from clipboard and starts playback | `yt` |
| `yt <keywords>` | Searches YouTube and plays the top match (quotes optional) | `yt synthwave radio` |
| `yt <URL>` | Plays directly from a YouTube or YouTube Music link | `yt https://youtu.be/...` |

### ⏯️ Playback Control

| Command | Aliases | Description |
| :--- | :--- | :--- |
| `yt p` | `yt pause`, `yt resume` | Toggle Pause / Resume |
| `yt stop` | `yt q`, `yt quit` | Stop playback and terminate background daemon |
| `yt status` | `yt now`, `yt info` | Display current track title, URL, state, and volume |

### 🔊 Volume Management

| Command | Description | Example |
| :--- | :--- | :--- |
| `yt v` | Display current volume percentage | `yt v` |
| `yt v +5` / `yt v +` | Increase volume (+5%) | `yt v +10` |
| `yt v -5` / `yt v -` | Decrease volume (-5%) | `yt v -10` |
| `yt v <0-130>` | Set specific volume level | `yt v 85` |

### ⭐ Favorites & Bookmarks

Tracks are stored locally in plain text format at `~/.config/qmusic/fav.txt`.

| Command | Description |
| :--- | :--- |
| `yt --save` | Bookmark the currently playing song |
| `yt --save <URL>` | Bookmark a specific YouTube link |
| `yt --fav` | Play a random song from your saved favorites list |
| `yt --fav list` | Print all saved favorite tracks |

---

## ⌨️ Window Manager Integration

Because `qmusic` commands are non-blocking and return instantly, you can bind them directly to multimedia keys or custom shortcuts in your window manager.

### Hyprland (`~/.config/hypr/hyprland.conf`)
```ini
# Play/Pause and Stop
bind = , XF86AudioPlay, exec, yt p
bind = , XF86AudioStop, exec, yt stop

# Volume control
bind = , XF86AudioRaiseVolume, exec, yt v +5
bind = , XF86AudioLowerVolume, exec, yt v -5

# Play from clipboard
bind = $mainMod, M, exec, yt
```

### i3 / Sway (`~/.config/i3/config` or `~/.config/sway/config`)
```i3config
# Media keys
bindsym XF86AudioPlay exec yt p
bindsym XF86AudioRaiseVolume exec yt v +5
bindsym XF86AudioLowerVolume exec yt v -5

# Quick play from clipboard
bindsym $mod+m exec yt
```

---

## 🏗 Architecture

`qmusic` operates on a client-daemon architecture:

```
+--------------------+
|     User / CLI     |  --->  yt [query / command]
+--------------------+
          |
          v
+--------------------+          JSON IPC           +------------------------+
|   qmusic script    | ------------------------->  |       mpv Daemon       |
|    (Dispatcher)    | <-------------------------  | (runs in background)   |
+--------------------+      /tmp/mpv-socket        +------------------------+
          |                                                    |
          |                                                    v
          +------------> Reads Clipboard              Streams audio via
                         (Wayland / X11)             bestaudio / yt-dlp
```

- **IPC Socket**: `/tmp/mpv-socket`
- **PID File**: `/tmp/mpv-qmusic.pid`
- **Daemon Log**: `/tmp/qmusic.log`
- **Favorites Store**: `~/.config/qmusic/fav.txt`

---

## ❓ Troubleshooting

<details>
<summary><b>Audio stops or fails to stream YouTube links</b></summary>

YouTube frequently updates its internal streaming APIs. Ensure your `yt-dlp` package is on the newest release:
```bash
yt-dlp -U
```
If you encounter JavaScript challenge warnings, install `nodejs` or `deno` on your system.
</details>

<details>
<summary><b>Clipboard playback does not find link</b></summary>

Verify that your clipboard utility is installed and functional:
- On **Wayland**: test with `wl-paste`
- On **X11**: test with `xclip -selection clipboard -o` or `xsel -b -o`
</details>

<details>
<summary><b>How to view background playback logs</b></summary>

Check the daemon log file for detailed MPV and yt-dlp output:
```bash
tail -f /tmp/qmusic.log
```
</details>

---

## 🤝 Contributing

Contributions, bug reports, and suggestions are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/cool-feature`)
3. Commit your changes (`git commit -m "feat: add cool feature"`)
4. Push to the branch (`git push origin feature/cool-feature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the [MIT License](https://opensource.org/licenses/MIT). Feel free to use and modify it.

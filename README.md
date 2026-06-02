# 🎯 TrackIR 5 for Nuclear Option on Linux / Proton

Use a **NaturalPoint TrackIR 5** camera with **Nuclear Option** on Linux through
Steam/Proton.

This project packages the LinuxTrack + Proton bridge setup that makes Nuclear
Option see TrackIR as a normal NaturalPoint `NPClient64.dll` device.

## ✨ What This Does

- Builds LinuxTrack from the maintained `exuvo/linuxtrack` fork.
- Installs TrackIR 5 USB permissions through a udev rule.
- Adds a Nuclear Option LinuxTrack profile and NaturalPoint game ID entry.
- Builds and installs a Proton-compatible `NPClient64.dll` / `NPClient.dll`.
- Adds bridge-level recenter and pause/resume control.
- Mirrors pause state to the TrackIR 5 status LED, matching the familiar
  Windows TrackIR behavior.

## 🚫 What This Does Not Do

- It does not include NaturalPoint firmware, NaturalPoint software, or
  proprietary NaturalPoint DLLs.
- It does not require a Steam launch option for TrackIR.

## ✅ Tested Setup

| Item | Value |
| --- | --- |
| Game | Nuclear Option |
| Steam app ID | `2168680` |
| TrackIR camera | TrackIR 5, USB ID `131d:0158` |
| Clip | TrackClip Pro |
| Proton prefix | `~/.local/share/Steam/steamapps/compatdata/2168680/pfx` |
| Game directory | `~/.local/share/Steam/steamapps/common/Nuclear Option` |
| Desktop tested | Cinnamon/X11 |

Other Linux desktops should work, but desktop-level shortcut setup may differ.

## 📦 Install

Install build dependencies first. On Debian/Ubuntu-like systems:

```bash
sudo apt install git build-essential autoconf automake libtool pkg-config \
  libusb-1.0-0-dev wine-staging-dev wine mono-utils
```

Clone this repo:

```bash
git clone https://github.com/datalorians/linux-proton-trackir5-nuclearoption.git
cd linux-proton-trackir5-nuclearoption
```

Build/install LinuxTrack and install the TrackIR 5 udev rule:

```bash
./scripts/install-linuxtrack.sh
./scripts/install-udev-rule.sh
```

Replug the TrackIR camera or log out/in after installing the udev rule.

LinuxTrack still needs the firmware/game data from the official TrackIR 5
Windows installer. See [Firmware and Game Data](docs/firmware.md).

Install the Nuclear Option profile and Proton bridge:

```bash
./scripts/install-profile.sh
./scripts/build-wine-bridge.sh
./scripts/install-nuclear-option-bridge.sh
```

Install helper commands:

```bash
./scripts/install-helpers.sh
```

Optional Cinnamon/X11 shortcut installer:

```bash
./scripts/install-cinnamon-hotkeys.sh
```

## 🎮 Steam Setup

TrackIR starts when Nuclear Option loads the installed `NPClient64.dll`, so
TrackIR itself does **not** need a Steam launch option.

Launch the game normally through Steam. In Nuclear Option, enable TrackIR in
the game settings.

## ⌨️ Recenter and Pause Controls

The helper commands are:

```bash
trackir-linux-center
trackir-linux-toggle
trackir-linux-pause
trackir-linux-resume
```

The optional Cinnamon installer binds these to the classic TrackIR-style keys:

- `F9` for recenter
- `F10` for pause/resume

Those keys are not a special project feature; they are simply the familiar
Windows TrackIR defaults. You can bind any keys you want in your desktop
environment, keyboard utility, Stream Deck, joystick macro tool, or window
manager.

For example, bind:

```text
your preferred recenter key -> ~/.local/bin/trackir-linux-center
your preferred pause key    -> ~/.local/bin/trackir-linux-toggle
```

Pause freezes the last pose returned to the game. It does not shut down the
camera service.

## 🔧 Sensitivity and Tuning

LinuxTrack profiles live here:

```text
~/.config/linuxtrack/linuxtrack1.conf
```

Nuclear Option uses the profile titled:

```text
Title = Nuclear Option
```

Common tuning values:

- `Yaw-sensitivity`, `Pitch-sensitivity`, `Roll-sensitivity`
- `Yaw-filter`, `Pitch-filter`, `Roll-filter`
- `*-deadzone`
- `*-left-curvature` / `*-right-curvature`
- `*-enabled`
- `*-inverted`

See [Profile Tuning](docs/profile-tuning.md).

## 🧯 Troubleshooting

Useful files and commands:

```bash
trackir-linux-toggle
trackir-linux-center
LINUXTRACK_DBG=w %command%
```

Debug log:

```text
~/.local/share/Steam/steamapps/common/Nuclear Option/NPClient.log
```

More notes:

- [Proton Bridge](docs/proton-bridge.md)
- [Hotkeys](docs/hotkeys.md)
- [Troubleshooting](docs/troubleshooting.md)

## 🤖 AI Disclosure

This package was developed with assistance from OpenAI's Codex/ChatGPT. The
scripts, patches, and documentation were reviewed and tested locally before
publication, but they are community-maintained and provided as-is.

AI disclosure is separate from licensing: the disclosure explains how the work
was produced, while the license explains what rights you have to use and modify
the code.

## 📄 License

Repository scripts, helper source, and documentation are released under the
[MIT License](LICENSE).

LinuxTrack has its own license. NaturalPoint firmware, software, and trademarks
belong to their respective owners and are not included in this repository.

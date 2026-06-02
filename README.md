# Linux TrackIR 5 for Nuclear Option on Proton

Community setup notes and helper scripts for using a NaturalPoint TrackIR 5 kit
with Nuclear Option on Linux through Steam/Proton.

This repo packages a working LinuxTrack + Wine bridge setup:

- TrackIR 5 USB access through udev.
- LinuxTrack built from the maintained exuvo fork.
- A 64-bit `NPClient64.dll` Wine bridge for Proton games.
- Bridge-level F9/F10 recenter and pause support, including TrackIR 5 pause LED
  feedback.
- Nuclear Option app ID/profile support.

It does not redistribute NaturalPoint firmware, the TrackIR Windows installer,
or proprietary NaturalPoint DLLs. You must provide/download the official
TrackIR installer yourself.

## Tested Setup

- TrackIR 5 camera: USB ID `131d:0158`
- TrackClip Pro
- Nuclear Option Steam app ID: `2168680`
- Proton prefix:
  `~/.local/share/Steam/steamapps/compatdata/2168680/pfx`
- Nuclear Option game directory:
  `~/.local/share/Steam/steamapps/common/Nuclear Option`
- Linux desktop: Cinnamon/X11

Other desktops should work for TrackIR itself, but global hotkeys may need a
different binding method.

## Quick Start

Install dependencies. On Debian/Ubuntu-like systems:

```bash
sudo apt install git build-essential autoconf automake libtool pkg-config \
  libusb-1.0-0-dev wine-staging-dev wine mono-utils
```

Clone and run the LinuxTrack setup:

```bash
git clone https://github.com/datalorians/linux-proton-trackir5-nuclearoption.git
cd linux-proton-trackir5-nuclearoption
./scripts/install-linuxtrack.sh
./scripts/install-udev-rule.sh
```

Log out/in or replug the TrackIR after installing the udev rule.

Extract/install firmware and game data from the official TrackIR 5 Windows
installer. See [Firmware and Game Data](docs/firmware.md).

Install the Nuclear Option Proton bridge:

```bash
./scripts/install-nuclear-option-bridge.sh
```

Install helper commands and optional Cinnamon hotkeys:

```bash
./scripts/install-helpers.sh
./scripts/install-cinnamon-hotkeys.sh
```

Then launch Nuclear Option through Steam. If everything is correct, the in-game
TrackIR option should work and these global shortcuts should control it:

- `F9`: recenter view
- `F10`: pause/resume tracking and switch the TrackIR status LED to the paused
  color

## Steam Launch Option

TrackIR starts on demand when the game loads `NPClient64.dll`, so you do not
need to start LinuxTrack explicitly from Steam.

Your normal launch option can stay as-is.

## Adjusting Sensitivity

LinuxTrack stores profiles in:

```text
~/.config/linuxtrack/linuxtrack1.conf
```

Nuclear Option uses the profile titled `Nuclear Option`. Common knobs:

- `Yaw-sensitivity`, `Pitch-sensitivity`, `Roll-sensitivity`
- `Yaw-filter`, `Pitch-filter`, `Roll-filter`
- `*-deadzone`
- `*-left-curvature` / `*-right-curvature`
- `*-enabled`
- `*-inverted`

See [Profile Tuning](docs/profile-tuning.md).

## Safety Notes

- Do not commit extracted firmware or proprietary NaturalPoint DLLs.
- Re-run `scripts/install-nuclear-option-bridge.sh` after changing Proton
  prefixes or moving the Steam library.
- Stop Nuclear Option before editing LinuxTrack profiles; LinuxTrack may save
  profile state on exit.

## License

Scripts and helper source in this repository are MIT licensed. LinuxTrack is a
separate project with its own license. NaturalPoint firmware/software is owned
by NaturalPoint and is not included here.

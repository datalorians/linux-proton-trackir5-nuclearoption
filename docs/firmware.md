# Firmware and Game Data

LinuxTrack needs two things from the official Windows TrackIR software:

- TrackIR camera firmware files under `~/.config/linuxtrack/tir_firmware/`
- TrackIR game data, including app IDs, under `gamedata.txt`

This repository does not include those files.

## Download the Official Installer

Download the TrackIR 5 Windows installer from NaturalPoint. The setup tested
here used `TrackIR_5.4.2.exe`.

Put it somewhere local, for example:

```bash
mkdir -p ~/Downloads/trackir
mv ~/Downloads/TrackIR_5.4.2.exe ~/Downloads/trackir/
```

## Extract the Installer

Use Wine to unpack the installer into a temporary prefix:

```bash
export WINEPREFIX=/tmp/trackir-admin-prefix
mkdir -p "$WINEPREFIX"
wine ~/Downloads/trackir/TrackIR_5.4.2.exe
```

If the installer offers an install directory, choose a temporary location. In
the tested setup the installed files landed at:

```text
/tmp/trackir-admin-prefix/drive_c/TrackIRExtract/NaturalPoint/TrackIR5
```

You need `TrackIR5.exe` and `sgl.dat` from that extracted directory.

## Extract Game Data

LinuxTrack's extractor can read `sgl.dat`:

```bash
~/.local/opt/linuxtrack-trackir/bin/ltr_extractor --extract /path/to/sgl.dat
```

Then add Nuclear Option's TrackIR app ID:

```bash
./scripts/install-profile.sh
```

Nuclear Option uses TrackIR app ID `8285`.

## Extract Firmware

The TrackIR 5 camera should end up with firmware files like:

```text
~/.config/linuxtrack/tir_firmware/tir5v2.fw.gz
~/.config/linuxtrack/tir_firmware/tir5.fw.gz
~/.config/linuxtrack/tir_firmware/tir4.fw.gz
~/.config/linuxtrack/tir_firmware/sn4.fw.gz
```

LinuxTrack's GUI and extractor behavior varies across installer versions. If
the automatic extractor does not produce firmware files, use the upstream
LinuxTrack GUI extractor or manually copy firmware files produced by another
LinuxTrack installation. Do not publish those firmware files in this repo.

You can verify firmware upload by starting Nuclear Option and checking
LinuxTrack logs for messages like:

```text
TrackIR interface claimed
Loading firmware ... tir5v2.fw.gz
Firmware uploaded!
Changing state to RUNNING!
```

## Known Working Runtime Files

For a working TrackIR 5 + TrackClip Pro setup, the relevant LinuxTrack config
contains:

```ini
[Global]
Input = TrackIR
Model = NP TrackClip Pro

[TrackIR]
Capture-device = Tir
Capture-device-id = Tir
Threshold = 140
Min-blob = 4
Max-blob = 2500
Status-led-brightness = 0
Ir-led-brightness = 7
Status-signals = On
```

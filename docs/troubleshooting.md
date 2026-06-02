# Troubleshooting

## TrackIR USB Device Not Accessible

Check the device:

```bash
lsusb | grep -E '131d:0158|TrackIR'
```

Install the udev rule:

```bash
./scripts/install-udev-rule.sh
```

Then replug the TrackIR.

## Nuclear Option Does Not See TrackIR

Check that the bridge exists:

```bash
ls "$HOME/.local/share/Steam/steamapps/common/Nuclear Option/NPClient64.dll"
ls "$HOME/.local/share/Steam/steamapps/compatdata/2168680/pfx/drive_c/linuxtrack/NPClient64.dll"
```

Reinstall the bridge:

```bash
./scripts/install-nuclear-option-bridge.sh
```

## View Works But Is Too Fast or Jittery

Edit:

```text
~/.config/linuxtrack/linuxtrack1.conf
```

Lower `Yaw-sensitivity` and `Pitch-sensitivity`, or raise `Yaw-filter` and
`Pitch-filter` slightly.

## F9/F10 Do Nothing

Start Nuclear Option first, enable TrackIR in-game, then try:

```bash
~/.local/bin/trackir-linux-center
~/.local/bin/trackir-linux-toggle
```

If the commands work in a terminal but not in-game, your desktop may not allow
global shortcuts while the Proton game has focus.

If terminal toggle freezes/unfreezes the view but the TrackIR LED does not
change, restart the game after reinstalling LinuxTrack. The LED behavior lives
in `ltr_server1`, so already-running sessions keep the old server binary.

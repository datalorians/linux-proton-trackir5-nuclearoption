# Hotkeys

The helper commands control the patched `NPClient64.dll` bridge with flag files
in `/tmp`:

```text
/tmp/linuxtrack_npclient_center
/tmp/linuxtrack_npclient_pause
```

Wrapper commands:

```text
~/.local/bin/trackir-linux-center
~/.local/bin/trackir-linux-toggle
~/.local/bin/trackir-linux-pause
~/.local/bin/trackir-linux-resume
```

This avoids suspending LinuxTrack itself. Pause freezes the last pose returned
to the game, and the patched LinuxTrack server mirrors the pause state on the
TrackIR 5 status LED.

## Cinnamon

Run:

```bash
./scripts/install-cinnamon-hotkeys.sh
```

Bindings:

- `F9`: recenter
- `F10`: pause/resume

## Other Desktops

Create global shortcuts manually:

- `F9` -> `~/.local/bin/trackir-linux-center`
- `F10` -> `~/.local/bin/trackir-linux-toggle`

If your compositor does not allow global shortcuts while a game has focus,
bind these commands to joystick buttons with your desktop input tool.

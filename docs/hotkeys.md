# Hotkeys

The helper binary exposes LinuxTrack actions:

```bash
trackir-linux-control center
trackir-linux-control pause
trackir-linux-control resume
trackir-linux-control toggle
trackir-linux-control state
```

Wrapper commands:

```text
~/.local/bin/trackir-linux-center
~/.local/bin/trackir-linux-toggle
~/.local/bin/trackir-linux-pause
~/.local/bin/trackir-linux-resume
```

These commands only act when the LinuxTrack server is already running.

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

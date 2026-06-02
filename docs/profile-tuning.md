# Profile Tuning

LinuxTrack profile settings live in:

```text
~/.config/linuxtrack/linuxtrack1.conf
```

Nuclear Option uses the profile titled:

```ini
Title = Nuclear Option
```

Stop the game before editing the file.

## Useful Controls

Sensitivity:

```ini
Yaw-sensitivity = 3
Pitch-sensitivity = 3
Roll-sensitivity = 1.5
```

Higher values move the in-game camera more for the same head movement.

Smoothing:

```ini
Yaw-filter = 0.2
Pitch-filter = 0.2
Roll-filter = 0.2
```

Higher values are steadier but add lag. Try `0.3` or `0.35` if the view jitters.

Deadzone:

```ini
Yaw-deadzone = 0.02
Pitch-deadzone = 0.02
```

Use this if the view drifts or twitches near center.

Disable translation axes if cockpit leaning feels bad:

```ini
Xtranslation-enabled = No
Ytranslation-enabled = No
Ztranslation-enabled = No
```

Invert an axis:

```ini
Yaw-inverted = Yes
```

## Starting Point

For Nuclear Option, this is a reasonable first pass:

```ini
Pitch-sensitivity = 3
Yaw-sensitivity = 3
Roll-sensitivity = 1.5
Pitch-filter = 0.2
Yaw-filter = 0.2
Roll-filter = 0.2
```

If it feels too fast, lower yaw and pitch to `2` or `2.5`. If it feels too
floaty, lower the filter before raising sensitivity.

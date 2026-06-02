# Proton Bridge

Nuclear Option has built-in TrackIR support. Under Proton it looks for
NaturalPoint's `NPClient64.dll`. LinuxTrack provides an open Wine bridge that
implements the TrackIR client API and forwards tracking data from LinuxTrack.
This package applies a small patch to that bridge so external hotkeys can
request recenter and pause without suspending the LinuxTrack camera service.

The install script copies the same bridge into two locations:

```text
<proton-prefix>/drive_c/linuxtrack/NPClient64.dll
<proton-prefix>/drive_c/linuxtrack/NPClient.dll
<game-dir>/NPClient64.dll
<game-dir>/NPClient.dll
```

It also sets:

```text
HKCU\Software\NaturalPoint\NATURALPOINT\NPClient Location
Path = C:\linuxtrack
```

Run:

```bash
./scripts/install-linuxtrack.sh
./scripts/build-wine-bridge.sh
./scripts/install-nuclear-option-bridge.sh
```

If the Proton prefix does not exist, launch Nuclear Option once through Steam
first.

## Steam Launch Option

TrackIR does not need a special Steam launch option. The bridge starts
LinuxTrack when the game loads `NPClient64.dll`.

Use a launch option only if you need unrelated pre/post scripts.

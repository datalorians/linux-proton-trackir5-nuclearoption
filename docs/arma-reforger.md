# Arma Reforger

Arma Reforger has explicit TrackIR support in the game executable. Local strings
include:

```text
SetTrackIREnable
TrackIRYaw
TrackIRPitch
TrackIRRoll
NP_RegisterProgramProfileID
Software\NaturalPoint\NATURALPOINT\NPClient Location
```

Install the bridge:

```bash
./scripts/build-wine-bridge.sh
./scripts/install-arma-reforger-bridge.sh
```

Default locations:

```text
~/.local/share/Steam/steamapps/common/Arma Reforger
~/.local/share/Steam/steamapps/compatdata/1874880/pfx
```

The script copies `NPClient64.dll` and `NPClient.dll` into both the Proton
prefix and game folder, then sets the NaturalPoint registry path to
`C:\linuxtrack`.

## First Launch Debugging

To discover the exact TrackIR profile ID Arma registers, temporarily use this
Steam launch option:

```bash
LINUXTRACK_DBG=w %command%
```

After launching, search for `NPClient.log`:

```bash
find "$HOME/.local/share/Steam/steamapps/compatdata/1874880" \
  -iname NPClient.log -print
```

The log should include a line like:

```text
RegisterProgramProfileID request: <id>
```

If that ID is missing from `~/.config/linuxtrack/tir_firmware/gamedata.txt`,
LinuxTrack falls back to the `Default` profile. Add the ID once known to use a
dedicated `Arma Reforger` profile.

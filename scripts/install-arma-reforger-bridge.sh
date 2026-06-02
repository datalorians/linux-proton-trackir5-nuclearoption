#!/usr/bin/env bash
set -euo pipefail

appid="${ARMA_REFORGER_APPID:-1874880}"
steam_root="${STEAM_ROOT:-$HOME/.local/share/Steam}"
game_dir="${ARMA_REFORGER_GAME_DIR:-$steam_root/steamapps/common/Arma Reforger}"
pfx="${ARMA_REFORGER_PFX:-$steam_root/steamapps/compatdata/$appid/pfx}"
prefix="${LINUXTRACK_PREFIX:-$HOME/.local/opt/linuxtrack-trackir}"
bridge="${LINUXTRACK_BRIDGE:-$prefix/wine/NPClient64.dll.so}"

if [[ ! -f "$bridge" ]]; then
  echo "Bridge not found: $bridge" >&2
  echo "Run scripts/build-wine-bridge.sh first." >&2
  exit 1
fi

if [[ ! -d "$game_dir" ]]; then
  echo "Arma Reforger game directory not found: $game_dir" >&2
  exit 1
fi

if [[ ! -d "$pfx" ]]; then
  echo "Proton prefix not found: $pfx" >&2
  echo "Launch Arma Reforger once through Steam, then rerun this script." >&2
  exit 1
fi

mkdir -p "$pfx/drive_c/linuxtrack"
cp "$bridge" "$pfx/drive_c/linuxtrack/NPClient64.dll"
cp "$bridge" "$pfx/drive_c/linuxtrack/NPClient.dll"
cp "$bridge" "$game_dir/NPClient64.dll"
cp "$bridge" "$game_dir/NPClient.dll"

WINEPREFIX="$pfx" wine reg add \
  'HKCU\Software\NaturalPoint\NATURALPOINT\NPClient Location' \
  /v Path /t REG_SZ /d 'C:\linuxtrack' /f

echo "Installed NPClient bridge for Arma Reforger."
echo "Game: $game_dir"
echo "Prefix: $pfx"

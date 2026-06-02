#!/usr/bin/env bash
set -euo pipefail

prefix="${LINUXTRACK_PREFIX:-$HOME/.local/opt/linuxtrack-trackir}"
workdir="${WORKDIR:-$PWD/build/linuxtrack}"
wine_include="${WINE_INCLUDE:-/opt/wine-staging/include/wine/windows}"

if [[ ! -d "$workdir/src/wine_bridge/client" ]]; then
  echo "LinuxTrack source not found at $workdir. Run scripts/install-linuxtrack.sh first." >&2
  exit 1
fi

if [[ ! -d "$wine_include" ]]; then
  echo "Wine headers not found at $wine_include. Install wine-staging-dev or set WINE_INCLUDE." >&2
  exit 1
fi

cd "$workdir/src/wine_bridge/client"
make clean-local >/dev/null 2>&1 || true
make NPClient64.dll.so V=1 CPPFLAGS="-I$wine_include"

mkdir -p "$prefix/wine"
cp NPClient64.dll.so "$prefix/wine/NPClient64.dll.so"

echo "Built bridge: $prefix/wine/NPClient64.dll.so"

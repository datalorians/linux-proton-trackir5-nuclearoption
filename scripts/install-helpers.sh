#!/usr/bin/env bash
set -euo pipefail

prefix="${LINUXTRACK_PREFIX:-$HOME/.local/opt/linuxtrack-trackir}"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.local/bin"

gcc \
  -I"$prefix/include" \
  -L"$prefix/lib/linuxtrack" \
  -Wl,-rpath,"$prefix/lib/linuxtrack" \
  -o "$HOME/.local/bin/trackir-linux-control" \
  "$repo_root/src/trackir-linux-control.c" \
  -llinuxtrack -lltr -ldl -pthread

install -m 0755 "$repo_root"/bin/trackir-linux-* "$HOME/.local/bin/"

echo "Installed TrackIR helper commands into $HOME/.local/bin"

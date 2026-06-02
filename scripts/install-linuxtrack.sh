#!/usr/bin/env bash
set -euo pipefail

repo="${LINUXTRACK_REPO:-https://github.com/exuvo/linuxtrack.git}"
prefix="${LINUXTRACK_PREFIX:-$HOME/.local/opt/linuxtrack-trackir}"
workdir="${WORKDIR:-$PWD/build/linuxtrack}"

mkdir -p "$(dirname "$workdir")" "$(dirname "$prefix")"

if [[ -d "$workdir/.git" ]]; then
  git -C "$workdir" fetch --all --tags
  git -C "$workdir" pull --ff-only
else
  git clone "$repo" "$workdir"
fi

cd "$workdir"

if [[ ! -x ./configure ]]; then
  autoreconf -fi
fi

./configure --prefix="$prefix" --disable-ltr-32lib-on-x64
make -j"$(nproc)"
make install

echo "Installed LinuxTrack to: $prefix"

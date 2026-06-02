#!/usr/bin/env bash
set -euo pipefail

repo="${LINUXTRACK_REPO:-https://github.com/exuvo/linuxtrack.git}"
prefix="${LINUXTRACK_PREFIX:-$HOME/.local/opt/linuxtrack-trackir}"
workdir="${WORKDIR:-$PWD/build/linuxtrack}"
repo_root="${REPO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
patch_file="$repo_root/patches/linuxtrack-npclient-flag-pause-led.patch"

mkdir -p "$(dirname "$workdir")" "$(dirname "$prefix")"

if [[ -d "$workdir/.git" ]]; then
  if [[ -f "$patch_file" ]] && git -C "$workdir" apply --reverse --check "$patch_file" >/dev/null 2>&1; then
    echo "LinuxTrack pause/LED patch already applied; skipping source update."
  else
    git -C "$workdir" fetch --all --tags
    git -C "$workdir" pull --ff-only
  fi
else
  git clone "$repo" "$workdir"
fi

cd "$workdir"

if [[ -f "$patch_file" ]]; then
  if ! git apply --check "$patch_file" >/dev/null 2>&1; then
    if git apply --reverse --check "$patch_file" >/dev/null 2>&1; then
      echo "LinuxTrack pause/LED patch already applied."
    else
      echo "LinuxTrack source has local changes or an incompatible version; cannot apply $patch_file" >&2
      exit 1
    fi
  else
    git apply "$patch_file"
    echo "Applied LinuxTrack pause/LED patch."
  fi
fi

if [[ ! -x ./configure ]]; then
  autoreconf -fi
fi

./configure --prefix="$prefix" --disable-ltr-32lib-on-x64
make -j"$(nproc)"
make install

echo "Installed LinuxTrack to: $prefix"

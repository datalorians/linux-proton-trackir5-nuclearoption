#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
conf="${LINUXTRACK_CONFIG:-$HOME/.config/linuxtrack/linuxtrack1.conf}"
profile="$repo_root/config/nuclear-option-profile.conf"
gamedata="$HOME/.config/linuxtrack/tir_firmware/gamedata.txt"

mkdir -p "$(dirname "$conf")"

if [[ -f "$conf" ]] && grep -n '^Title = Nuclear Option$' "$conf" >/dev/null 2>&1; then
  echo "Nuclear Option profile already exists in $conf"
else
  {
    printf '\n\n'
    cat "$profile"
    printf '\n'
  } >> "$conf"
  echo "Appended Nuclear Option profile to $conf"
fi

if [[ -f "$gamedata" ]] && ! grep -n '^8285 "Nuclear Option"$' "$gamedata" >/dev/null 2>&1; then
  tmp="$(mktemp)"
  awk 'NR == 1 { print; print "8285 \"Nuclear Option\""; next } { print }' "$gamedata" > "$tmp"
  mv "$tmp" "$gamedata"
  echo "Added Nuclear Option app ID 8285 to $gamedata"
elif [[ -f "$gamedata" ]]; then
  echo "Nuclear Option app ID already present in $gamedata"
else
  echo "Game data file not found yet: $gamedata" >&2
  echo "Extract game data first, then rerun this script." >&2
fi

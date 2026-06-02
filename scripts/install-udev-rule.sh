#!/usr/bin/env bash
set -euo pipefail

rule_file="/etc/udev/rules.d/70-trackir5.rules"
rule='SUBSYSTEM=="usb", ATTR{idVendor}=="131d", ATTR{idProduct}=="0158", MODE="0660", GROUP="plugdev", TAG+="uaccess"'

if ! getent group plugdev >/dev/null; then
  sudo groupadd plugdev
fi

printf '%s\n' "$rule" | sudo tee "$rule_file" >/dev/null
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Installed $rule_file"
echo "Replug the TrackIR or log out/in if access is still denied."

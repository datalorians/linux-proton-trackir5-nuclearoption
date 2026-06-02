#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$HOME/.local/bin"
install -m 0755 \
  "$repo_root/bin/x55-nuclear-option-virtual-stick" \
  "$repo_root/bin/x55-nuclear-option-stop-virtual-stick" \
  "$HOME/.local/bin/"

echo "Installed optional X-55 Nuclear Option yaw fix scripts."

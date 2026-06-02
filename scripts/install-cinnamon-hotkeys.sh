#!/usr/bin/env bash
set -euo pipefail

if [[ "${XDG_CURRENT_DESKTOP:-}" != *Cinnamon* && "${DESKTOP_SESSION:-}" != cinnamon ]]; then
  echo "This script is for Cinnamon. You can still bind these commands manually:" >&2
  echo "  F9  -> $HOME/.local/bin/trackir-linux-center" >&2
  echo "  F10 -> $HOME/.local/bin/trackir-linux-toggle" >&2
  exit 1
fi

center_id="trackir-center"
toggle_id="trackir-toggle"
current="$(gsettings get org.cinnamon.desktop.keybindings custom-list)"
updated="$(python3 - "$current" "$center_id" "$toggle_id" <<'PY'
import ast
import sys

items = ast.literal_eval(sys.argv[1])
for item in sys.argv[2:]:
    if item not in items:
        items.append(item)
print(str(items))
PY
)"

gsettings set org.cinnamon.desktop.keybindings custom-list "$updated"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/$center_id/ name 'TrackIR Center'
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/$center_id/ command "$HOME/.local/bin/trackir-linux-center"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/$center_id/ binding "['F9']"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/$toggle_id/ name 'TrackIR Toggle Pause'
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/$toggle_id/ command "$HOME/.local/bin/trackir-linux-toggle"
gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/$toggle_id/ binding "['F10']"

echo "Installed Cinnamon hotkeys: F9 center, F10 pause/resume."

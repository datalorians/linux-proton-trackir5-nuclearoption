# Optional X-55 Yaw Fix

Some setups expose a Saitek/Mad Catz X-55 Rhino stick in a way Nuclear Option
does not read correctly for yaw/rotation. The workaround uses `evsieve` to
create a virtual joystick and remap:

```text
abs:rz -> abs:z
```

Install evsieve:

```bash
cargo install evsieve
```

Install the scripts:

```bash
./scripts/install-x55-yaw-fix.sh
```

Default input path:

```text
/dev/input/by-id/usb-Madcatz_Saitek_Pro_Flight_X-55_Rhino_Stick_G0013831-event-joystick
```

Override it if needed:

```bash
X55_INPUT=/dev/input/by-id/your-stick-event-joystick \
  ~/.local/bin/x55-nuclear-option-virtual-stick
```

Steam launch option:

```bash
bash -lc '$HOME/.local/bin/x55-nuclear-option-virtual-stick; cleanup(){ $HOME/.local/bin/x55-nuclear-option-stop-virtual-stick; $HOME/.local/bin/trackir-linux-stop; }; trap cleanup EXIT; "$@"; rc=$?; exit $rc' -- %command%
```

Stop manually:

```bash
~/.local/bin/x55-nuclear-option-stop-virtual-stick
```

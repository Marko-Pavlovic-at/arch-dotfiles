# Hyprland Setup — Surface Pro 6 / CachyOS

Hyprland version: **0.55.3** (config language: Lua, file: `hyprland.lua`)

Config files live in `configs/` — copy them to `~/.config/` on a new system.

---

## Install

```bash
sudo pacman -S hyprland xdg-desktop-portal-hyprland hyprcursor hyprgraphics \
  hyprland-guiutils hyprutils hyprwayland-scanner \
  kitty waybar hyprpaper dunst \
  pipewire wireplumber playerctl brightnessctl \
  hypridle hyprlock hyprlauncher hyprpolkitagent hyprshutdown hyprsunset \
  qt5-wayland qt6-wayland dolphin
```

Launch: log out → select **Hyprland (UWSM)** from the display manager.

---

## Config files

| File | Destination |
|---|---|
| `configs/hypr/hyprland.lua` | `~/.config/hypr/hyprland.lua` |
| `configs/waybar/config.jsonc` | `~/.config/waybar/config.jsonc` |
| `configs/waybar/style.css` | `~/.config/waybar/style.css` |

Quick deploy:
```bash
mkdir -p ~/.config/hypr ~/.config/waybar
cp configs/hypr/hyprland.lua ~/.config/hypr/
cp configs/waybar/config.jsonc configs/waybar/style.css ~/.config/waybar/
```

---

## Changes made

### Keyboard layout — Austrian
In `hyprland.lua` under `hl.config({ input = { ... } })`:
```lua
kb_layout = "at",
```

### Waybar — Wuthering Waves theme

Font required: **FantasqueSansM Nerd Font** (already in CachyOS repos as `ttf-fantasque-sans-mono-nerd`).

Design: dark navy bar (`rgba(4,8,20,0.97)`) · cyan glow accents (`#00d4ff`) · gold clock (`#c8a84b`) · floating pill modules with 1px cyan borders.

Modules (left → center → right):
- Left: `hyprland/workspaces` (5 persistent, active workspace glows cyan)
- Center: `hyprland/window` (italic, dimmed)
- Right: idle inhibitor · volume · backlight · network · CPU · memory · temperature · battery · power profile · clock (seconds live) · tray

**To restart waybar** (fish shell):
```fish
pkill waybar; waybar & disown
```

---

## Keybinds (default)

| Bind | Action |
|---|---|
| `SUPER + Q` | Terminal (kitty) |
| `SUPER + C` | Close window |
| `SUPER + R` | App launcher (hyprlauncher) |
| `SUPER + E` | File manager (dolphin) |
| `SUPER + V` | Toggle float |
| `SUPER + M` | Shutdown menu (hyprshutdown) |
| `SUPER + S` | Toggle scratchpad |
| `SUPER + 1-5` | Switch workspace |
| `SUPER + SHIFT + 1-5` | Move window to workspace |
| `SUPER + arrows` | Move focus |
| `SUPER + LMB drag` | Move window |
| `SUPER + RMB drag` | Resize window |
| `XF86Audio*` | Volume via wpctl |
| `XF86Brightness*` | Brightness via brightnessctl |

---

## Still to do

- [x] hyprlock — `~/.config/hypr/hyprlock.conf` — `SUPER+L`, WW-themed
- [ ] grimblast for screenshots — `sudo pacman -S grimblast-git`
- [ ] hyprpaper wallpaper config — `~/.config/hypr/hyprpaper.conf`

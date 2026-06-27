# Hyprland Setup — Surface Pro 6 / CachyOS

Hyprland version: **0.55.3** (config language: Lua, file: `hyprland.lua`)

Config files live in `configs/` — copy them to `~/.config/` on a new system.

---

## Install

```bash
sudo pacman -S hyprland xdg-desktop-portal-hyprland hyprcursor hyprgraphics \
  hyprland-guiutils hyprutils hyprwayland-scanner \
  kitty waybar hyprpaper dunst grimblast \
  pipewire wireplumber playerctl brightnessctl \
  hypridle hyprlock hyprlauncher hyprpolkitagent hyprshutdown hyprsunset \
  qt5-wayland qt6-wayland dolphin \
  papirus-icon-theme nwg-look kvantum kvantum-qt5 github-cli
```

Launch: log out → select **Hyprland (UWSM)** from the display manager.

---

## Config files

| File | Destination |
|---|---|
| `configs/hypr/hyprland.lua` | `~/.config/hypr/hyprland.lua` |
| `configs/hypr/hyprlock.conf` | `~/.config/hypr/hyprlock.conf` |
| `configs/hypr/hyprpaper.conf` | `~/.config/hypr/hyprpaper.conf` |
| `configs/waybar/config.jsonc` | `~/.config/waybar/config.jsonc` |
| `configs/waybar/style.css` | `~/.config/waybar/style.css` |
| `configs/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` |
| `configs/dunst/dunstrc` | `~/.config/dunst/dunstrc` |
| `configs/gtk-3.0/settings.ini` | `~/.config/gtk-3.0/settings.ini` |
| `configs/gtk-4.0/settings.ini` | `~/.config/gtk-4.0/settings.ini` |
| `configs/Kvantum/kvantum.kvconfig` | `~/.config/Kvantum/kvantum.kvconfig` |

Quick deploy on a new system:
```bash
mkdir -p ~/.config/hypr ~/.config/waybar ~/.config/kitty \
         ~/.config/dunst ~/.config/gtk-3.0 ~/.config/gtk-4.0 ~/.config/Kvantum

cp configs/hypr/* ~/.config/hypr/
cp configs/waybar/* ~/.config/waybar/
cp configs/kitty/kitty.conf ~/.config/kitty/
cp configs/dunst/dunstrc ~/.config/dunst/
cp configs/gtk-3.0/settings.ini ~/.config/gtk-3.0/
cp configs/gtk-4.0/settings.ini ~/.config/gtk-4.0/
cp configs/Kvantum/kvantum.kvconfig ~/.config/Kvantum/

# Apply GTK settings
gsettings set org.gnome.desktop.interface gtk-theme "Breeze-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "capitaine-cursors"
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Wallpapers — copy your wallpapers to ~/Pictures/wallpapers/ first
```

---

## Theming

**Palette:** dark navy `#060c18` · ice blue/cyan `#00d4ff` · soft pink `#f4a0b8` (accent only)

| Layer | Choice |
|---|---|
| GTK theme | Breeze-Dark |
| Icons | Papirus-Dark |
| Cursor | capitaine-cursors (size 24) |
| Qt theme | Kvantum → KvDark |
| Terminal | Kitty — 82% opacity, WW color scheme |
| Notifications | Dunst — dark navy, cyan border, pink for critical |
| Wallpaper | `~/Pictures/wallpapers/ww-552.jpg` (WW battle scene) |
| Lock screen | Same wallpaper, no blur, white clock 140pt, pink date 36pt |

---

## Changes made

### Keyboard layout — Austrian
In `hyprland.lua` under `hl.config({ input = { ... } })`:
```lua
kb_layout = "at",
```

### Waybar — Wuthering Waves theme

Font required: **FantasqueSansM Nerd Font** (in CachyOS as `ttf-fantasque-sans-mono-nerd`).

Design: dark navy bar · cyan glow accents (`#00d4ff`) · soft pink clock (`#f4a0b8`) · floating pill modules.

Modules (left → center → right):
- Left: `hyprland/workspaces` (5 persistent, active workspace glows cyan)
- Center: `hyprland/window` (italic, dimmed)
- Right: idle inhibitor · volume · backlight · network · CPU · memory · temperature · battery · power profile · clock (live seconds) · tray

**To restart waybar:**
```fish
pkill waybar; waybar & disown
```

### hyprlock — lock screen
- `SUPER+L` to lock
- Wallpaper: `ww-552.jpg`, no blur
- Clock: 140pt white with drop shadow
- Date: 36pt pink with drop shadow
- Input field: dark with cyan outline

### grimblast — screenshots
| Bind | Action |
|---|---|
| `Print` | Full screen → clipboard |
| `SUPER + Print` | Area → clipboard |
| `SUPER + SHIFT + Print` | Area → saved to `~/Pictures/` |

### hyprpaper — wallpaper daemon
Config uses block syntax (v0.8+):
```
wallpaper {
    monitor = eDP-1
    path = /home/marko/Pictures/wallpapers/ww-552.jpg
    fit_mode = cover
}
```
**To restart:**
```fish
pkill hyprpaper; hyprpaper & disown
```

### Kitty — transparent terminal
- 82% background opacity (wallpaper shows through)
- Adjust live: `CTRL+SHIFT+A M` (more) / `CTRL+SHIFT+A L` (less)
- WW color scheme: navy bg, cyan cursor, pink highlights

### Dunst — notifications
- Dark navy background, 1px cyan border
- Critical notifications: pink border, no timeout
- Font: FantasqueSansM Nerd Font 11

---

## Keybinds

| Bind | Action |
|---|---|
| `SUPER + Q` | Terminal (kitty) |
| `SUPER + C` | Close window |
| `SUPER + L` | Lock screen (hyprlock) |
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
| `Print` | Screenshot full screen → clipboard |
| `SUPER + Print` | Screenshot area → clipboard |
| `SUPER + SHIFT + Print` | Screenshot area → `~/Pictures/` |

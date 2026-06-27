---
name: hyprland-guide
description: "Step-by-step Hyprland setup guide for this CachyOS/Surface system — install, config, ecosystem tools, keybinds"
metadata: 
  node_type: memory
  type: project
  originSessionId: e4e0aa6e-69e8-416f-bb07-6fe8fe36a67c
---

# Hyprland Setup Guide

> Sources: [wiki.hypr.land](https://wiki.hypr.land) · [github.com/hyprwm/Hyprland](https://github.com/hyprwm/Hyprland) (example/hyprland.lua)
> Hyprland version on this system: **0.55.3** (0.55.4 available — update recommended)

---

## System Status — FULLY SET UP AS OF 2026-06-27

Everything installed, configured, and backed up to GitHub (github.com/Marko-Pavlovic-at/arch-dotfiles).

**Completed this session:**
- Austrian keyboard layout (`kb_layout = "at"`)
- Waybar: WW-themed, dark navy + cyan + pink, FantasqueSansM Nerd Font icons
- hyprlock: `SUPER+L`, ww-552.jpg wallpaper, no blur, 140pt white clock + 36pt pink date with shadows
- grimblast: `Print` / `SUPER+Print` / `SUPER+SHIFT+Print`
- hyprpaper: ww-552.jpg wallpaper (block syntax for v0.8+, monitor = eDP-1)
- GTK theming: Breeze-Dark + Papirus-Dark icons + capitaine-cursors
- Qt theming: Kvantum → KvDark
- Kitty: 82% opacity, WW color scheme (navy/cyan/pink)
- Dunst: dark navy popups, cyan border, pink for critical

**Key gotchas:**
- hyprpaper v0.8+ uses block syntax not `wallpaper = monitor,path`
- `hyprctl dispatch exec X` doesn't work in Hyprland 0.55 Lua — use `X & disown` instead
- waybar: use `hyprland/workspaces` not `sway/workspaces`; `hyprland/scratchpad` not supported in waybar 0.15
- grimblast key name is `Print` not `PRINT`
- Start background processes with `& disown` in fish to survive terminal close

Installed:
- `hyprland` 0.55.3, `xdg-desktop-portal-hyprland`, `hyprcursor`, `hyprgraphics`, `hyprland-guiutils`, `hyprutils`, `hyprwayland-scanner`
- `kitty` (terminal), `waybar` (status bar), `hyprpaper` (wallpaper), `dunst` (notifications)
- `pipewire`, `wireplumber`, `playerctl`, `brightnessctl`
- `hypridle`, `hyprlock`, `hyprlauncher`, `hyprpolkitagent`, `hyprshutdown`, `hyprsunset`
- `qt5-wayland`, `qt6-wayland`, `dolphin` (file manager)

Config files created:
- `~/.config/hypr/hyprland.lua` — official example config with autostart uncommented
- `~/.config/hypr/hyprpaper.conf` — set to `/usr/share/wallpapers/cachyos-wallpapers/CachyOS_Moon.jpg`

Autostart configured (in hyprland.lua):
- `waybar`, `hyprpaper`, `dunst`, `hypridle`, `hyprpolkitagent`

Launch: log out → select **Hyprland (UWSM)** from display manager.

To access Claude from inside Hyprland:
- `SUPER + Q` → opens kitty terminal
- `cd ~/arch && claude` or just `claude` if already in the right directory

**Next steps after first launch:**
- Customize waybar (`~/.config/waybar/`)
- Set up hyprlock (`~/.config/hypr/hyprlock.conf`)
- Install grimblast for screenshots
- Fine-tune `hyprland.lua` (gaps, colors, keybinds)

---

## ~~Step 1: Install Missing Packages~~ DONE

---

## Step 2: Create Your Config

Config file location (v0.55+): `~/.config/hypr/hyprland.lua`

> **Important:** Since Hyprland 0.55, the config language switched from **hyprlang to Lua**. The file is `hyprland.lua`, not `hyprland.conf`. Ignore any old `.conf` tutorials.

```bash
mkdir -p ~/.config/hypr
```

Copy the official example as a starting point:
```bash
curl -o ~/.config/hypr/hyprland.lua \
  https://raw.githubusercontent.com/hyprwm/Hyprland/refs/heads/main/example/hyprland.lua
```

---

## Step 3: Key Config Sections (Lua API)

All configuration uses the `hl.*` Lua API.

### Monitor
```lua
hl.monitor({
    output   = "",        -- "" = all monitors
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
```
For a specific monitor: `output = "DP-1"`, `mode = "2560x1440@144"`, `position = "0x0"`.

### Programs
```lua
local terminal    = "kitty"
local fileManager = "dolphin"   -- or "nautilus", "thunar"
local menu        = "hyprlauncher"
```

### Autostart
```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpolkitagent")
    hl.exec_cmd("nm-applet")   -- network tray icon
end)
```

### Environment Variables
```lua
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- For Qt apps on Wayland:
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
```

### Look and Feel
```lua
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        layout = "dwindle",   -- or "master"
    },
    decoration = {
        rounding       = 10,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = { enabled = true, range = 4, render_power = 3, color = 0xee1a1a1a },
        blur   = { enabled = true, size = 3, passes = 1, vibrancy = 0.1696 },
    },
    animations = { enabled = true },
    misc = {
        force_default_wallpaper = 0,   -- 0 = disable anime mascot bg
        disable_hyprland_logo   = true,
    },
})
```

### Input
```lua
hl.config({
    input = {
        kb_layout  = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})
```

---

## Step 4: Default Keybindings (from example config)

`mainMod = SUPER` (Windows key)

| Keybind | Action |
|---------|--------|
| `SUPER + Q` | Open terminal (kitty) |
| `SUPER + C` | Close focused window |
| `SUPER + M` | Exit Hyprland / open hyprshutdown |
| `SUPER + E` | Open file manager |
| `SUPER + V` | Toggle float on window |
| `SUPER + R` | Open app launcher (hyprlauncher) |
| `SUPER + P` | Toggle pseudo-tile |
| `SUPER + J` | Toggle split (dwindle) |
| `SUPER + arrows` | Move focus |
| `SUPER + 1-9,0` | Switch to workspace |
| `SUPER + SHIFT + 1-9,0` | Move window to workspace |
| `SUPER + S` | Toggle scratchpad |
| `SUPER + SHIFT + S` | Move window to scratchpad |
| `SUPER + scroll` | Cycle workspaces |
| `SUPER + LMB drag` | Move window |
| `SUPER + RMB drag` | Resize window |
| `XF86AudioRaiseVolume/LowerVolume/Mute` | Volume (via wpctl) |
| `XF86MonBrightnessUp/Down` | Brightness (via brightnessctl) |
| `XF86AudioPlay/Next/Prev/Pause` | Media (via playerctl) |

---

## Step 5: First Launch

Log out from your current session and select **Hyprland** (or **Hyprland (UWSM)**) from your display manager login screen.

> Prefer **hyprland-uwsm** if available — UWSM provides better systemd integration, proper session management, and cleaner environment variable propagation.

If you have no display manager, you can launch from TTY:
```bash
Hyprland
```

---

## Step 6: Hyprpaper Setup

Create `~/.config/hypr/hyprpaper.conf`:
```
preload = /path/to/your/wallpaper.jpg
wallpaper = ,/path/to/your/wallpaper.jpg
```

---

## Step 7: Waybar

Config lives at `~/.config/waybar/config.jsonc` and `~/.config/waybar/style.css`.
A default config is generated on first run. To customize, copy the defaults:
```bash
cp /etc/xdg/waybar/config.jsonc ~/.config/waybar/
cp /etc/xdg/waybar/style.css ~/.config/waybar/
```

---

## Step 8: Screen Lock (hyprlock)

Create `~/.config/hypr/hyprlock.conf` (minimal):
```lua
background {
    monitor =
    path = /path/to/wallpaper.jpg
    blur_passes = 2
}

input-field {
    monitor =
    size = 200, 50
    position = 0, -80
    halign = center
    valign = center
}
```

Add a keybind to lock:
```lua
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
```

---

## Step 9: Screenshots

Install grimblast (already in CachyOS repos):
```bash
sudo pacman -S grimblast-git
```

Add binds:
```lua
hl.bind("SUPER + SHIFT + P",       hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("SUPER + SHIFT + CTRL + P",hl.dsp.exec_cmd("grimblast save area"))
```

---

## Useful Links

- Wiki: https://wiki.hypr.land
- Config start: https://wiki.hypr.land/Configuring/Start/
- Variables: https://wiki.hypr.land/Configuring/Basics/Variables/
- Monitors: https://wiki.hypr.land/Configuring/Basics/Monitors/
- Binds: https://wiki.hypr.land/Configuring/Basics/Binds/
- Animations: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
- Hypr Ecosystem: https://wiki.hypr.land/Hypr-Ecosystem/

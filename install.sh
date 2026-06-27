#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Hyprland Install ==="
echo ""

# Packages
echo "[1/5] Installing packages..."
sudo pacman -S --needed \
  hyprland xdg-desktop-portal-hyprland \
  hyprcursor hyprgraphics hyprland-guiutils hyprutils hyprwayland-scanner \
  kitty waybar hyprpaper dunst \
  pipewire wireplumber playerctl brightnessctl \
  hypridle hyprlock hyprlauncher hyprpolkitagent hyprshutdown hyprsunset \
  qt5-wayland qt6-wayland dolphin \
  grimblast \
  wl-clipboard cliphist \
  network-manager-applet \
  bluez bluez-utils blueman \
  qt6ct breeze breeze-gtk \
  wofi \
  papirus-icon-theme capitaine-cursors \
  kvantum \
  ttf-fantasque-nerd

# Bluetooth
echo "[2/5] Enabling bluetooth..."
sudo systemctl enable --now bluetooth

# Config dirs
echo "[3/5] Copying configs..."
mkdir -p \
  ~/.config/hypr \
  ~/.config/waybar \
  ~/.config/kitty \
  ~/.config/qt6ct \
  ~/.config/Kvantum \
  ~/.config/dunst \
  ~/Pictures/wallpapers

cp "$REPO_DIR/configs/hypr/hyprland.lua"   ~/.config/hypr/
cp "$REPO_DIR/configs/hypr/hyprlock.conf"  ~/.config/hypr/
cp "$REPO_DIR/configs/hypr/hyprpaper.conf" ~/.config/hypr/
cp "$REPO_DIR/configs/waybar/config.jsonc" ~/.config/waybar/
cp "$REPO_DIR/configs/waybar/style.css"    ~/.config/waybar/
cp "$REPO_DIR/configs/kitty/kitty.conf"    ~/.config/kitty/
cp "$REPO_DIR/configs/qt6ct.conf"          ~/.config/qt6ct/qt6ct.conf
cp "$REPO_DIR/configs/Kvantum/kvantum.kvconfig" ~/.config/Kvantum/
cp "$REPO_DIR/configs/dunst/dunstrc"       ~/.config/dunst/

# Claude memory
echo "[4/5] Installing Claude memory..."
MEMORY_DIR="$HOME/.claude/projects/-home-marko-arch/memory"
mkdir -p "$MEMORY_DIR"
cp "$REPO_DIR/claude-memory/"* "$MEMORY_DIR/"

# NVIDIA
echo "[5/6] Checking GPU..."
if lspci | grep -qi nvidia; then
  echo "    NVIDIA detected — adding env vars to hyprland.lua"
  cat >> ~/.config/hypr/hyprland.lua << 'EOF'

-- NVIDIA (added by install.sh)
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
EOF
else
  echo "    No NVIDIA GPU found, skipping."
fi

echo "[6/6] Done."
echo ""
echo "=== Next steps ==="
echo ""
echo "1. Put your wallpaper at: ~/Pictures/wallpapers/ww-552.jpg"
echo "   (or update the path in ~/.config/hypr/hyprpaper.conf and hyprlock.conf)"
echo ""
echo "2. Check your keyboard layout in ~/.config/hypr/hyprland.lua"
echo "   Current: kb_layout = \"at\" (Austrian) — change if needed"
echo ""
echo "3. Log out and select Hyprland (UWSM) from your display manager"
echo ""
echo "4. After first boot, run: hyprctl monitors"
echo "   Then add monitor blocks to ~/.config/hypr/hyprland.lua for each monitor"
echo "   Example for two monitors:"
echo '   hl.monitor({ output = "DP-1",    mode = "preferred", position = "0x0",    scale = "auto" })'
echo '   hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "2560x0", scale = "auto" })'

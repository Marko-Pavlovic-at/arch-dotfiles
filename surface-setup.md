# Surface Pro 6 — CachyOS Setup

## Device
- **Model:** Microsoft Surface Pro 6
- **OS:** CachyOS (Arch-based)
- **Current kernel (before reboot):** 7.0.11-1-cachyos

## What Was Done

### Kernel
- Attempted Option A (linux-cachyos-surface custom kernel) — ran with errors, did not install cleanly
- Ended up with **linux-surface 6.19.8.arch1-3** (standard AUR kernel) + headers
- `vmlinuz-linux-surface` and `initramfs-linux-surface.img` confirmed present in `/boot`

### Packages Installed
| Package | Version | Purpose |
|---|---|---|
| `linux-surface` | 6.19.8.arch1-3 | Patched kernel for Surface hardware |
| `linux-surface-headers` | 6.19.8.arch1-3 | Kernel headers |
| `iptsd` | 3.1.0-1 | Touchscreen & stylus daemon (auto-starts via udev) |
| `libwacom-surface` | 2.18.0-1 | Pen pressure & button mapping |
| `linux-firmware` + variants | 20260519-1 | WiFi (Qualcomm), audio, etc. |

### iptsd
- Service is a **template** (`iptsd@.service`), not a simple service
- Has a **udev rule** (`/usr/lib/udev/rules.d/50-iptsd.rules`) that auto-starts it when the touch device appears
- No manual `systemctl enable` needed

### Secure Boot
- **Disabled** — no action needed

### GRUB
- Ran `sudo grub-mkconfig -o /boot/grub/grub.cfg` to register the surface kernel in the boot menu

---

## Next Steps After Reboot

1. Select **linux-surface** in the GRUB menu
2. Verify touchscreen works (iptsd should auto-start)
3. Verify Type Cover keyboard/trackpad works
4. Verify WiFi works
5. Camera skipped for now — can be revisited later with `libcamera`

## What Should Work on linux-surface Kernel
- WiFi (Qualcomm — covered by linux-firmware-atheros/marvell)
- Touchscreen + Stylus (iptsd auto-start via udev)
- Type Cover keyboard & trackpad
- Pen pressure (libwacom-surface)
- Volume/power buttons
- Thunderbolt
- Sleep/suspend (may have occasional quirks)

## What Is Not Set Up Yet
- Camera (IPU3) — needs `libcamera`, `gst-plugin-libcamera`

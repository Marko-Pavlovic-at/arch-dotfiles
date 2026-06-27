---
name: project-surface-setup
description: Surface kernel installation and GRUB configuration on CachyOS
metadata: 
  node_type: memory
  type: project
  originSessionId: 814a8a7f-397e-4225-8a06-bbf12758ffc9
---

# Surface Kernel Setup

Installed `linux-surface` (6.19.8.arch1-3) and `linux-surface-headers` alongside the default CachyOS kernels (`linux-cachyos` 7.0.11-1 and `linux-cachyos-lts` 6.18.33-2).

Set `linux-surface` as the GRUB default by changing `GRUB_TOP_LEVEL` in `/etc/default/grub`:

```
GRUB_TOP_LEVEL='/boot/vmlinuz-linux-surface'
```

Then regenerated GRUB config with `sudo grub-mkconfig -o /boot/grub/grub.cfg`.

**Why:** Surface-specific kernel provides better hardware support for Microsoft Surface devices.

**GRUB menu note:** The top-level entry is labeled **'CachyOS Linux'** (not 'linux-surface') — this IS the surface kernel. GRUB_TOP_LEVEL promotes it to a simple top-level entry without a kernel-specific label. The surface kernel also appears under 'Advanced options for CachyOS Linux' as a duplicate, which is normal. Always boot the top 'CachyOS Linux' entry, not the Advanced one.

**How to apply:** After any kernel update, verify `GRUB_TOP_LEVEL` still points to `vmlinuz-linux-surface` and that `vmlinuz-linux-surface` exists in `/boot`. Confirm correct boot with `uname -r` (should show `*-surface`).

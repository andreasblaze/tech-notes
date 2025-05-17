# Root FAQ

## How to reset the root password (if you don't know it)
- Reboot the machine
- Enter Grub Menu (at boot, press `Shift`, `F2` or `Esc`)
- Edit boot parameters to enter `single-user mode` or `recovery mode`
- Remount / with write access
- To set a new root password run: 
```bash 
passwd 
```
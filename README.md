# 🏠 thearesia-arch-config

Personal Arch Linux dotfiles and configuration backup.

**WM:** Hyprland  
**DE:** None (standalone WM)  
**DM:** SDDM (theme: catppuccin-mocha-lavender)  
**Shell:** bash / zsh / fish  
**Terminal:** kitty (JetBrainsMono Nerd Font Propo 11.5, 50% bg opacity)  
**Bar:** waybar (catppuccin mocha)  
**Launcher:** walker (catppuccin-mocha theme) + wofi  
**App Launcher/Session:** wlogout  
**Widgets:** eww  
**GTK Theme:** catppuccin-mocha-lavender-standard+default (dark)  
**Qt Theme:** qt6ct  
**Cursor:** default, 24px  
**Font:** JetBrainsMono Nerd Font (user-installed), Noto, Fira Sans  
**Input:** fcitx5 (IME)  
**File Manager:** dolphin (KDE)  
**Editor:** neovim v0.12.3 (LazyVim)  
**Browser:** zen  
**AUR Helper:** yay, elephant

## Configs Included

| Config | Contents |
|---|---|
| `hypr/` | Hyprland WM (monitors, binds, animations, decorations, window rules, input, autostart, env) |
| `waybar/` | Top bar with workspaces, window title, system stats, music, tray, clock, power |
| `kitty/` | Terminal emulator config + current-theme |
| `wofi/` | App launcher style |
| `walker/` | App launcher (catppuccin-mocha) |
| `wlogout/` | Session/logout layout + style |
| `eww/` | Widget system (bars, popups) |
| `nvim/` | Neovim LazyVim config (keymaps, plugins, copilot, harpoon, snacks-nvim, undotree, gruvbox) |
| `tmux/` | Tmux config with TPM plugins |
| `lazygit/` | Git TUI config |
| `fish/` | Fish shell config |
| `starship.toml` | Shell prompt |
| `gtk-3.0/` | GTK3 settings (catppuccin, font, dark mode) |
| `qt6ct/` | Qt6 settings |
| `fcitx5/` | Input method engine |
| `backgrounds/` | Wallpapers |

## Key Bindings (Hyprland)

| Key | Action |
|---|---|
| `SUPER + Q` | Open terminal (kitty) |
| `SUPER + C` | Close active window |
| `SUPER + M` | Logout menu (wlogout) |
| `SUPER + E` | File manager (dolphin) |
| `SUPER + V` | Toggle floating |
| `SUPER + R` | App launcher (walker) |
| `SUPER + B` | Open browser (zen) |
| `SUPER + O` | Open Obsidian |
| `SUPER + \` | Screenshot region (hyprshot) |
| `SUPER + Shift + \` | Screenshot window |
| `PRINT` | Screenshot output |
| `SUPER + Shift + L` | Lock screen (hyprlock) |
| `SUPER + hjkl` | Focus left/down/up/right |
| `SUPER + 1-9` | Switch workspace |

## Packages

- **Official:** `pkg-official-*.txt` (188 packages)
- **AUR:** `pkg-aur-*.txt` (59 packages)
- **Flatpak:** `pkg-flatpak-*.txt`
- **npm globals:** `pkg-npm-*.txt`

## Restore

```bash
chmod +x restore.sh
./restore.sh
```

Or manually extract the archive:

```bash
tar xzf dotfiles-backup-*.tar.gz -C ~/
```

## License

MIT

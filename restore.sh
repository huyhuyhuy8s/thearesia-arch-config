#!/bin/bash
set -e

echo "=== Arch Linux Restore Script ==="
echo "Make sure dotfiles-backup-*.tar.gz and pkg-*.txt are in this directory."

read -p "Proceed? (y/N) " -n 1 -r
echo
[[ $REPLY =~ ^[Yy]$ ]] || exit 1

# Install official packages
echo ":: Installing official packages..."
sudo pacman -S --needed - < pkg-official-*.txt

# Install AUR packages
echo ":: Installing AUR packages..."
if command -v yay &>/dev/null; then
  yay -S --needed - < pkg-aur-*.txt
elif command -v paru &>/dev/null; then
  paru -S --needed - < pkg-aur-*.txt
else
  echo "No AUR helper found. Install yay/paru first."
fi

# Install flatpaks
echo ":: Installing flatpaks..."
if command -v flatpak &>/dev/null; then
  xargs flatpak install -y < pkg-flatpak-*.txt 2>/dev/null || true
fi

# Install npm global packages
echo ":: Installing npm global packages..."
NPM_PKGS=$(tail -n +2 pkg-npm-*.txt 2>/dev/null | sed 's/@.*//' | tr '\n' ' ')
[ -n "$NPM_PKGS" ] && npm install -g $NPM_PKGS

# Restore dotfiles
echo ":: Restoring dotfiles..."
BACKUP=$(ls dotfiles-backup-*.tar.gz 2>/dev/null | head -1)
if [ -n "$BACKUP" ]; then
  tar xzf "$BACKUP" -C ~/
  echo "Dotfiles restored from $BACKUP"
else
  echo "No backup archive found!"
  exit 1
fi

echo "=== Done! Reboot recommended. ==="

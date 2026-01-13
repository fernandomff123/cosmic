#!/usr/bin/env bash
set -euo pipefail
echo "::group::Install XDG Portal & DBus for COSMIC"

# Atualiza repositórios
dnf5 makecache

# Instala pacotes necessários para XDG/Flatpak/COSMIC
dnf5 install -y \
    dbus-x11 \
    xdg-desktop-portal \
    xdg-desktop-portal-gtk \
    flatpak \
    gvfs \
    gvfs-smb \
    dbus-user-session

# Ativa systemd user session para greetd / COSMIC
systemctl enable --now dbus.socket

echo "XDG portal & DBus setup complete"
echo "::endgroup::"

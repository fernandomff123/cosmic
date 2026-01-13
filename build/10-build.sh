#!/usr/bin/bash
set -eoux pipefail

###############################################################################
# Main Build Script
# Executes in the “open” stage so rpmdb is writable
###############################################################################

echo "::group:: Copy Custom Files"

# Copiar Brewfiles
mkdir -p /usr/share/ublue-os/homebrew/
cp /ctx/custom/brew/*.Brewfile /usr/share/ublue-os/homebrew/

# Consolidar Just files
mkdir -p /usr/share/ublue-os/just/
find /ctx/custom/ujust -iname '*.just' -exec printf "\n\n" \; -exec cat {} \; >> /usr/share/ublue-os/just/60-custom.just

# Copiar Flatpak preinstall files
mkdir -p /etc/flatpak/preinstall.d/
cp /ctx/custom/flatpaks/*.preinstall /etc/flatpak/preinstall.d/

echo "::endgroup::"

echo "::group:: Install Base Packages"

# Exemplo de pacotes que sempre funcionam
dnf5 install -y tmux wget curl

# Chamar OnePassword
if [ -f /ctx/build/20-onepassword.sh ]; then
    echo "::group:: Install OnePassword"
    /ctx/build/20-onepassword.sh
    echo "::endgroup::"
fi

# Chamar Cosmic Desktop
if [ -f /ctx/build/30-cosmic-desktop.sh ]; then
    echo "::group:: Install Cosmic Desktop"
    /ctx/build/30-cosmic-desktop.sh
    echo "::endgroup::"
fi

echo "::endgroup::"

echo "::group:: System Configuration"

# Exemplo: habilitar serviços importantes
systemctl enable podman.socket
# systemctl mask unwanted-service

echo "::endgroup::"

echo "Custom build complete!"


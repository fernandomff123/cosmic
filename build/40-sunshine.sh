#!/usr/bin/env bash
set -oue pipefail

###############################################################################
# Install Sunshine (Game Streaming Host) via COPR
###############################################################################

echo "Installing Sunshine..."

# Enable Sunshine COPR repository
dnf5 -y copr enable lizardbyte/stable

# Install Sunshine (package name is case-sensitive)
dnf5 install -y Sunshine

# Remove COPR repo (repos don't persist at runtime in bootc images)
dnf5 copr remove lizardbyte/stable

# Clean up dnf cache
dnf5 clean all

echo "Sunshine installed successfully!"

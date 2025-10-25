#!/bin/bash

# Script for system restoration after reinstallation
# Restores all necessary packages for proper config operation

set -e

echo "🚀 Starting system restoration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function for message output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check for yay presence
if ! command -v yay &> /dev/null; then
    print_status "Installing yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

print_status "Updating package database..."
sudo pacman -Sy

# Main system packages
print_status "Installing main system packages..."
sudo pacman -S --noconfirm \
    base-devel \
    git \
    btop \
    fastfetch \
    lsd

# Wayland and compositor
print_status "Installing Wayland and Hyprland..."
sudo pacman -S --noconfirm \
    wayland \
    hyprland \
    hyprlock \
    hypridle \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk

# Fonts
print_status "Installing fonts..."
sudo pacman -S --noconfirm \
    ttf-jetbrains-mono-nerd \
    ttf-font-awesome \
    noto-fonts \
    noto-fonts-emoji \
    fontconfig

# Audio
print_status "Installing audio system..."
sudo pacman -S --noconfirm \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber

# Network and Bluetooth
print_status "Installing network utilities..."
sudo pacman -S --noconfirm \
    networkmanager \
    bluez \
    bluez-utils \
    blueman

# File manager
print_status "Installing file manager..."
sudo pacman -S --noconfirm \
    thunar \
    thunar-volman \
    gvfs

# Terminal and shell
print_status "Installing terminal and Fish shell..."
sudo pacman -S --noconfirm \
    kitty \
    fish

# Editor
print_status "Installing editor..."
sudo pacman -S --noconfirm \
    neovim

# Waybar and widgets
print_status "Installing Waybar and widgets..."
sudo pacman -S --noconfirm \
    waybar \
    swaync \
    wlogout

# Launcher
print_status "Installing Rofi..."
sudo pacman -S --noconfirm \
    rofi-wayland

# Screenshot and media utilities
print_status "Installing media utilities..."
sudo pacman -S --noconfirm \
    grim \
    slurp \
    wl-clipboard \
    mpv

# System utilities
print_status "Installing system utilities..."
sudo pacman -S --noconfirm \
    polkit \
    polkit-gnome \
    gtk3 \
    gtk4 \
    nwg-look

# Power management
print_status "Installing power management..."
sudo pacman -S --noconfirm \
    power-profiles-daemon

# Additional utilities (for configs)
print_status "Installing additional utilities..."
sudo pacman -S --noconfirm \
    cava

# AUR packages (optional)
echo ""
print_status "Do you want to install additional applications from AUR? (y/n)"
print_status "This includes: Brave Browser and Visual Studio Code"
read -r aur_response

if [[ "$aur_response" =~ ^[Yy]$ ]]; then
    print_status "Installing AUR packages..."
    yay -S --noconfirm \
        brave-bin \
        visual-studio-code-bin
    print_success "AUR packages installed successfully!"
else
    print_status "Skipping AUR packages installation."
fi

# Font configuration
print_status "Configuring fonts..."
sudo fc-cache -fv

# Systemd services configuration
print_status "Configuring systemd services..."
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable power-profiles-daemon

print_success "System successfully restored!"

# Ask user if they want to copy configs automatically
echo ""
print_status "Do you want to copy the configs to ~/.config/ automatically? (y/n)"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    print_status "Copying configs to ~/.config/..."

    mkdir -p "$HOME/.config"
    
    for dir in */; do
        if [ -d "$dir" ]; then
            print_status "Copying $dir to ~/.config/"
            cp -r "$dir" "$HOME/.config/"
        fi
    done
    
    for file in *.*; do
        if [ -f "$file" ] && [ "$file" != "restore_system.sh" ]; then
            print_status "Copying $file to ~/.config/"
            cp "$file" "$HOME/.config/"
        fi
    done
    
    print_success "Configs copied successfully!"
else
    print_status "Skipping config copy. You can copy them manually later."
fi

print_status "Don't forget to:"
print_status "1. Reboot the system"
print_status "2. Start Hyprland with command: Hyprland"

echo ""
print_success "🎉 Restoration completed!"

#!/bin/bash

# Скрипт для восстановления системы после переустановки
# Восстанавливает все необходимые пакеты для корректной работы конфигов

set -e

echo "🚀 Начинаем восстановление системы..."

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функция для вывода сообщений
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

# Проверка наличия yay
if ! command -v yay &> /dev/null; then
    print_status "Устанавливаем yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

print_status "Обновляем базу данных пакетов..."
sudo pacman -Sy

# Основные пакеты системы
print_status "Устанавливаем основные системные пакеты..."
sudo pacman -S --noconfirm \
    base-devel \
    git \
    btop \
    fastfetch \
    lsd

# Wayland и композитор
print_status "Устанавливаем Wayland и Hyprland..."
sudo pacman -S --noconfirm \
    wayland \
    hyprland \
    hyprlock \
    hypridle \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk

# Шрифты
print_status "Устанавливаем шрифты..."
sudo pacman -S --noconfirm \
    ttf-jetbrains-mono-nerd \
    ttf-font-awesome \
    noto-fonts \
    noto-fonts-emoji \
    fontconfig

# Аудио
print_status "Устанавливаем аудио систему..."
sudo pacman -S --noconfirm \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber

# Сеть и Bluetooth
print_status "Устанавливаем сетевые утилиты..."
sudo pacman -S --noconfirm \
    networkmanager \
    bluez \
    bluez-utils \
    blueman

# Файловый менеджер
print_status "Устанавливаем файловый менеджер..."
sudo pacman -S --noconfirm \
    thunar \
    thunar-volman \
    gvfs

# Терминал и оболочка
print_status "Устанавливаем терминал и Fish shell..."
sudo pacman -S --noconfirm \
    kitty \
    fish

# Редактор
print_status "Устанавливаем редактор..."
sudo pacman -S --noconfirm \
    neovim

# Waybar и виджеты
print_status "Устанавливаем Waybar и виджеты..."
sudo pacman -S --noconfirm \
    waybar \
    swaync \
    wlogout

# Запускатель
print_status "Устанавливаем Rofi..."
sudo pacman -S --noconfirm \
    rofi-wayland

# Утилиты для скриншотов и медиа
print_status "Устанавливаем утилиты для медиа..."
sudo pacman -S --noconfirm \
    grim \
    slurp \
    wl-clipboard \
    mpv

# Системные утилиты
print_status "Устанавливаем системные утилиты..."
sudo pacman -S --noconfirm \
    polkit \
    polkit-gnome \
    gtk3 \
    gtk4 \
    nwg-look

# Управление питанием
print_status "Устанавливаем управление питанием..."
sudo pacman -S --noconfirm \
    power-profiles-daemon

# Дополнительные утилиты (для конфигов)
print_status "Устанавливаем дополнительные утилиты..."
sudo pacman -S --noconfirm \
    cava

# AUR пакеты (если нужны)
print_status "Устанавливаем AUR пакеты..."
yay -S --noconfirm \
    brave-bin \
    visual-studio-code-bin

# Настройка шрифтов
print_status "Настраиваем шрифты..."
sudo fc-cache -fv

# Настройка systemd сервисов
print_status "Настраиваем systemd сервисы..."
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable power-profiles-daemon

print_success "Система успешно восстановлена!"
print_status "Не забудьте:"
print_status "1. Скопировать ваши конфиги в ~/.config/"
print_status "2. Перезагрузить систему"
print_status "3. Запустить Hyprland командой: Hyprland"

echo ""
print_success "🎉 Восстановление завершено!"

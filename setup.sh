#!/bin/bash

set -e

echo "🔧 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "💻 Installing basic developer tools..."
sudo apt install -y \
  build-essential \
  git \
  curl \
  wget \
  unzip \
  7zip \
  vim \
  gnome-tweaks \
  software-properties-common \
  net-tools \
  htop \
  tree \
  jq \
  libfuse2 \
  flatpak \
  gnome-software-plugin-flatpak \
  file-roller

echo "📦 Setting up Flatpak and Flathub..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "🧰 Installing Flatpak apps..."
flatpak install -y https://dl.flathub.org/repo/appstream/io.missioncenter.MissionCenter.flatpakref
flatpak install -y flathub it.mijorus.gearlever

update-desktop-database "$HOME/.local/share/applications"

echo "🧩 Installing GNOME Shell Extensions..."
sudo apt install -y gnome-shell-extensions gnome-shell-extension-prefs
flatpak install -y flathub com.mattjakeman.ExtensionManager

echo "🎨 Configuring GNOME Dock..."
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

echo "📁 Creating Templates for right-click 'New Document'..."
TEMPLATES_DIR="$HOME/Templates"
mkdir -p "$TEMPLATES_DIR"
touch "$TEMPLATES_DIR/Empty Document.txt"
touch "$TEMPLATES_DIR/Empty Script.sh"
chmod +x "$TEMPLATES_DIR/Empty Script.sh"

echo "🔐 Installing snap apps..."
sudo snap install bitwarden
sudo snap install brave
sudo snap install inkscape
sudo snap install telegram-desktop
sudo snap install --classic code

echo "📂 Creating some directories..."
mkdir -p "$HOME/Projects"

echo "✅ All done!"

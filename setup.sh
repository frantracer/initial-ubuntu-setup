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
  gnome-software-plugin-flatpak

echo "📦 Setting up Flatpak and Flathub..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "🧰 Installing Gear Lever via Flatpak..."
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

echo "🧩 Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm microsoft.gpg
sudo apt update
sudo apt install -y code

echo "🔐 Installing snap apps"
sudo snap install bitwarden
sudo snap install brave
sudo snap install inkscape

echo "Creating some directories"
mkdir -p "$HOME/Projects"

echo "✅ All done!"

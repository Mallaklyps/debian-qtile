#!/bin/bash

#Beende das Skript, sobald ein Fehler auftritt
set -e

# Modernize-sources
sudo apt modernize-sources -y


# Füge i386 Architektur hinzu
sudo dpkg --add-architecture i386


# Aktualisiere die Paketlisten und installiere Updates
sudo apt update && sudo apt full-upgrade -y


# Verhindere die Installation von ungewollten Paketen
sudo apt-mark hold desktop-base vlc evince vim-gui-common fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-core fonts-noto-extra fonts-noto-hinted fonts-noto-mono fonts-noto-ui-core fonts-noto-ui-extra fonts-noto-unhinted qsynth


# Installiere die benötigten Core-Pakete
sudo apt install -y qtile lightdm slick-greeter alacritty network-manager lxpolkit avahi-daemon fwupd acpid acpi curl bluez cups firmware-linux linux-headers-amd64


# Installiere UI-Pakete
sudo apt install -y rofi dunst libnotify-bin picom nwg-look feh gtk3-nocsd papirus-icon-theme qt6-style-kvantum sassc gtk2-engines-murrine


# Installiere File Manager
sudo apt install -y thunar thunar-archive-plugin gvfs-backends ranger trash-cli fzf smbclient cifs-utils xdg-user-dirs-gtk eza ueberzug atool rar unrar xfburn

xdg-user-dirs-update
sudo mkdir /usr/share/desktop-directories


# Installiere Audio-Pakete
sudo apt install -y pipewire-audio pulsemixer audacity mpd ncmpcpp cava


# Installiere Utilities und Programme
sudo apt install -y cmatrix figlet bat fastfetch neomutt calcurse sc-im htop ripgrep zoxide entr pipes-sh mpv flameshot i3lock-fancy gufw calibre obs-studio gimp xdg-desktop-portal-gtk virt-manager libreoffice libreoffice-l10n-de libreoffice-gtk3 hunspell-de-de mythes-de hyphen-de zathura fonts-recommended ttf-mscorefonts-installer starship keepassxc-full


# Installiere Nvidia-Driver

wget https://developer.download.nvidia.com/compute/cuda/repos/debian13/x86_64/cuda-keyring_1.1-1_all.deb
sudo apt install -y ./cuda-keyring_1.1-1_all.deb
sudo apt update && sudo apt install -y nvidia-driver-pinning-595

sudo apt install -y nvidia-driver nvidia-kernel-open-dkms nvidia-settings libnvoptix1 cuda-toolkit nvidia-driver-libs:i386

echo "panic=0 ro quiet loglevel=2 nvidia-drm.modeset=1 nvidia-drm.fbdev=1" | sudo tee -a /etc/kernel/cmdline

#echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX loglevel=2 nvidia-drm.modeset=1 nvidia-drm.fbdev=1"' | sudo tee /etc/default/grub.d/nvidia-modeset.cfg
#sudo update-grub

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service


#Installiere und aktiviere zram
sudo apt install -y systemd-zram-generator

sudo systemctl daemon-reload
sudo systemctl start systemd-zram-setup@zram0.service

echo "[zram0]
zram-size = ram / 2" | sudo tee /etc/systemd/zram-generator.conf



# Installiere Gaming Pakete
sudo apt install -y steam scummvm lutris gamemode

mkdir -p ~/Games/Steam
ln -s ~/Games/Steam ~/.steam


# Installiere Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

sudo apt update && sudo apt install -y brave-browser


# Installiere Mixxx
sudo apt install -y ./mixxx-2.5.6-10-g2f9bf8ebad-x86_64.deb


# Installiere Neovim
sudo apt install -y ./nvim-linux-x86_64.deb


# Installiere Gamescope
sudo apt install -y ./gamescope_3.16.15-2_amd64.deb


# Installiere Bluetui
sudo cp bluetui /usr/bin
sudo chmod +x /usr/bin/bluetui


# Konfiguriere lightdm
sudo sed -i 's/#user-session=.*/user-session=qtile/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/#display-setup-script=/display-setup-script=\/etc\/lightdm\/lightdm-xrandr.sh/g' /etc/lightdm/lightdm.conf

sudo cp lightdm-xrandr.sh /etc/lightdm/
sudo chmod +x /etc/lightdm/lightdm-xrandr.sh

sudo cp slick-greeter.conf /etc/lightdm/


# Installiere Nerd-Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
sudo unzip JetBrainsMono.zip -d "/usr/share/fonts/JetBrainsMono"

fc-cache -f


# Installiere Catppuccin GTK Theme & Cursor
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git
sudo ~/debian-qtile/Catppuccin-GTK-Theme/themes/./install.sh --tweaks frappe float -t blue -c dark -l -d /usr/share/themes

wget https://github.com/catppuccin/cursors/releases/download/v2.0.0/catppuccin-frappe-dark-cursors.zip
sudo unzip catppuccin-frappe-dark-cursors.zip -d "/usr/share/icons"
mkdir ~/.icons


# Installiere Grub Theme
#git clone https://github.com/catppuccin/grub.git
#sudo mkdir -p /usr/share/grub/themes
#sudo cp -r ~/debian-qtile/grub/src/catppuccin-frappe-grub-theme /usr/share/grub/themes/catppuccin-frappe-grub-theme
#echo "GRUB_THEME="/usr/share/grub/themes/catppuccin-frappe-grub-theme/theme.txt"" | sudo tee -a /etc/default/grub
#echo "GRUB_GFXMODE=1920x1080" | sudo tee -a /etc/default/grub
#sudo cp logo.png /usr/share/grub/themes/catppuccin-frappe-grub-theme/
#sudo update-grub


# Kopiere bashrc


# Kopiere Hintergrundbilder
sudo mkdir /usr/share/backgrounds
sudo cp forest.jpg /usr/share/backgrounds
sudo cp valley.jpg /usr/share/backgrounds


# Kopiere .config
cp -r .config ~/
chmod +x ~/.config/ranger/scope.sh


#Aktiviere Firewall
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing


# Füge Backports hinzu
echo "Types: deb
URIs: http://deb.debian.org/debian
Suites: trixie-backports
Components: main contrib non-free non-free-firmware
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" | sudo tee /etc/apt/sources.list.d/debian-backports.sources


#Installiere Kernel aus den Backports & aktiviere NTsync
sudo apt update && sudo apt install -y -t trixie-backports linux-image-amd64 linux-headers-amd64 firmware-linux

echo "ntsync" | sudo tee /etc/modules-load.d/ntsync.conf


# Deinstalliere X-Term & Cleanup
sudo apt purge -y xterm
sudo apt modernize-sources -y
sudo apt autopurge -y
sudo apt autoclean
sudo apt clean


echo "Die Installation ist abgeschlossen. Bitte starte deinen Rechner neu, damit die Änderungen wirksam werden."

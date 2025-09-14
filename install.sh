#!/bin/bash

# Modernize-sources
sudo apt modernize-sources -y


# Füge i386 Architektur hinzu
sudo dpkg --add-architecture i386


# Aktualisiere die Paketlisten
sudo apt update && sudo apt full-upgrade -y


# Verhindere die Installation von ungewollten Paketen
sudo apt-mark hold desktop-base xterm vlc fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-core fonts-noto-extra fonts-noto-hinted fonts-noto-hinted-udeb fonts-noto-mono fonts-noto-ui-core fonts-noto-ui-extra fonts-noto-unhinted fonts-noto-unhinted-udeb qsynth


# Installiere die benötigten Core-Pakete
sudo apt install -y qtile lightdm slick-greeter alacritty network-manager lxpolkit avahi-daemon acpid acpi curl bluez


# Installiere UI-Pakete
sudo apt install -y rofi dunst feh nwg-look


# Installiere File Manager
sudo apt install -y thunar thunar-archive-plugin gvfs-backends ranger smbclient cifs-utils xdg-user-dirs-gtk eza


# Installiere Audio-Pakete
sudo apt install -y pipewire-audio pulsemixer audacity mixxx mpd ncmpcpp cava


# Installiere Utilities und Programme
sudo apt install -y neovim cmatrix figlet mpv qimgv flameshot gimp libreoffice libreoffice-l10n-de hunspell-de-de mythes-de hyphen-de zathura fonts-recommended starship keepassxc-full


# Installiere Nvidia-Driver
#sudo apt install -y nvidia-driver-full nvidia-kernel-dkms firmware-misc-nonfree nvidia-driver-libs:i386 nvidia-cuda-dev nvidia-cuda-toolkit

#sudo echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1 nvidia-drm.fbdev=1"' > /etc/default/grub.d/nvidia-modeset.cfg

#sudo update-grub

#sudo systemctl enable nvidia-suspend.service
#sudo systemctl enable nvidia-hibernate.service
#sudo systemctl enable nvidia-resume.service


# Installiere Gaming Pakete
sudo apt install -y steam scummvm lutris xwayland libeis1 libliftoff0 libluajit-5.1-2

sudo dpkg -i gamescope_3.16.15-2_amd64.deb


#Installiere Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

sudo apt update && sudo apt install -y brave-browser


# Installiere Pfetch
sudo cp pfetch /usr/bin
sudo chmod +x /usr/bin/pfetch


# Installiere Bluetui
sudo cp bluetui /usr/bin
sudo chmod +x /usr/bin/bluetui


# Konfiguriere lightdm
sudo sed -i 's/#user-session=.*/user-session=qtile/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/#display-setup-script=.*/display-setup-script=/etc/lightdm/lightdm-xrandr.sh/g' /etc/lightdm/lightdm.conf

sudo cp lightdm-xrandr.sh /etc/lightdm
sudo chmod +x /etc/lightdm/lightdm-xrandr.sh


# Installiere Nerd-Fonts


# Kopiere bashrc


# Kopiere .config
cp -r .config ~/

echo "Die Installation ist abgeschlossen. Bitte starte deinen Rechner neu, damit die Änderungen wirksam werden."

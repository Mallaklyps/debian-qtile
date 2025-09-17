#!/bin/bash

# Modernize-sources
sudo apt modernize-sources -y


# Füge i386 Architektur hinzu
sudo dpkg --add-architecture i386


# Aktualisiere die Paketlisten
sudo apt update && sudo apt full-upgrade -y


# Verhindere die Installation von ungewollten Paketen
sudo apt-mark hold desktop-base xterm xterm:i386 pterm qmlkonsole vlc fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-core fonts-noto-extra fonts-noto-hinted fonts-noto-mono fonts-noto-ui-core fonts-noto-ui-extra fonts-noto-unhinted qsynth


# Installiere die benötigten Core-Pakete
sudo apt install -y qtile lightdm slick-greeter alacritty network-manager lxpolkit avahi-daemon fwupd acpid acpi curl bluez cups


# Installiere UI-Pakete
sudo apt install -y rofi dunst feh nwg-look gtk3-nocsd papirus-icon-theme qt6-style-kvantum sassc gtk2-engines-murrine


# Installiere File Manager
sudo apt install -y thunar thunar-archive-plugin gvfs-backends ranger trash-cli fzf smbclient cifs-utils xdg-user-dirs-gtk eza ueberzug atool rar unrar

xdg-user-dirs-update
sudo mkdir /usr/share/desktop-directories


# Installiere Audio-Pakete
sudo apt install -y pipewire-audio pulsemixer audacity mixxx mpd ncmpcpp cava


# Installiere Utilities und Programme
sudo apt install -y neovim cmatrix figlet bat ripgrep zoxide entr pipes-sh mpv qimgv flameshot snapper-gui i3lock-fancy gufw calibre obs-studio gimp xdg-desktop-portal-gtk virt-manager libreoffice libreoffice-l10n-de libreoffice-gtk3 hunspell-de-de mythes-de hyphen-de zathura fonts-recommended ttf-mscorefonts-installer starship keepassxc-full


# Installiere Nvidia-Driver
#sudo apt install -y nvidia-driver-full nvidia-kernel-dkms firmware-misc-nonfree nvidia-driver-libs:i386 nvidia-cuda-dev nvidia-cuda-toolkit

#echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1 nvidia-drm.fbdev=1"' | sudo tee /etc/default/grub.d/nvidia-modeset.cfg

#sudo update-grub

#sudo systemctl enable nvidia-suspend.service
#sudo systemctl enable nvidia-hibernate.service
#sudo systemctl enable nvidia-resume.service


# Installiere Gaming Pakete
sudo apt install -y steam scummvm lutris xwayland libeis1 libliftoff0 libluajit-5.1-2 libwlroots-0.18 gamemode

sudo dpkg -i gamescope_3.16.15-2_amd64.deb

mkdir -p ~/Games/Steam
ln -s ~/Games/Steam ~/.steam


# Installiere Brave Browser
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
sudo sed -i 's/#display-setup-script=/display-setup-script=\/etc\/lightdm\/lightdm-xrandr.sh/g' /etc/lightdm/lightdm.conf

sudo cp lightdm-xrandr.sh /etc/lightdm/
sudo chmod +x /etc/lightdm/lightdm-xrandr.sh


# Installiere Nerd-Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
sudo unzip JetBrainsMono.zip -d "/usr/share/fonts"

fc-cache -f


# Installiere Catppuccin GTK Theme & Cursor
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git
sudo ~/debian-qtile/Catppuccin-GTK-Theme/themes/./install.sh --tweaks frappe float -t blue -c dark -l -d /usr/share/themes

wget https://github.com/catppuccin/cursors/releases/download/v2.0.0/catppuccin-frappe-dark-cursors.zip
sudo unzip catppuccin-frappe-dark-cursors.zip -d "/usr/share/icons"
mkdir ~/.icons


# Installiere Grub Theme
git clone https://github.com/catppuccin/grub.git
sudo mkdir /usr/share/grub/themes/catppuccin-frappe-grub-theme
sudo cp -r ~/debian-qtile/grub/src/catppuccin-frappe-grub-theme /usr/share/grub/themes/catppuccin-frappe-grub-theme/
echo "GRUB_THEME="/usr/share/grub/themes/catppuccin-frappe-grub-theme/theme.txt"" | sudo tee -a /etc/default/grub
sudo update-grub


# Kopiere bashrc


# Kopiere .config
cp -r .config ~/

echo "Die Installation ist abgeschlossen. Bitte starte deinen Rechner neu, damit die Änderungen wirksam werden."

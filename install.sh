#!/bin/bash

# This is a simple installation shell script to
# install the thinkpad hyprland configuration

SCRIPT_PATH=$(realpath "$0")
DOTFILES_PATH="$SCRIPT_PATH/dotfiles"

cat << EOF
  _______ _     _       _    _____          _ 
 |__   __| |   (_)     | |  |  __ \        | |
    | |  | |__  _ _ __ | | _| |__) |_ _  __| |
    | |  | '_ \| | '_ \| |/ /  ___/ _\` |/ _\` |
    | |  | | | | | | | |   <| |  | (_| | (_| |
    |_|  |_| |_|_|_| |_|_|\_\_|   \__,_|\__,_|
────────────────────────────────────────────────
Rememebre that before to install theese dotfiles
you need to manualy install the necessary
dependencies for the configs that include\n

EOF

read -p "Press enter to continue..."
echo -e "\n"

# Downloading themes, icons and other
echo "Creating a work directory..."
mkdir $SCRIPT_PATH/work && cd $SCRIPT_PATH/work
echo "Downloading the gtk theme..."
git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
echo "Downloading the cursor theme..."
git clone https://github.com/vinceliuice/Graphite-cursors.git
echo "Downloading the icon theme..."
git clone https://github.com/vinceliuice/Tela-icon-theme.git
echo "Downloading trueline..."
git clone https://github.com/petobens/trueline

# Installing themes, icons and other
echo "Installing the gtk theme..."
cd Graphite-gtk-theme
./install.sh -c dark -s compact -l --tweaks rimless normal black && cd ..
echo "Installing the cursor theme..."
cd Graphite-cursors && ./install.sh && cd ..
echo "Installing the icon theme..."
cd Tela-icon-theme && ./install.sh grey && cd ..
echo "Installing trueline..."
cp trueline ~/.trueline && cd ..
echo "Removing work folder..."
rm -rf work

# Applying themes and fonts
echo "Setting up themes, icons and other..."
gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark-compact'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Graphite-dark-cursors'
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface icon-theme 'Tela-grey-dark'
gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font 10'

# Installing dotfiles
echo "Installing dotfiles..."
cp -rf $DOTFILES_PATH/* $HOME
echo "Everything done!"

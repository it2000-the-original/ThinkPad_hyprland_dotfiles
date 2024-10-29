#!/bin/bash

# This is a simple installation bash script to
# install the ThinkPad hyprland configuration

readonly GTK_THEME="Graphite-gtk-theme"
readonly CUR_THEME="Graphite-cursors"
readonly ICO_THEME="Tela-icon-theme"
readonly POWERLINE="trueline"

readonly GTK_THEME_REPO="https://github.com/vinceliuice/"$GTK_THEME".git"
readonly CUR_THEME_REPO="https://github.com/vinceliuice/"$CUR_THEME".git"
readonly ICO_THEME_REPO="https://github.com/vinceliuice/"$ICO_THEME".git"
readonly POWERLINE_REPO="https://github.com/petobens/"$POWERLINE".git"

readonly DOTFILES_FOLDER_NAME="dotfiles"
readonly SCRIPT_PATH=$(realpath $(dirname "$0"))
readonly DOTFILES_PATH="$SCRIPT_PATH/$DOTFILES_FOLDER_NAME"
readonly WORK_DIR="$SCRIPT_PATH/work"
readonly CURRENT_DIR=$(pwd)

# Array of folder names of the configs
# that must be installed in the .config folder

readonly CONFIGS=(
  "fastfetch"
  "gtk-3.0"
  "hypr"
  "kitty"
  "neofetch"
  "rofi"
  "swaync"
  "waybar"
  "wlogout"
  "wob"
  "gammastep"
)

readonly BACKGROUNDS=(
  "thinkpad_wallpaper.png"
  "thinkpad_wallpaper_centered.png"
)

function print_tp_logo {

  # Print the ThinkPad logo

  printf "\033[1;97m _______ _     \033[31m_\033[97m       _    _____          _ \n"
  printf "|__   __| |   \033[31m(_)\033[97m     | |  |  __ \        | |\n"
  printf "   | |  | |__  _ _ __ | | _| |__) |_ _  __| |\n"
  printf "   | |  | '_ \| | '_ \| |/ /  ___/ _\` |/ _\` |\n"
  printf "   | |  | | | | | | | |   <| |  | (_| | (_| |\n"
  printf "   |_|  |_| |_|_|_| |_|_|\_\_|   \__,_|\__,_|\033[0m\n"
}

function print_installation_message {

  print_tp_logo

  printf "
This script will install configs for: hyprland, fastfetch, kitty,
neofetch, rofi, swaync, waybar wlogout, bash, wob and gammastep. 

\033[1;93mWARNING: I strongly recomendo you to create a backup of you configs
because this script will override every config installed in your
home folder (It doesn't have the function to automatically create a backup)
and, remember to install the necessary dependencies mensioned in the README.md
\033[0m\n"

  printf "\033[1;97m"
  read -p "Press enter to continue..."
  printf "\033[0m\n"
}

function print_uninstallation_message {

  print_tp_logo

  printf "
This script will delete the folders in the $HOME/.config folder containing the
config for: hyprland, fastfetch, kitty, neofetch, rofi, swaync, waybar wlogout, wob,
bash and gammastep. 

\033[1;93mWARNING: Every software will return to default settings. After the execution of
this script, estore your backup if you have it
\033[0m\n"

  printf "\033[1;97m"
  read -p "Press enter to continue..."
  printf "\033[0m\n"
}

function create_work_dir {

  # Remove the work folder if it already exist

  if [ -d "$WORK_DIR" ]; then
    printf "\033[1m=> \033[93mThe work folder already exist!\033[0m\n"
    printf "\033[1m=> Removing the work folder...\033[0m\n"
    rm -rf "$WORK_DIR"
  fi

  # Create the work folder

  printf "\033[1m=> Creating a work directory...\033[0m\n"
  mkdir -p "$WORK_DIR"
}

function download_repos {

  # Downloading themes, icons and other

  printf "\n\033[1m:: \033[34mDownloading the gtk theme...\033[0m\n\n"
  git clone "$GTK_THEME_REPO" "$WORK_DIR/$GTK_THEME"
  printf "\n\033[1m:: \033[34mDownloading the cursor theme...\033[0m\n\n"
  git clone "$CUR_THEME_REPO" "$WORK_DIR/$CUR_THEME"
  printf "\n\033[1m:: \033[34mDownloading the icon theme...\033[0m\n\n"
  git clone "$ICO_THEME_REPO" "$WORK_DIR/$ICO_THEME"
  printf "\n\033[1m:: \033[34mDownloading trueline...\033[0m\n\n"
  git clone "$POWERLINE_REPO" "$WORK_DIR/$POWERLINE"
}

function install_theme {

  printf "\n\033[1m=> \033[32mInstalling the gtk theme...\033[0m\n\n"
  cd "$WORK_DIR/$GTK_THEME"
  bash "install.sh" -c dark -s compact -l --tweaks rimless normal black
}

function uninstall_theme {

  printf "\n\033[1m=> \033[32mUninstalling the gtk theme...\033[0m\n\n"
  cd "$WORK_DIR/$GTK_THEME"
  bash "install.sh" -u -r
}

function install_cursors {

  printf "\n\033[1m=> \033[32mInstalling the cursor theme...\033[0m\n\n"
  cd "$WORK_DIR/$CUR_THEME"
  bash "install.sh"
}

function uninstall_cursors {

  printf "\n\033[1m=> \033[32mUninstalling the cursor theme...\033[0m\n\n"
  rm -rf "$HOME/.local/share/icons/Graphite-*-cursors"
}

function install_icons {

  printf "\n\033[1m=> \033[32mInstalling the icon theme...\033[0m\n\n"
  cd "$WORK_DIR/$ICO_THEME"
  bash "install.sh" grey
}

function uninstall_icons {

  printf "\n\033[1m=> \033[32mUninstalling the icon theme...\033[0m\n\n"
  cd "$WORK_DIR/$ICO_THEME"
  bash "install.sh" -r
}

function install_powerline {

  printf "\n\033[1m=> \033[32mInstalling trueline...\033[0m\n\n"
  cp -rf "$WORK_DIR"/"$POWERLINE" "$HOME/.$POWERLINE"
}

function uninstall_powerline {

  printf "\n\033[1m=> \033[32mUninstalling trueline...\033[0m\n\n"
  rm -rf "$HOME/.$POWERLINE"
}

function install_dependencies {

  install_theme
  install_cursors
  install_icons
  install_powerline
}

function uninstall_dependencies {

  uninstall_theme
  uninstall_cursors
  uninstall_icons
  uninstall_powerline
}

function clean {

  # Remove work folder
  
  printf "\033[1m=> Removing work folder...\033[0m\n"
  cd "$CURRENT_DIR"
  rm -rf "$WORK_DIR"
}

function set_interface_settings {

  # Applying themes and fonts

  printf "\033[1m=> Setting up themes, icons and other...\033[0m\n\n"
  gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark-compact'
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  gsettings set org.gnome.desktop.interface cursor-theme 'Graphite-dark-cursors'
  gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
  gsettings set org.gnome.desktop.interface icon-theme 'Tela-grey-dark'
  gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font 10'
}

function reset_interface_settings {

  # Set every interface setting to default

  printf "\033[1m=> Resetting themes, icons and other to default...\033[0m\n\n"
  gsettings reset org.gnome.desktop.interface gtk-theme
  gsettings reset org.gnome.desktop.interface color-scheme
  gsettings reset org.gnome.desktop.interface cursor-theme
  gsettings reset org.gnome.desktop.interface font-name
  gsettings reset org.gnome.desktop.interface icon-theme
  gsettings reset org.gnome.desktop.interface monospace-font-name
}

function install_configs {

  # Install elements in the .config folder

  for CFG in ${CONFIGS[@]}; do
    printf "\033[1;32mInstalling $CFG config...\033[0m\n"
    cp -rf "$DOTFILES_PATH/.config/$CFG" "$HOME/.config/"
  done
}

function uninstall_configs {

  # Remove all configs in the .config folder
  
  for CFG in ${CONFIGS[@]}; do
    printf "\033[1;32mRemoving $CFG config...\033[0m\n"
    rm -rf "$HOME/.config/$CFG"
  done
}

function install_locals {

  # Install element in the .local folder
  
  printf "\033[1;32mInstalling backgrounds...\033[0m\n"
  cp -rf "$DOTFILES_PATH/.local/share/backgrounds" "$HOME/.local/share/"

  printf "\033[1;32mInstalling rofi theme...\033[0m\n"
  cp -rf "$DOTFILES_PATH/.local/share/rofi" "$HOME/.local/share/"
}

function uninstall_locals {
  
  # Remove element from the .local folder
  
  printf "\033[1;32mRemoving backgrounds...\033[0m\n"

  for BG in ${BACKGROUNDS[@]}; do
    rm -f "$HOME/.local/share/backgrounds/$BG"
  done

  printf "\033[1;32mRemoving rofi theme...\033[0m\n"
  rm -f "$HOME/.local/share/rofi/themes/rounded-common.rasi"
}

function install_home {

  # Install elements in the home folder

  printf "\033[1;32mInstalling some last things...\033[0m\n"
  cp -rf "$DOTFILES_PATH/.bashrc" "$HOME"
  cp -rf "$DOTFILES_PATH/.gtkrc-2.0" "$HOME"
}

function uninstall_home {

  # Install elements in the home folder

  printf "\033[1;32mRemoving some last things...\033[0m\n"
  rm -f "$HOME/.bashrc"
  rm -f "$HOME/.gtkrc-2.0"
}

function set_wob_pipes {

  # Create pipes for wob
  
  readonly PIPES_DIR="$HOME/.config/wob/pipes"

  if [ -d "$PIPES_DIR" ]; then
    rm -rf "$PIPES_DIR"
  fi

  printf "\033[1mSetting wob pipes...\033[0m\n"
  mkdir  "$PIPES_DIR"
  mkfifo "$PIPES_DIR/volumepipe"
  mkfifo "$PIPES_DIR/source_volumepipe"
  mkfifo "$PIPES_DIR/brightnesspipe"
}

function install_dots {

  printf "\033[1m=> \033[32mInstalling dots...\033[0m\n\n"

  install_configs
  install_locals
  install_home

  set_wob_pipes
}

function uninstall_dots {

  printf "\033[1m=> \033[32mUninstalling dots...\033[0m\n\n"

  uninstall_configs
  uninstall_locals
  uninstall_home
}

if [ -z "$1" ]; then

  print_installation_message
  create_work_dir
  download_repos
  install_dependencies
  clean
  set_interface_settings
  install_dots
  printf "\n\033[1m=> Everything done!\033[0m\n"

elif [[ "$1" == "-u" || "$1" == "--uninstall" ]]; then

  print_uninstallation_message
  create_work_dir
  download_repos
  uninstall_dependencies
  clean
  reset_interface_settings
  uninstall_dots
  printf "\n\033[1m=> Everything done! Now restore your backups\033[0m\n"

else

  printf "\033[1;31mERROR: Unknow option \"$1\"\033[0m\n"

fi

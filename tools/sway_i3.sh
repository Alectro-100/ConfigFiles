#!/bin/bash

HOME=$HOME

sudo -v

command -v pacman >/dev/null 2>&1 || { echo "pacman is required but not found. Exiting."; exit 1; }

function install() {
    local TOOL="$@"
    sudo pacman -S --needed "${TOOL}" --noconfirm
    if [ $? -ne 0 ]; then
        echo "Error installing ${TOOL}. Exiting."
        exit 1
    fi
}

function install_software() {
    echo "Installing software packages..."
    install sway swaybg sway-contrib swayidle swayimg swaylock swaync
    install wofi
    install foot

    install i3blocks i3lock i3status i3status-rust i3-wm
    install rofi
    install alacritty

    echo "Installing additional packages..."
    install git
    install neovim
    install vim
}

function copy_configs() {
    echo "Copying configuration files..."
    if [ ! -d "$HOME/.config/sway" ]; then
        mkdir -p "$HOME/.config/sway/" "$HOME/.config/waybar/" "$HOME/.config/foot/"
        cp -r ./sway_config/* "$HOME/.config/sway/"
        cp ./sway_config/foot/foot.ini "$HOME/.config/foot/"
        cp -r ./waybar_config/* "$HOME/.config/waybar/"
    fi
    if [ ! -d "$HOME/.config/i3" ]; then
        mkdir -p "$HOME/.config/i3/" "$HOME/.config/polybar/" "$HOME/.config/alacritty/"
        cp -r ./i3_config/* "$HOME/.config/i3/"
    fi
}


function configure_vim_and_neovim() {
    if [[ ! -f "$HOME/.vimrc" ]]; then
        touch "$HOME/.vimrc"
        cp ./vim_config/vimrc "$HOME/.vimrc"
    fi
    if [[ ! -f "$HOME/.config/nvim/init.vim" ]]; then
        mkdir -p "$HOME/.config/nvim/init.vim"
        cp ./nvim_config/init.vim "$HOME/.config/nvim/"
    fi
}

read -p "Do you want to install the software packages? (y/n): " yn
case $yn in
    [Yy]* ) install_software;;
    [Nn]* ) echo "Installation aborted."; exit 0;;
        * ) echo "Please answer yes or no."; exit 1;;
esac

read -p "Do you want to copy the configuration files? (y/n): " yn
case $yn in
    [Yy]* ) copy_configs
            ;;
    [Nn]* ) echo "Configuration copying aborted."; exit 0
            ;;
        * ) echo "Please answer yes or no."; exit 1
            ;;
esac

read -p "Do you want to set up vim and neovim? (y/n)" yn
if [[ $yn =~ ^[Yy]$ ]]; then
    configure_vim_and_neovim
fi
echo "Setup complete!"


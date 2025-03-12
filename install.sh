#!/usr/bin/env bash

clear
echo ""
echo "    Dotfile and Config Setup Starting"
echo "=========================================="
echo ""

#####################################
###          Dependencies         ###
#####################################
if [[ "${OSTYPE}" == "linux"* ]]; then
    echo "Handling Linux Dependencies"
elif [[ "${OSTYPE}" == "darwin"* ]]; then
    echo "Handling MacOS Dependencies"
fi

#####################################
###          Functions            ###
#####################################

# Determine if file is symlink or reg file and backup appropriately
function backupFile() {
    if [[ -d $1 ]]; then
        cp -rf $1 $2 && rm -rf $1 && \
        echo "Backup: $2"
    elif [[ -f $1 ]]; then
        mv $1 $2 && \
        echo "Backup: $2"
    else
        echo "File $1 does not exist, skipping backup."
    fi
}

#####################################
###          Symlinks             ###
#####################################

echo ""; echo "Linking .zshrc"
backupFile \
    $HOME/.zshrc \
    $HOME/.zshrc.bak
ln -s $HOME/.dotfiles/dotfiles/dot_zshrc $HOME/.zshrc

echo ""; echo "Linking ghostty"
backupFile \
    $HOME/.config/ghostty \
    $HOME/.config/ghostty.bak
ln -s $HOME/.dotfiles/dotconfigs/ghostty $HOME/.config/ghostty

echo ""; echo "Linking starship"
backupFile \
    $HOME/.config/starship.toml \
    $HOME/.config/starship.toml.bak
ln -s $HOME/.dotfiles/dotconfigs/starship.toml $HOME/.config/starship.toml

echo ""; echo "Linking tmux"
backupFile \
    $HOME/.tmux.conf \
    $HOME/.tmux.conf.bak
ln -s $HOME/.dotfiles/dotfiles/dot_tmux $HOME/.tmux.conf


echo ""; echo "Linking zed files"
backupFile \
    $HOME/.config/zed/settings.json \
    $HOME/.config/zed/settings.json.bak
ln -s $HOME/.dotfiles/dotconfigs/zed/settings.json $HOME/.config/zed/settings.json
backupFile \
    $HOME/.config/zed/keymap.json \
    $HOME/.config/zed/keymap.json.bak
ln -s $HOME/.dotfiles/dotconfigs/zed/keymap.json $HOME/.config/zed/keymap.json

echo ""; echo "Linking neovim"
backupFile \
    $HOME/.config/nvim \
    $HOME/.config/nvim.bak
ln -s $HOME/.dotfiles/dotconfigs/nvim $HOME/.config/nvim

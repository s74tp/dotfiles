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

    echo "[*] Handling MacOS Dependencies"
    if ! command -v brew &>/dev/null; then
        echo "[+] Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "[+] Installing brew packages"
    brew install lima tealdeer litecli tmux go bat pipx htop httpie coreutils ffmpeg neovim ripgrep eza fd nmap node yt-dlp fzf gcc zig starship

    echo "[+] Installing brew casks"
    brew install --cask appcleaner brave-browser ghostty iina zed

    if ! command -v bun &>/dev/null; then
        echo "[+] Installing bun"
        curl -fsSL https://bun.sh/install | bash
    fi
fi
#####################################
###          Functions            ###
#####################################

# Determine if file is symlink or reg file and backup appropriately
function backupFile() {
    # if its a symlinked, remove it
    if [[ -L $1 ]]; then
        rm -rf $1
    fi
    mv $1 $2 &>/dev/null && echo "[!] Backup: $2"
}

#####################################
###          Symlinks             ###
#####################################

echo "[*] Linking .zshrc"
backupFile \
    $HOME/.zshrc \
    $HOME/.zshrc.bak
ln -s $HOME/.dotfiles/dotfiles/dot_zshrc $HOME/.zshrc

echo [*] "Linking ghostty"
backupFile \
    $HOME/.config/ghostty \
    $HOME/.config/ghostty.bak
ln -s $HOME/.dotfiles/dotconfigs/ghostty $HOME/.config/ghostty

echo [*] "Linking starship"
backupFile \
    $HOME/.config/starship.toml \
    $HOME/.config/starship.toml.bak
ln -s $HOME/.dotfiles/dotconfigs/starship.toml $HOME/.config/starship.toml

echo [*] "Linking tmux"
backupFile \
    $HOME/.tmux.conf \
    $HOME/.tmux.conf.bak
ln -s $HOME/.dotfiles/dotfiles/dot_tmux $HOME/.tmux.conf

echo [*] "Linking zed files"
backupFile \
    $HOME/.config/zed/settings.json \
    $HOME/.config/zed/settings.json.bak
ln -s $HOME/.dotfiles/dotconfigs/zed/settings.json $HOME/.config/zed/settings.json
backupFile \
    $HOME/.config/zed/keymap.json \
    $HOME/.config/zed/keymap.json.bak
ln -s $HOME/.dotfiles/dotconfigs/zed/keymap.json $HOME/.config/zed/keymap.json

echo [*] "Linking neovim"
backupFile \
    $HOME/.config/nvim \
    $HOME/.config/nvim.bak
ln -s $HOME/.dotfiles/dotconfigs/nvim $HOME/.config/nvim

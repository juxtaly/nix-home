#!/bin/bash
set -e

install_nix() {
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
    # curl -L https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install | sh
    . $HOME/.nix-profile/etc/profile.d/nix.sh
}

install_home_manager() {
    mkdir -p $HOME/.config
    ln -s $(pwd) $HOME/.config/nixpkgs
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    export NIX_PATH=$HOME/.nix-defexpr/channels:${NIX_PATH:+:$NIX_PATH}
    nix-shell '<home-manager>' -A install
    . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
}

generate_user_home() {
    sed -e "s?@HOME@?${HOME}?" -e "s?@USER@?${USER}?" ./user.nix.in > ./user.nix
}

if ! command -v nix &> /dev/null; then
    echo "Installing nix..."
    install_nix
else
    echo "Nix is already installed."
fi

test -e ./user.nix || generate_user_home

if ! command -v home-manager &> /dev/null; then
    echo "Installing home-manager..."
    install_home_manager
else
    echo "Home-manager is already installed."
fi